import 'package:drift/drift.dart';

/// Opens the Drift database.
///
/// Named `AppDatabaseConnection` rather than `DatabaseConnection` because drift
/// exports a `DatabaseConnection` of its own since 2.28: importing both names
/// into `app_database.dart` made the compiler reject the file.
///
/// Platform specific helpers are kept in their own files so that the web-free
/// mobile and desktop targets share the same repositories:
/// * `database_connection_native.dart` for Android and Windows.
/// * `database_connection_memory.dart` for unit tests.
abstract interface class AppDatabaseConnection {
  QueryExecutor open();
}
