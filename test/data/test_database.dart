import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:taskflow/core/database/app_database.dart';

/// Opens an in-memory database with the production migration strategy, so the
/// schema, the foreign keys and the defaults behave exactly like the app.
AppDatabase openTestDatabase() {
  return AppDatabase.withExecutor(NativeDatabase.memory());
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
