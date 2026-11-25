import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_providers.dart';
import '../domain/tag.dart';
import 'tag_repository.dart';

final Provider<TagRepository> tagRepositoryProvider =
    Provider<TagRepository>((Ref ref) {
  return DriftTagRepository(ref.watch(appDatabaseProvider));
});

final StreamProvider<List<Tag>> tagsProvider =
    StreamProvider<List<Tag>>((Ref ref) {
  return ref.watch(tagRepositoryProvider).watchAll();
});
