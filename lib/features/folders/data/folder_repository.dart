import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../domain/folder.dart';

/// Persistence of folders.
abstract interface class FolderRepository {
  Stream<List<Folder>> watchAll();

  Future<Folder> create({required String name, String? userId});

  Future<void> rename(String id, String name);

  Future<void> setCollapsed(String id, {required bool isCollapsed});

  /// Soft delete: stamps `deleted_at` and `updated_at` so the removal can be
  /// synchronised in step 4 (spec section 3).
  Future<void> delete(String id);
}

/// Drift implementation of [FolderRepository].
class DriftFolderRepository implements FolderRepository {
  DriftFolderRepository(this._db, {IdGenerator? idGenerator})
      : _ids = idGenerator ?? UuidGenerator();

  final AppDatabase _db;
  final IdGenerator _ids;

  @override
  Stream<List<Folder>> watchAll() {
    final Selectable<FolderRow> query = _db.select(_db.folders)
      ..where((FolderRow row) => row.deletedAt.isNull())
      ..orderBy(<OrderClauseGenerator<FolderRow>>[
        (FolderRow row) => OrderingTerm.asc(row.sortOrder),
        (FolderRow row) => OrderingTerm.asc(row.name),
      ]);
    return query.watch().map(
          (List<FolderRow> rows) => rows
              .map(
                (FolderRow row) => Folder(
                  id: row.id,
                  name: row.name,
                  isCollapsed: row.isCollapsed,
                  sortOrder: row.sortOrder,
                  updatedAt: row.updatedAt,
                  deletedAt: row.deletedAt,
                ),
              )
              .toList(growable: false),
        );
  }

  @override
  Future<Folder> create({required String name, String? userId}) async {
    final String id = _ids.next();
    final DateTime now = DateTime.now().toUtc();
    final int nextOrder = await _nextSortOrder();
    await _db.into(_db.folders).insert(
          FoldersCompanion.insert(
            id: id,
            name: name,
            userId: Value<String?>(userId),
            sortOrder: Value<int>(nextOrder),
            updatedAt: Value<DateTime>(now),
          ),
        );
    return Folder(id: id, name: name, sortOrder: nextOrder, updatedAt: now);
  }

  @override
  Future<void> rename(String id, String name) => _touch(
        id,
        FoldersCompanion(name: Value<String>(name)),
      );

  @override
  Future<void> setCollapsed(String id, {required bool isCollapsed}) => _touch(
        id,
        FoldersCompanion(isCollapsed: Value<bool>(isCollapsed)),
      );

  @override
  Future<void> delete(String id) => _touch(
        id,
        FoldersCompanion(deletedAt: Value<DateTime>(DateTime.now().toUtc())),
      );

  Future<void> _touch(String id, FoldersCompanion changes) async {
    await (_db.update(_db.folders)..where((FolderRow row) => row.id.equals(id)))
        .write(
      changes.copyWith(updatedAt: Value<DateTime>(DateTime.now().toUtc())),
    );
  }

  Future<int> _nextSortOrder() async {
    final int? maxOrder = await _db.folders.sortOrder.max().getSingleOrNull();
    return (maxOrder ?? 0) + 1;
  }
}
