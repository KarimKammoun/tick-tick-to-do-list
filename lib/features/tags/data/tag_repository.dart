import 'package:drift/drift.dart';
import 'package:flutter/painting.dart';

import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../domain/tag.dart';

/// Persistence of tags.
abstract interface class TagRepository {
  Stream<List<Tag>> watchAll();

  Future<Tag> create({
    required String name,
    required Color color,
    String? parentTagId,
  });

  Future<void> delete(String id);
}

/// Drift implementation of [TagRepository].
class DriftTagRepository implements TagRepository {
  DriftTagRepository(this._db, {IdGenerator? idGenerator})
    : _ids = idGenerator ?? UuidGenerator();

  final AppDatabase _db;
  final IdGenerator _ids;

  @override
  Stream<List<Tag>> watchAll() {
    final Selectable<TagRow> query = _db.select(_db.tags)
      ..where(($TagsTable row) => row.deletedAt.isNull())
      ..orderBy(<OrderClauseGenerator<$TagsTable>>[
        ($TagsTable row) => OrderingTerm.asc(row.name),
      ]);
    return query.watch().map(
      (List<TagRow> rows) => rows
          .map(
            (TagRow row) => Tag(
              id: row.id,
              name: row.name,
              color: Color(row.color),
              parentTagId: row.parentTagId,
              updatedAt: row.updatedAt,
              deletedAt: row.deletedAt,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<Tag> create({
    required String name,
    required Color color,
    String? parentTagId,
  }) async {
    final String id = _ids.next();
    final DateTime now = DateTime.now().toUtc();
    await _db
        .into(_db.tags)
        .insert(
          TagsCompanion.insert(
            id: id,
            name: name,
            color: color.toARGB32(),
            parentTagId: Value<String?>(parentTagId),
            updatedAt: Value<DateTime>(now),
          ),
        );
    return Tag(
      id: id,
      name: name,
      color: color,
      parentTagId: parentTagId,
      updatedAt: now,
    );
  }

  @override
  Future<void> delete(String id) async {
    final DateTime now = DateTime.now().toUtc();
    await (_db.update(
      _db.tags,
    )..where(($TagsTable row) => row.id.equals(id))).write(
      TagsCompanion(
        deletedAt: Value<DateTime>(now),
        updatedAt: Value<DateTime>(now),
      ),
    );
  }
}
