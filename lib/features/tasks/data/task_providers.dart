import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../domain/task.dart';
import 'task_repository.dart';

final Provider<TaskRepository> taskRepositoryProvider =
    Provider<TaskRepository>((Ref ref) {
  return DriftTaskRepository(ref.watch(appDatabaseProvider));
});

/// Family argument: the list id, `null` for the Inbox.
final StreamProviderFamily<List<Task>, String?> tasksByListProvider =
    StreamProvider.family<List<Task>, String?>((Ref ref, String? listId) {
  return ref.watch(taskRepositoryProvider).watchByList(listId);
});

final StreamProviderFamily<List<Task>, String> subTasksProvider =
    StreamProvider.family<List<Task>, String>((Ref ref, String parentId) {
  return ref.watch(taskRepositoryProvider).watchChildren(parentId);
});
