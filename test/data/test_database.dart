import 'package:drift/drift.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/core/database/database_connection_memory.dart';

/// Opens an in-memory database through the same connection abstraction as the
/// application, so that the migrations, the foreign keys and the defaults of
/// the tests behave exactly like the real ones.
AppDatabase openTestDatabase() {
  return AppDatabase(const InMemoryDatabaseConnection());
}

/// Column names of an sqlite table, for the schema assertions.
Future<List<String>> columnsOf(AppDatabase database, String table) async {
  final List<QueryRow> rows =
      await database.customSelect('PRAGMA table_info($table)').get();
  return rows
      .map((QueryRow row) => row.read<String>('name'))
      .toList(growable: false);
}

/// Names of the sqlite tables created by the migrations.
Future<List<String>> tableNames(AppDatabase database) async {
  final List<QueryRow> rows = await database
      .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
      .get();
  return rows
      .map((QueryRow row) => row.read<String>('name'))
      .where((String name) => !name.startsWith('sqlite_'))
      .toList(growable: false);
}
