import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../domain/task_list.dart';
import 'list_repository.dart';

final Provider<ListRepository> listRepositoryProvider =
    Provider<ListRepository>((Ref ref) {
      return DriftListRepository(ref.watch(appDatabaseProvider));
    });

/// Live lists shown in the sidebar (archived lists are hidden).
final StreamProvider<List<TaskList>> listsProvider =
    StreamProvider<List<TaskList>>((Ref ref) {
      return ref.watch(listRepositoryProvider).watchAll();
    });
