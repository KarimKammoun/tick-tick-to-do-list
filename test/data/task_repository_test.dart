import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/features/lists/data/list_repository.dart';
import 'package:taskflow/features/lists/domain/task_list.dart';
import 'package:taskflow/features/tasks/data/task_repository.dart';
import 'package:taskflow/features/tasks/domain/task.dart';
import 'package:taskflow/features/tasks/domain/task_priority.dart';
import 'package:taskflow/features/tasks/domain/task_status.dart';

import 'test_database.dart';

void main() {
  late AppDatabase database;
  late DriftTaskRepository tasks;
  late DriftListRepository lists;

  setUp(() {
    database = openTestDatabase();
    tasks = DriftTaskRepository(database);
    lists = DriftListRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('DriftTaskRepository', () {
    test('stores a task in the Inbox when no list is given', () async {
      final Task created = await tasks.create(title: 'Buy milk');

      expect(created.listId, isNull);
      expect(created.isInbox, isTrue);

      final List<Task> inbox = await tasks.watchByList(null).first;
      expect(inbox.single.title, 'Buy milk');
      expect(inbox.single.status, TaskStatus.todo);
    });

    test('generates a version 4 UUID and a modification timestamp', () async {
      final Task created = await tasks.create(title: 'Write report');

      expect(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab]'
          r'[0-9a-f]{3}-[0-9a-f]{12}$',
        ).hasMatch(created.id),
        isTrue,
        reason: 'unexpected id: ${created.id}',
      );
      expect(created.updatedAt, isNotNull);
      expect(created.deletedAt, isNull);
    });

    test('nests a sub-task under its parent', () async {
      final Task parent = await tasks.create(title: 'Ship release');
      await tasks.create(title: 'Write changelog', parentId: parent.id);

      final List<Task> children = await tasks.watchChildren(parent.id).first;
      expect(children.single.title, 'Write changelog');
      expect(children.single.isSubTask, isTrue);

      // The parent list only shows top-level tasks.
      final List<Task> roots = await tasks.watchByList(null).first;
      expect(roots.single.id, parent.id);
    });

    test('filters tasks by list', () async {
      final TaskList work = await lists.create(
        name: 'Work',
        color: const Color(0xFF4772FA),
        icon: 'work',
      );
      await tasks.create(title: 'Inbox task');
      await tasks.create(title: 'Work task', listId: work.id);

      final List<Task> workTasks = await tasks.watchByList(work.id).first;
      expect(workTasks.single.title, 'Work task');
    });

    test('keeps priority, due date and reminders round-trippable', () async {
      final DateTime due = DateTime.utc(2026, 3, 1, 9);
      final Task created = await tasks.create(
        title: 'Call the bank',
        priority: TaskPriority.high,
        dueAt: due,
        reminders: const <Duration>[
          Duration.zero,
          Duration(minutes: 30),
        ],
        recurrenceRule: 'FREQ=WEEKLY;BYDAY=MO',
      );

      final Task? reloaded = await tasks.findById(created.id);
      expect(reloaded, isNotNull);
      expect(reloaded!.priority, TaskPriority.high);
      expect(reloaded.dueAt, due);
      expect(reloaded.recurrenceRule, 'FREQ=WEEKLY;BYDAY=MO');
      expect(reloaded.reminders, const <Duration>[
        Duration.zero,
        Duration(minutes: 30),
      ]);
    });

    test('completes and reopens a task, stamping completed_at', () async {
      final Task created = await tasks.create(title: 'Pay invoice');

      await tasks.setStatus(created.id, TaskStatus.done);
      Task? stored = await tasks.findById(created.id);
      expect(stored!.status, TaskStatus.done);
      expect(stored.completedAt, isNotNull);

      await tasks.setStatus(created.id, TaskStatus.todo);
      stored = await tasks.findById(created.id);
      expect(stored!.status, TaskStatus.todo);
      expect(stored.completedAt, isNull);
    });

    test('soft deletes a task and its sub-tasks', () async {
      final Task parent = await tasks.create(title: 'Parent');
      final Task child =
          await tasks.create(title: 'Child', parentId: parent.id);

      await tasks.delete(parent.id);

      final Task? deletedParent = await tasks.findById(parent.id);
      final Task? deletedChild = await tasks.findById(child.id);
      expect(deletedParent!.deletedAt, isNotNull);
      expect(deletedChild!.deletedAt, isNotNull);

      expect(await tasks.watchByList(null).first, isEmpty);
    });

    test('updates fields and refreshes updated_at', () async {
      final Task created = await tasks.create(title: 'Draft');
      await Future<void>.delayed(const Duration(milliseconds: 2));

      await tasks.update(
        created.id,
        title: 'Final',
        priority: TaskPriority.medium,
      );

      final Task stored = (await tasks.findById(created.id))!;
      expect(stored.title, 'Final');
      expect(stored.priority, TaskPriority.medium);
      expect(
        stored.updatedAt!.isAfter(created.updatedAt!) ||
            stored.updatedAt!.isAtSameMomentAs(created.updatedAt!),
        isTrue,
      );
    });

    test('clears the due date on request', () async {
      final Task created = await tasks.create(
        title: 'Temporary deadline',
        dueAt: DateTime.utc(2026, 5, 4),
      );

      await tasks.update(created.id, clearDueAt: true);

      expect((await tasks.findById(created.id))!.dueAt, isNull);
    });

    test('attaches and detaches tags', () async {
      final Task created = await tasks.create(title: 'Tagged');
      await database.into(database.tags).insert(
            TagsCompanion.insert(
              id: 'tag-1',
              name: 'urgent',
              color: const Color(0xFFD52B24).toARGB32(),
            ),
          );

      await tasks.attachTag(created.id, 'tag-1');
      expect(await tasks.tagIdsOf(created.id), <String>['tag-1']);

      await tasks.detachTag(created.id, 'tag-1');
      expect(await tasks.tagIdsOf(created.id), isEmpty);
    });
  });
}
