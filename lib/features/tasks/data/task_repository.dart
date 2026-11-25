import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../domain/task.dart';
import '../domain/task_priority.dart';
import '../domain/task_status.dart';

/// Persistence of tasks and sub-tasks.
abstract interface class TaskRepository {
  /// Tasks of a list (Inbox when [listId] is `null`), pinned first.
  Stream<List<Task>> watchByList(String? listId);

  /// Sub-tasks of a task.
  Stream<List<Task>> watchChildren(String parentId);

  Future<Task?> findById(String id);

  Future<Task> create({
    required String title,
    String? listId,
    String? parentId,
    String? sectionId,
    String? description,
    TaskPriority priority = TaskPriority.none,
    DateTime? dueAt,
    bool isAllDay = false,
    String? recurrenceRule,
    List<Duration> reminders = const <Duration>[],
    int? estimatedMinutes,
    int? estimatedPomodoros,
  });

  Future<void> update(
    String id, {
    String? title,
    String? description,
    TaskPriority? priority,
    DateTime? dueAt,
    bool clearDueAt = false,
    bool? isAllDay,
    String? listId,
    bool clearList = false,
    String? sectionId,
    bool? isPinned,
    List<Duration>? reminders,
    String? recurrenceRule,
    bool clearRecurrence = false,
    int? sortOrder,
  });

  /// Moves a task between statuses and keeps `completed_at` consistent.
  Future<void> setStatus(String id, TaskStatus status);

  /// Soft delete of a task and, in cascade, of its sub-tasks.
  Future<void> delete(String id);

  Future<void> attachTag(String taskId, String tagId);

  Future<void> detachTag(String taskId, String tagId);

  Future<List<String>> tagIdsOf(String taskId);
}

/// Drift implementation of [TaskRepository].
class DriftTaskRepository implements TaskRepository {
  DriftTaskRepository(this._db, {IdGenerator? idGenerator})
      : _ids = idGenerator ?? UuidGenerator();

  final AppDatabase _db;
  final IdGenerator _ids;

  @override
  Stream<List<Task>> watchByList(String? listId) {
    final Selectable<TaskRow> query = _db.select(_db.tasks)
      ..where((TaskRow row) {
        final Expression<bool> alive = row.deletedAt.isNull();
        final Expression<bool> inList = listId == null
            ? row.listId.isNull()
            : row.listId.equals(listId);
        return alive & inList & row.parentId.isNull();
      })
      ..orderBy(<OrderClauseGenerator<TaskRow>>[
        (TaskRow row) => OrderingTerm.desc(row.isPinned),
        (TaskRow row) => OrderingTerm.asc(row.sortOrder),
        (TaskRow row) => OrderingTerm.desc(row.updatedAt),
      ]);
    return query.watch().map(
          (List<TaskRow> rows) =>
              rows.map(Task.fromRow).toList(growable: false),
        );
  }

  @override
  Stream<List<Task>> watchChildren(String parentId) {
    final Selectable<TaskRow> query = _db.select(_db.tasks)
      ..where(
        (TaskRow row) => row.deletedAt.isNull() & row.parentId.equals(parentId),
      )
      ..orderBy(<OrderClauseGenerator<TaskRow>>[
        (TaskRow row) => OrderingTerm.asc(row.sortOrder),
      ]);
    return query.watch().map(
          (List<TaskRow> rows) =>
              rows.map(Task.fromRow).toList(growable: false),
        );
  }

  @override
  Future<Task?> findById(String id) async {
    final TaskRow? row = await (_db.select(_db.tasks)
          ..where((TaskRow row) => row.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : Task.fromRow(row);
  }

  @override
  Future<Task> create({
    required String title,
    String? listId,
    String? parentId,
    String? sectionId,
    String? description,
    TaskPriority priority = TaskPriority.none,
    DateTime? dueAt,
    bool isAllDay = false,
    String? recurrenceRule,
    List<Duration> reminders = const <Duration>[],
    int? estimatedMinutes,
    int? estimatedPomodoros,
  }) async {
    final String id = _ids.next();
    final DateTime now = DateTime.now().toUtc();
    final int nextOrder = await _nextSortOrder(listId);
    await _db.into(_db.tasks).insert(
          TasksCompanion.insert(
            id: id,
            title: title,
            listId: Value<String?>(listId),
            parentId: Value<String?>(parentId),
            sectionId: sectionId == null
            ? const Value<String?>.absent()
            : Value<String?>(sectionId),
            description: Value<String>(description ?? ''),
            priority: Value<int>(priority.value),
            dueAt: Value<DateTime?>(dueAt?.toUtc()),
            isAllDay: Value<bool>(isAllDay),
            recurrenceRule: Value<String?>(recurrenceRule),
            reminders: Value<String>(TaskReminders.encode(reminders)),
            sortOrder: Value<int>(nextOrder),
            estimatedMinutes: Value<int>(estimatedMinutes ?? 0),
            estimatedPomodoros: Value<int>(estimatedPomodoros ?? 0),
            updatedAt: Value<DateTime>(now),
            createdAt: Value<DateTime>(now),
          ),
        );
    return Task(
      id: id,
      title: title,
      listId: listId,
      parentId: parentId,
      sectionId: sectionId,
      description: description ?? '',
      priority: priority,
      dueAt: dueAt?.toUtc(),
      isAllDay: isAllDay,
      recurrenceRule: recurrenceRule,
      reminders: reminders,
      sortOrder: nextOrder,
      estimatedMinutes: estimatedMinutes ?? 0,
      estimatedPomodoros: estimatedPomodoros ?? 0,
      updatedAt: now,
    );
  }

  @override
  Future<void> update(
    String id, {
    String? title,
    String? description,
    TaskPriority? priority,
    DateTime? dueAt,
    bool clearDueAt = false,
    bool? isAllDay,
    String? listId,
    bool clearList = false,
    String? sectionId,
    bool? isPinned,
    List<Duration>? reminders,
    String? recurrenceRule,
    bool clearRecurrence = false,
    int? sortOrder,
  }) async {
    await (_db.update(_db.tasks)..where((TaskRow row) => row.id.equals(id)))
        .write(
      TasksCompanion(
        title: title == null ? const Value<String>.absent() : Value<String>(title),
        description: description == null
            ? const Value<String>.absent()
            : Value<String>(description),
        priority: priority == null
            ? const Value<int>.absent()
            : Value<int>(priority.value),
        dueAt: clearDueAt
            ? const Value<DateTime?>(null)
            : (dueAt == null
                ? const Value<DateTime?>.absent()
                : Value<DateTime?>(dueAt.toUtc())),
        isAllDay:
            isAllDay == null ? const Value<bool>.absent() : Value<bool>(isAllDay),
        listId: clearList
            ? const Value<String?>(null)
            : (listId == null
                ? const Value<String?>.absent()
                : Value<String?>(listId)),
        sectionId: sectionId == null
            ? const Value<String?>.absent()
            : Value<String?>(sectionId),
        isPinned:
            isPinned == null ? const Value<bool>.absent() : Value<bool>(isPinned),
        reminders: reminders == null
            ? const Value<String>.absent()
            : Value<String>(TaskReminders.encode(reminders)),
        recurrenceRule: clearRecurrence
            ? const Value<String?>(null)
            : (recurrenceRule == null
                ? const Value<String?>.absent()
                : Value<String?>(recurrenceRule)),
        sortOrder: sortOrder == null
            ? const Value<int>.absent()
            : Value<int>(sortOrder),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> setStatus(String id, TaskStatus status) async {
    final DateTime now = DateTime.now().toUtc();
    await (_db.update(_db.tasks)..where((TaskRow row) => row.id.equals(id)))
        .write(
      TasksCompanion(
        status: Value<String>(status.name),
        completedAt: status == TaskStatus.done
            ? Value<DateTime?>(now)
            : const Value<DateTime?>(null),
        updatedAt: Value<DateTime>(now),
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    final DateTime now = DateTime.now().toUtc();
    await (_db.update(_db.tasks)..where((TaskRow row) => row.parentId.equals(id)))
        .write(
      TasksCompanion(deletedAt: Value<DateTime>(now), updatedAt: Value<DateTime>(now)),
    );
    await (_db.update(_db.tasks)..where((TaskRow row) => row.id.equals(id)))
        .write(
      TasksCompanion(deletedAt: Value<DateTime>(now), updatedAt: Value<DateTime>(now)),
    );
  }

  @override
  Future<void> attachTag(String taskId, String tagId) async {
    await _db.into(_db.taskTags).insertOnConflictUpdate(
          TaskTagsCompanion.insert(taskId: taskId, tagId: tagId),
        );
  }

  @override
  Future<void> detachTag(String taskId, String tagId) async {
    await (_db.delete(_db.taskTags)
          ..where(
            (TaskTag row) => row.taskId.equals(taskId) & row.tagId.equals(tagId),
          ))
        .go();
  }

  @override
  Future<List<String>> tagIdsOf(String taskId) async {
    final List<TaskTag> links = await (_db.select(_db.taskTags)
          ..where((TaskTag row) => row.taskId.equals(taskId)))
        .get();
    return links.map((TaskTag link) => link.tagId).toList(growable: false);
  }

  Future<int> _nextSortOrder(String? listId) async {
    final Expression<int> maxOrder = _db.tasks.sortOrder.max();
    final Selectable<int> query = listId == null
        ? (_db.selectOnly(_db.tasks)
            ..addColumns(<Expression<Object>>[maxOrder])
            ..where(_db.tasks.listId.isNull()))
        : (_db.selectOnly(_db.tasks)
            ..addColumns(<Expression<Object>>[maxOrder])
            ..where(_db.tasks.listId.equals(listId)));
    final TypedResult result = await query.getSingle();
    return (result.read(maxOrder) ?? 0) + 1;
  }
}
