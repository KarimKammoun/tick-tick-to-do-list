import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'database_connection.dart';

/// In-memory connection used by the unit tests.
class InMemoryDatabaseConnection implements DatabaseConnection {
  const InMemoryDatabaseConnection();

  @override
  QueryExecutor open() => NativeDatabase.memory();
}
