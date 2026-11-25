import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'database_tables.dart';

part 'app_database.g.dart';

/// Local SQLite database of the application.
///
/// Step 0 only declares the schema of spec section 4 (`folders`, `lists`,
/// `tasks` with `parent_id`, `tags`, `task_tags`, `sections`) together with the
/// shared synchronisation columns (UUID, `updated_at`, `deleted_at`). Queries
/// and repositories are added by the following steps.
@DriftDatabase(
  tables: <Type>[
    Folders,
    Lists,
    Sections,
    Tasks,
    Tags,
    TaskTags,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(DatabaseConnection connection) : super(connection.open());

  /// Overrides the schema version for the schema tests.
  AppDatabase.withExecutor(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
        },
        beforeOpen: (OpeningDetails details) async {
          // Foreign keys are off by default in SQLite and must be enabled per
          // connection for `onDelete` actions to run.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
