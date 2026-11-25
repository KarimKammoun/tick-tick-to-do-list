import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/core/ids/id_generator.dart';
import 'package:taskflow/features/tasks/domain/task.dart';
import 'package:taskflow/features/tasks/domain/task_priority.dart';
import 'package:taskflow/features/tasks/domain/task_status.dart';

void main() {
  group('UuidGenerator', () {
    test('produces unique version 4 UUIDs', () {
      final UuidGenerator generator = UuidGenerator();
      final Set<String> ids = <String>{
        for (int i = 0; i < 500; i++) generator.next(),
      };

      expect(ids, hasLength(500));
      expect(
        ids.every(
          (String id) => RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab]'
            r'[0-9a-f]{3}-[0-9a-f]{12}$',
          ).hasMatch(id),
        ),
        isTrue,
      );
    });
  });

  group('TaskPriority', () {
    test('maps the stored integers of spec 5.2', () {
      expect(TaskPriority.none.value, 0);
      expect(TaskPriority.low.value, 1);
      expect(TaskPriority.medium.value, 2);
      expect(TaskPriority.high.value, 3);
      expect(TaskPriority.fromValue(2), TaskPriority.medium);
      expect(TaskPriority.fromValue(99), TaskPriority.none);
    });
  });

  group('TaskStatus', () {
    test('parses its stored names', () {
      expect(TaskStatus.fromName('done'), TaskStatus.done);
      expect(TaskStatus.fromName('abandoned'), TaskStatus.abandoned);
      expect(TaskStatus.fromName('anything'), TaskStatus.todo);
    });
  });

  group('TaskReminders codec', () {
    test('round-trips a list of offsets', () {
      const List<Duration> reminders = <Duration>[
        Duration.zero,
        Duration(minutes: 5),
        Duration(days: 1),
      ];

      final String encoded = TaskReminders.encode(reminders);
      expect(encoded, '[0,5,1440]');
      expect(TaskReminders.decode(encoded), reminders);
    });

    test('decodes an empty or malformed payload to an empty list', () {
      expect(TaskReminders.decode('[]'), isEmpty);
      expect(TaskReminders.decode('not json'), isEmpty);
      expect(TaskReminders.decode('['), isEmpty);
    });
  });

  group('Task', () {
    test('flags overdue open tasks only', () {
      final DateTime now = DateTime.utc(2026, 1, 10, 12);
      final Task overdue = Task(
        id: 'id',
        title: 'Late',
        dueAt: DateTime.utc(2026, 1, 9),
      );
      expect(overdue.isOverdue(now), isTrue);

      final Task done = overdue.copyWith(status: TaskStatus.done);
      expect(done.isOverdue(now), isFalse);

      final Task future = Task(
        id: 'id',
        title: 'Later',
        dueAt: DateTime.utc(2026, 2, 1),
      );
      expect(future.isOverdue(now), isFalse);
    });

    test('knows whether it belongs to the Inbox', () {
      const Task inbox = Task(id: 'id', title: 'No list');
      final Task listed = inbox.copyWith(listId: 'list-1');

      expect(inbox.isInbox, isTrue);
      expect(listed.isInbox, isFalse);
      expect(listed.copyWith(clearList: true).isInbox, isTrue);
    });

    test('keeps its identifiers when copied', () {
      const Task task = Task(id: 'fixed-id', title: 'Original');
      final Task copy = task.copyWith(title: 'Renamed');

      expect(copy.id, task.id);
      expect(copy.title, 'Renamed');
    });
  });
}
