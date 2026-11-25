import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../domain/folder.dart';
import 'folder_repository.dart';

final Provider<FolderRepository> folderRepositoryProvider =
    Provider<FolderRepository>((Ref ref) {
      return DriftFolderRepository(ref.watch(appDatabaseProvider));
    });

/// All live folders, ordered by their manual position.
final StreamProvider<List<Folder>> foldersProvider =
    StreamProvider<List<Folder>>((Ref ref) {
      return ref.watch(folderRepositoryProvider).watchAll();
    });
