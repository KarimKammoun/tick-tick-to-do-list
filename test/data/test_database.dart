import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:taskflow/core/database/app_database.dart';

/// Opens an in-memory database whose foreign keys are enforced, exactly like
/// the production connection.
AppDatabase openTestDatabase() {
  return AppDatabase.withExecutor(NativeDatabase.memory());
}

/// Closes a test database and empties every table so a single executor can be
/// reused between tests when needed.
Future<void> resetDatabase(AppDatabase database) async {
  await database.customStatement('PRAGMA foreign_keys = OFF');
  for (final String table in <String>[
    'task_tags',
    'tasks',
    'sections',
    'tags',
    'lists',
    'folders',
  ]) {
    await database.customStatement('DELETE FROM $table');
  }
  await database.customStatement('PRAGMA foreign_keys = ON');
}

/// Convenience helper for the schema assertions.
Future<List<String>> tableNames(AppDatabase database) async {
  final List<QueryRow> rows = await database
      .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
      .get();
  return rows
      .map((QueryRow row) => row.read<String>('name'))
      .where((String name) => !name.startsWith('sqlite_'))
      .toList(growable: false);
}
