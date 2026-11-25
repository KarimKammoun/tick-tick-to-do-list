import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/core/database/app_database.dart';

import 'test_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = openTestDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  group('AppDatabase schema', () {
    test('creates the six tables of spec section 4', () async {
      final List<String> tables = await tableNames(database);

      expect(
        tables,
        containsAll(<String>[
          'folders',
          'lists',
          'sections',
          'tasks',
          'tags',
          'task_tags',
        ]),
      );
    });

    test('keeps the synchronisation columns on every table', () async {
      for (final String table in <String>[
        'folders',
        'lists',
        'sections',
        'tasks',
        'tags',
      ]) {
        final List<String> columns = await columnsOf(database, table);
        expect(columns, contains('id'), reason: '$table.id');
        expect(columns, contains('updated_at'), reason: '$table.updated_at');
        expect(columns, contains('deleted_at'), reason: '$table.deleted_at');
      }
    });

    test('tasks exposes the parent_id and list_id used by sub-tasks', () async {
      final List<String> columns = await columnsOf(database, 'tasks');

      expect(columns, contains('parent_id'));
      expect(columns, contains('list_id'));
      expect(columns, contains('recurrence_rule'));
      expect(columns, contains('reminders'));
      expect(columns, contains('completed_at'));
    });

    test('task_tags stores the task and tag pair as composite key', () async {
      final List<String> columns = await columnsOf(database, 'task_tags');

      expect(columns, containsAll(<String>['task_id', 'tag_id']));
    });
  });
}
