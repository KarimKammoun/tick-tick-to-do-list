import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'database_connection.dart';
import 'database_connection_native.dart';

/// Connection used by the application; tests override it with
/// `InMemoryDatabaseConnection`.
final Provider<DatabaseConnection> databaseConnectionProvider =
    Provider<DatabaseConnection>((Ref ref) {
  return const NativeDatabaseConnection();
});

/// The single local database instance.
final Provider<AppDatabase> appDatabaseProvider = Provider<AppDatabase>((Ref ref) {
  final AppDatabase database = AppDatabase(ref.watch(databaseConnectionProvider));
  ref.onDispose(database.close);
  return database;
});
