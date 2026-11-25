import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'database_connection.dart';

/// File based connection used by the Android and Windows applications.
class NativeDatabaseConnection implements DatabaseConnection {
  const NativeDatabaseConnection({this.fileName = 'taskflow.sqlite'});

  final String fileName;

  @override
  QueryExecutor open() => LazyDatabase(_openFile);

  Future<QueryExecutor> _openFile() async {
    final Directory directory = await getApplicationSupportDirectory();
    final File file = File(p.join(directory.path, fileName));
    return NativeDatabase.createInBackground(file);
  }
}
