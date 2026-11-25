import 'package:drift/drift.dart';

/// Columns shared by every synchronisable row (spec section 3): the primary key
/// is a UUID generated on the device, and every row carries the `updated_at`
/// and
/// `deleted_at` timestamps used by the last-write-wins synchronisation.
mixin SyncColumns on Table {
  /// Device generated UUID v4. Uniqueness and shape are enforced by the
  /// repositories (`UuidGenerator`) and the indexes declared in
  /// `AppDatabase`; the column itself stays a plain text column so that Drift
  /// does not require a length check that `CHECK` constraints cannot express
  /// on every engine.
  TextColumn get id => text()();

  /// Last local modification, in UTC. Written by the repositories; the
  /// `clientDefault` keeps a row insertable without it.
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  /// Soft delete timestamp; `null` means the row is alive.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  /// Local ordering hint used by lists and sections.
  IntColumn get sortOrder => integer().withDefault(const Constant<int>(0))();
}

/// Folder grouping several lists (`folders` in spec section 4).
///
/// `user_id` is nullable on purpose: step 0 works offline, and the column is
/// filled once accounts exist in step 4.
@DataClassName('FolderRow')
class Folders extends Table with SyncColumns {
  TextColumn get userId => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// A collapsed folder hides its lists in the sidebar.
  BoolColumn get isCollapsed =>
      boolean().withDefault(const Constant<bool>(false))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// List of tasks, or notebook when [ListType.notes] (`lists` in spec section
/// 4).
@DataClassName('TaskListRow')
class Lists extends Table with SyncColumns {
  TextColumn get userId => text().nullable()();
  TextColumn get folderId =>
      text().nullable().references(Folders, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// ARGB value of the list colour.
  IntColumn get color => integer()();

  /// Material Symbols identifier, resolved in the presentation layer.
  TextColumn get icon => text().withDefault(const Constant<String>('list'))();

  /// Stored as an enum name: `tasks` or `notes` (see [ListType]).
  TextColumn get kind => text().withDefault(const Constant<String>('tasks'))();

  /// Default view of the list: `list`, `kanban` or `timeline`.
  TextColumn get defaultView =>
      text().withDefault(const Constant<String>('list'))();

  BoolColumn get isArchived =>
      boolean().withDefault(const Constant<bool>(false))();
  BoolColumn get isShared =>
      boolean().withDefault(const Constant<bool>(false))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// Kanban column of a list (`sections` in spec section 4).
@DataClassName('SectionRow')
class Sections extends Table with SyncColumns {
  TextColumn get listId =>
      text().references(Lists, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 200)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// A task or a sub-task (`tasks` in spec section 4).
///
/// A `null` [listId] means the task lives in the Inbox, and a `null`
/// [parentId] means it is a top level task. Sub-tasks are nested up to five
/// levels, which is enforced in the domain layer (step 2), not by the schema.
@DataClassName('TaskRow')
class Tasks extends Table with SyncColumns {
  TextColumn get userId => text().nullable()();
  TextColumn get listId =>
      text().nullable().references(Lists, #id, onDelete: KeyAction.cascade)();
  TextColumn get parentId =>
      text().nullable().references(Tasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get sectionId => text().nullable().references(
    Sections,
    #id,
    onDelete: KeyAction.setNull,
  )();

  TextColumn get title => text().withLength(min: 1, max: 500)();
  TextColumn get description =>
      text().withDefault(const Constant<String>(''))();

  /// `todo`, `done` or `abandoned` (see [TaskStatus]).
  TextColumn get status => text().withDefault(const Constant<String>('todo'))();

  /// 0 none, 1 low, 2 medium, 3 high.
  IntColumn get priority => integer().withDefault(const Constant<int>(0))();

  DateTimeColumn get startAt => dateTime().nullable()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  BoolColumn get isAllDay =>
      boolean().withDefault(const Constant<bool>(false))();
  TextColumn get timeZone => text().nullable()();

  /// Recurrence rule in iCalendar RRULE format, e.g. `FREQ=WEEKLY;BYDAY=MO`.
  TextColumn get recurrenceRule => text().nullable()();

  /// Reminder offsets (in minutes before the due date), stored as JSON.
  TextColumn get reminders =>
      text().withDefault(const Constant<String>('[]'))();

  IntColumn get estimatedMinutes =>
      integer().withDefault(const Constant<int>(0))();
  IntColumn get estimatedPomodoros =>
      integer().withDefault(const Constant<int>(0))();

  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get isPinned =>
      boolean().withDefault(const Constant<bool>(false))();

  /// Creation timestamp, kept apart from [updatedAt].
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// Tag that can be attached to any task (`tags` in spec section 4).
@DataClassName('TagRow')
class Tags extends Table with SyncColumns {
  TextColumn get userId => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get color => integer()();

  /// Optional parent for hierarchical tags.
  TextColumn get parentTagId =>
      text().nullable().references(Tags, #id, onDelete: KeyAction.setNull)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// Join table between tasks and tags (`task_tags` in spec section 4).
@DataClassName('TaskTag')
class TaskTags extends Table {
  TextColumn get taskId =>
      text().references(Tasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{taskId, tagId};
}
