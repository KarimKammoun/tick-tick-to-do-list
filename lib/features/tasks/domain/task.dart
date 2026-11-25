import '../../../core/database/app_database.dart';
import 'task_priority.dart';
import 'task_status.dart';

/// Domain model of a task or sub-task (spec section 4 and 5.1).
///
/// A `null` [listId] means the Inbox, a `null` [parentId] means a top level
/// task. Due dates are stored in UTC, the presentation layer formats them with
/// `intl`.
class Task {
  const Task({
    required this.id,
    required this.title,
    this.listId,
    this.parentId,
    this.sectionId,
    this.description = '',
    this.status = TaskStatus.todo,
    this.priority = TaskPriority.none,
    this.startAt,
    this.dueAt,
    this.isAllDay = false,
    this.timeZone,
    this.recurrenceRule,
    this.reminders = const <Duration>[],
    this.sortOrder = 0,
    this.estimatedMinutes = 0,
    this.estimatedPomodoros = 0,
    this.completedAt,
    this.isPinned = false,
    this.updatedAt,
    this.deletedAt,
  });

  factory Task.fromRow(TaskRow row) {
    return Task(
      id: row.id,
      listId: row.listId,
      parentId: row.parentId,
      sectionId: row.sectionId,
      title: row.title,
      description: row.description,
      status: TaskStatus.fromName(row.status),
      priority: TaskPriority.fromValue(row.priority),
      startAt: row.startAt,
      dueAt: row.dueAt,
      isAllDay: row.isAllDay,
      timeZone: row.timeZone,
      recurrenceRule: row.recurrenceRule,
      reminders: TaskReminders.decode(row.reminders),
      sortOrder: row.sortOrder,
      estimatedMinutes: row.estimatedMinutes,
      estimatedPomodoros: row.estimatedPomodoros,
      completedAt: row.completedAt,
      isPinned: row.isPinned,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }

  final String id;
  final String? listId;
  final String? parentId;
  final String? sectionId;
  final String title;
  final String description;
  final TaskStatus status;
  final TaskPriority priority;
  final DateTime? startAt;
  final DateTime? dueAt;
  final bool isAllDay;
  final String? timeZone;

  /// iCalendar RRULE string; step 3 parses it.
  final String? recurrenceRule;

  /// Reminder offsets before [dueAt]; step 3 schedules them.
  final List<Duration> reminders;

  final int sortOrder;
  final int estimatedMinutes;
  final int estimatedPomodoros;
  final DateTime? completedAt;
  final bool isPinned;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;

  bool get isInbox => listId == null;

  bool get isSubTask => parentId != null;

  /// True when the task is still open and its due date is in the past.
  bool isOverdue(DateTime now) {
    final DateTime? due = dueAt;
    return due != null && status == TaskStatus.todo && due.isBefore(now);
  }

  Task copyWith({
    String? title,
    String? description,
    String? listId,
    bool clearList = false,
    String? parentId,
    TaskStatus? status,
    TaskPriority? priority,
    DateTime? dueAt,
    bool clearDueAt = false,
    bool? isAllDay,
    String? recurrenceRule,
    bool clearRecurrence = false,
    List<Duration>? reminders,
    int? sortOrder,
    bool? isPinned,
    DateTime? completedAt,
    DateTime? deletedAt,
  }) {
    return Task(
      id: id,
      listId: clearList ? null : (listId ?? this.listId),
      parentId: parentId ?? this.parentId,
      sectionId: sectionId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startAt: startAt,
      dueAt: clearDueAt ? null : (dueAt ?? this.dueAt),
      isAllDay: isAllDay ?? this.isAllDay,
      timeZone: timeZone,
      recurrenceRule: clearRecurrence
          ? null
          : (recurrenceRule ?? this.recurrenceRule),
      reminders: reminders ?? this.reminders,
      sortOrder: sortOrder ?? this.sortOrder,
      estimatedMinutes: estimatedMinutes,
      estimatedPomodoros: estimatedPomodoros,
      completedAt: completedAt ?? this.completedAt,
      isPinned: isPinned ?? this.isPinned,
      updatedAt: updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

/// JSON codec for the `tasks.reminders` column (list of offsets in minutes).
abstract final class TaskReminders {
  static String encode(List<Duration> reminders) {
    final List<int> minutes = reminders
        .map((Duration offset) => offset.inMinutes)
        .toList(growable: false);
    return '[${minutes.join(',')}]';
  }

  static List<Duration> decode(String raw) {
    final String trimmed = raw.trim();
    if (trimmed.length < 2 || !trimmed.startsWith('[')) {
      return const <Duration>[];
    }
    final String body = trimmed.substring(1, trimmed.length - 1).trim();
    if (body.isEmpty) {
      return const <Duration>[];
    }
    return body
        .split(',')
        .map((String part) => int.tryParse(part.trim()))
        .whereType<int>()
        .map(Duration.new)
        .toList(growable: false);
  }
}
