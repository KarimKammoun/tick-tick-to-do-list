import 'package:drift/drift.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/features/folders/data/folder_repository.dart';
import 'package:taskflow/features/folders/domain/folder.dart';
import 'package:taskflow/features/lists/data/list_repository.dart';
import 'package:taskflow/features/lists/domain/task_list.dart';
import 'package:taskflow/features/tags/data/tag_repository.dart';
import 'package:taskflow/features/tasks/data/task_repository.dart';
import 'package:taskflow/features/tasks/domain/task.dart';

import 'test_database.dart';

void main() {
  late AppDatabase database;
  late DriftFolderRepository folders;
  late DriftListRepository lists;
  late DriftTaskRepository tasks;
  late DriftTagRepository tags;

  setUp(() {
    database = openTestDatabase();
    folders = DriftFolderRepository(database);
    lists = DriftListRepository(database);
    tasks = DriftTaskRepository(database);
    tags = DriftTagRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('DriftFolderRepository', () {
    test('creates folders in insertion order', () async {
      await folders.create(name: 'Work');
      await folders.create(name: 'Personal');

      final List<Folder> stored = await folders.watchAll().first;
      expect(
        stored.map((Folder folder) => folder.name),
        <String>['Work', 'Personal'],
      );
    });

    test('collapses, renames and soft deletes a folder', () async {
      final Folder folder = await folders.create(name: 'Projects');

      await folders.setCollapsed(folder.id, isCollapsed: true);
      expect((await folders.watchAll().first).single.isCollapsed, isTrue);

      await folders.rename(folder.id, 'Projects 2026');
      expect((await folders.watchAll().first).single.name, 'Projects 2026');

      await folders.delete(folder.id);
      expect(await folders.watchAll().first, isEmpty);
    });
  });

  group('DriftListRepository', () {
    test('creates a list attached to a folder', () async {
      final Folder folder = await folders.create(name: 'Work');
      final TaskList list = await lists.create(
        name: 'Sprint',
        color: const Color(0xFF3FA796),
        icon: 'bolt',
        folderId: folder.id,
      );

      expect(list.folderId, folder.id);
      final TaskList? stored = await lists.findById(list.id);
      expect(stored!.color, const Color(0xFF3FA796));
      expect(stored.kind, ListType.tasks);
      expect(stored.defaultView, ListDefaultView.list);
    });

    test('hides archived lists from the default stream', () async {
      final TaskList list = await lists.create(
        name: 'Old',
        color: const Color(0xFF4772FA),
        icon: 'list',
      );

      await lists.update(list.id, isArchived: true);

      expect(await lists.watchAll().first, isEmpty);
      expect((await lists.watchAll(includeArchived: true).first).length, 1);
    });

    test('moves the tasks to the Inbox when a list is deleted', () async {
      final TaskList list = await lists.create(
        name: 'Temporary',
        color: const Color(0xFF4772FA),
        icon: 'list',
      );
      final Task task = await tasks.create(title: 'Belongs to list', listId: list.id);

      await lists.delete(list.id);

      final Task? stored = await tasks.findById(task.id);
      expect(stored!.listId, isNull);
      expect(stored.deletedAt, isNull);
    });

    test('updates the name and the default view', () async {
      final TaskList list = await lists.create(
        name: 'Board',
        color: const Color(0xFF4772FA),
        icon: 'list',
      );

      await lists.update(
        list.id,
        name: 'Board 2026',
        defaultView: ListDefaultView.kanban,
      );

      final TaskList stored = (await lists.findById(list.id))!;
      expect(stored.name, 'Board 2026');
      expect(stored.defaultView, ListDefaultView.kanban);
    });
  });

  group('DriftTagRepository', () {
    test('creates hierarchical tags and soft deletes them', () async {
      final TagRow parent = await database.into(database.tags).insertReturning(
            TagsCompanion.insert(
              id: 'parent',
              name: 'work',
              color: const Color(0xFF2E9E5B).toARGB32(),
            ),
          );

      final Tag child = await tags.create(
        name: 'work/urgent',
        color: const Color(0xFFD52B24),
        parentTagId: parent.id,
      );

      expect((await tags.watchAll().first).length, 2);
      expect(child.parentTagId, 'parent');

      await tags.delete(child.id);
      expect((await tags.watchAll().first).single.name, 'work');
    });
  });
}
