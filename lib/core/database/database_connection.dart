import 'package:drift/drift.dart';

/// Opens the Drift database.
///
/// Platform specific helpers are kept in their own files so that the web-free
/// mobile and desktop targets share the same repositories:
/// * `database_connection_native.dart` for Android and Windows.
/// * `database_connection_memory.dart` for unit tests.
abstract interface class DatabaseConnection {
  QueryExecutor open();
}
