import 'package:drift/drift.dart';
import 'package:flutter/painting.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../domain/task_list.dart';

/// Persistence of lists.
abstract interface class ListRepository {
  Stream<List<TaskList>> watchAll({bool includeArchived = false});

  Future<TaskList?> findById(String id);

  Future<TaskList> create({
    required String name,
    required Color color,
    required String icon,
    String? folderId,
    ListType kind = ListType.tasks,
  });

  Future<void> update(
    String id, {
    String? name,
    Color? color,
    String? icon,
    String? folderId,
    bool clearFolder = false,
    bool? isArchived,
    ListDefaultView? defaultView,
  });

  Future<void> delete(String id);
}

/// Drift implementation of [ListRepository].
class DriftListRepository implements ListRepository {
  DriftListRepository(this._db, {IdGenerator? idGenerator})
      : _ids = idGenerator ?? UuidGenerator();

  final AppDatabase _db;
  final IdGenerator _ids;

  @override
  Stream<List<TaskList>> watchAll({bool includeArchived = false}) {
    final Selectable<TaskListRow> query = _db.select(_db.lists)
      ..where((TaskListRow row) {
        final Expression<bool> alive = row.deletedAt.isNull();
        return includeArchived
            ? alive
            : alive & row.isArchived.equals(false);
      })
      ..orderBy(<OrderClauseGenerator<TaskListRow>>[
        (TaskListRow row) => OrderingTerm.asc(row.sortOrder),
        (TaskListRow row) => OrderingTerm.asc(row.name),
      ]);
    return query.watch().map(
          (List<TaskListRow> rows) =>
              rows.map(_toDomain).toList(growable: false),
        );
  }

  @override
  Future<TaskList?> findById(String id) async {
    final TaskListRow? row = await (_db.select(_db.lists)
          ..where((TaskListRow row) => row.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<TaskList> create({
    required String name,
    required Color color,
    required String icon,
    String? folderId,
    ListType kind = ListType.tasks,
  }) async {
    final String id = _ids.next();
    final DateTime now = DateTime.now().toUtc();
    final int nextOrder = await _nextSortOrder();
    await _db.into(_db.lists).insert(
          ListsCompanion.insert(
            id: id,
            name: name,
            color: color.toARGB32(),
            icon: icon,
            folderId: Value<String?>(folderId),
            kind: Value<String>(kind.name),
            sortOrder: Value<int>(nextOrder),
            updatedAt: Value<DateTime>(now),
          ),
        );
    return TaskList(
      id: id,
      name: name,
      color: color,
      icon: icon,
      folderId: folderId,
      kind: kind,
      sortOrder: nextOrder,
      updatedAt: now,
    );
  }

  @override
  Future<void> update(
    String id, {
    String? name,
    Color? color,
    String? icon,
    String? folderId,
    bool clearFolder = false,
    bool? isArchived,
    ListDefaultView? defaultView,
  }) async {
    await (_db.update(_db.lists)..where((TaskListRow row) => row.id.equals(id)))
        .write(
      ListsCompanion(
        name: name == null ? const Value<String>.absent() : Value<String>(name),
        color: color == null
            ? const Value<int>.absent()
            : Value<int>(color.toARGB32()),
        icon: icon == null ? const Value<String>.absent() : Value<String>(icon),
        folderId: clearFolder
            ? const Value<String?>(null)
            : (folderId == null
                ? const Value<String?>.absent()
                : Value<String?>(folderId)),
        isArchived: isArchived == null
            ? const Value<bool>.absent()
            : Value<bool>(isArchived),
        defaultView: defaultView == null
            ? const Value<String>.absent()
            : Value<String>(defaultView.name),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> delete(String id) async {
    final DateTime now = DateTime.now().toUtc();
    await (_db.update(_db.lists)..where((TaskListRow row) => row.id.equals(id)))
        .write(
          ListsCompanion(
            deletedAt: Value<DateTime>(now),
            updatedAt: Value<DateTime>(now),
          ),
        );
    // Removing a list moves its tasks to the Inbox instead of losing them.
    await (_db.update(_db.tasks)
          ..where((TaskRow row) => row.listId.equals(id)))
        .write(const TasksCompanion(listId: Value<String?>(null)));
  }

  Future<int> _nextSortOrder() async {
    final int? maxOrder = await _db.lists.sortOrder.max().getSingleOrNull();
    return (maxOrder ?? 0) + 1;
  }

  TaskList _toDomain(TaskListRow row) {
    return TaskList(
      id: row.id,
      folderId: row.folderId,
      name: row.name,
      color: Color(row.color),
      icon: row.icon,
      kind: ListType.fromName(row.kind),
      defaultView: ListDefaultView.fromName(row.defaultView),
      sortOrder: row.sortOrder,
      isArchived: row.isArchived,
      isShared: row.isShared,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }
}
