// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint, unused_element, unused_field

class $FoldersTable extends Folders
    with TableInfo<$FoldersTable, FolderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta =
      const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>(
      'id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta =
      const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId =
      GeneratedColumn<String>(
      'user_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _nameMeta =
      const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>(
      'name',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isCollapsedMeta =
      const VerificationMeta('isCollapsed');
  @override
  late final GeneratedColumn<bool> isCollapsed =
      GeneratedColumn<bool>(
      'is_collapsed',
      aliasedName,
      false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder =
      GeneratedColumn<int>(
      'sort_order',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt =
      GeneratedColumn<DateTime>(
      'updated_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt =
      GeneratedColumn<DateTime>(
      'deleted_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, isCollapsed, sortOrder, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<FolderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
        _idMeta,
        id.isAcceptableOrUnknown(data['id']!, _idMeta),
      );
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_collapsed')) {
      context.handle(
        _isCollapsedMeta,
        isCollapsed.isAcceptableOrUnknown(data['is_collapsed']!, _isCollapsedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FolderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isCollapsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_collapsed'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}


class FolderRow extends DataClass implements Insertable<FolderRow> {
  final String id;
  final String? userId;
  final String name;
  final bool isCollapsed;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const FolderRow({
    required this.id,
    this.userId,
    required this.name,
    required this.isCollapsed,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['name'] = Variable<String>(name);
    map['is_collapsed'] = Variable<bool>(isCollapsed);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      name: Value(name),
      isCollapsed: Value(isCollapsed),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FolderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolderRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      name: serializer.fromJson<String>(json['name']),
      isCollapsed: serializer.fromJson<bool>(json['is_collapsed']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  factory FolderRow.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => FolderRow.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'name': serializer.toJson<String>(name),
      'is_collapsed': serializer.toJson<bool>(isCollapsed),
      'sort_order': serializer.toJson<int>(sortOrder),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  FolderRow copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    String? name,
    bool? isCollapsed,
    int? sortOrder,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => FolderRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    name: name ?? this.name,
    isCollapsed: isCollapsed ?? this.isCollapsed,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FolderRow copyWithCompanion(FoldersCompanion data) {
    return FolderRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      isCollapsed: data.isCollapsed.present ? data.isCollapsed.value : this.isCollapsed,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolderRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isCollapsed: $isCollapsed, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, isCollapsed, sortOrder, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolderRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.isCollapsed == this.isCollapsed &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class FoldersCompanion extends UpdateCompanion<FolderRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<bool> isCollapsed;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.isCollapsed = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String name,
    this.isCollapsed = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : id = Value(id), name = Value(name);
  static Insertable<FolderRow> custom({
    Expression<String>? id,
    Expression<String?>? userId,
    Expression<String>? name,
    Expression<bool>? isCollapsed,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<DateTime?>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (isCollapsed != null) 'is_collapsed': isCollapsed,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  FoldersCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String>? name,
    Value<bool>? isCollapsed,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return FoldersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isCollapsed.present) {
      map['is_collapsed'] = Variable<bool>(isCollapsed.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isCollapsed: $isCollapsed, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}


class $ListsTable extends Lists
    with TableInfo<$ListsTable, TaskListRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta =
      const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>(
      'id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta =
      const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId =
      GeneratedColumn<String>(
      'user_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _folderIdMeta =
      const VerificationMeta('folderId');
  @override
  late final GeneratedColumn<String> folderId =
      GeneratedColumn<String>(
      'folder_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES folders (id) ON DELETE SET NULL'));
  static const VerificationMeta _nameMeta =
      const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>(
      'name',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorMeta =
      const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color =
      GeneratedColumn<int>(
      'color',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta =
      const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon =
      GeneratedColumn<String>(
      'icon',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('list'));
  static const VerificationMeta _kindMeta =
      const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind =
      GeneratedColumn<String>(
      'kind',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('tasks'));
  static const VerificationMeta _defaultViewMeta =
      const VerificationMeta('defaultView');
  @override
  late final GeneratedColumn<String> defaultView =
      GeneratedColumn<String>(
      'default_view',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('list'));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived =
      GeneratedColumn<bool>(
      'is_archived',
      aliasedName,
      false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));
  static const VerificationMeta _isSharedMeta =
      const VerificationMeta('isShared');
  @override
  late final GeneratedColumn<bool> isShared =
      GeneratedColumn<bool>(
      'is_shared',
      aliasedName,
      false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder =
      GeneratedColumn<int>(
      'sort_order',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt =
      GeneratedColumn<DateTime>(
      'updated_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt =
      GeneratedColumn<DateTime>(
      'deleted_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, userId, folderId, name, color, icon, kind, defaultView, isArchived, isShared, sortOrder, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskListRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
        _idMeta,
        id.isAcceptableOrUnknown(data['id']!, _idMeta),
      );
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('folder_id')) {
      context.handle(
        _folderIdMeta,
        folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('default_view')) {
      context.handle(
        _defaultViewMeta,
        defaultView.isAcceptableOrUnknown(data['default_view']!, _defaultViewMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_shared')) {
      context.handle(
        _isSharedMeta,
        isShared.isAcceptableOrUnknown(data['is_shared']!, _isSharedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskListRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskListRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      folderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      defaultView: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_view'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isShared: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_shared'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ListsTable createAlias(String alias) {
    return $ListsTable(attachedDatabase, alias);
  }
}


class TaskListRow extends DataClass implements Insertable<TaskListRow> {
  final String id;
  final String? userId;
  final String? folderId;
  final String name;
  final int color;
  final String icon;
  final String kind;
  final String defaultView;
  final bool isArchived;
  final bool isShared;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TaskListRow({
    required this.id,
    this.userId,
    this.folderId,
    required this.name,
    required this.color,
    required this.icon,
    required this.kind,
    required this.defaultView,
    required this.isArchived,
    required this.isShared,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<String>(folderId);
    }
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    map['icon'] = Variable<String>(icon);
    map['kind'] = Variable<String>(kind);
    map['default_view'] = Variable<String>(defaultView);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_shared'] = Variable<bool>(isShared);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ListsCompanion toCompanion(bool nullToAbsent) {
    return ListsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      folderId: folderId == null && nullToAbsent
          ? const Value.absent()
          : Value(folderId),
      name: Value(name),
      color: Value(color),
      icon: Value(icon),
      kind: Value(kind),
      defaultView: Value(defaultView),
      isArchived: Value(isArchived),
      isShared: Value(isShared),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TaskListRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskListRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      folderId: serializer.fromJson<String?>(json['folder_id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
      icon: serializer.fromJson<String>(json['icon']),
      kind: serializer.fromJson<String>(json['kind']),
      defaultView: serializer.fromJson<String>(json['default_view']),
      isArchived: serializer.fromJson<bool>(json['is_archived']),
      isShared: serializer.fromJson<bool>(json['is_shared']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  factory TaskListRow.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => TaskListRow.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'folder_id': serializer.toJson<String?>(folderId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'icon': serializer.toJson<String>(icon),
      'kind': serializer.toJson<String>(kind),
      'default_view': serializer.toJson<String>(defaultView),
      'is_archived': serializer.toJson<bool>(isArchived),
      'is_shared': serializer.toJson<bool>(isShared),
      'sort_order': serializer.toJson<int>(sortOrder),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TaskListRow copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    Value<String?> folderId = const Value.absent(),
    String? name,
    int? color,
    String? icon,
    String? kind,
    String? defaultView,
    bool? isArchived,
    bool? isShared,
    int? sortOrder,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TaskListRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    folderId: folderId.present ? folderId.value : this.folderId,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    kind: kind ?? this.kind,
    defaultView: defaultView ?? this.defaultView,
    isArchived: isArchived ?? this.isArchived,
    isShared: isShared ?? this.isShared,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TaskListRow copyWithCompanion(ListsCompanion data) {
    return TaskListRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      kind: data.kind.present ? data.kind.value : this.kind,
      defaultView: data.defaultView.present ? data.defaultView.value : this.defaultView,
      isArchived: data.isArchived.present ? data.isArchived.value : this.isArchived,
      isShared: data.isShared.present ? data.isShared.value : this.isShared,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskListRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('folderId: $folderId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('kind: $kind, ')
          ..write('defaultView: $defaultView, ')
          ..write('isArchived: $isArchived, ')
          ..write('isShared: $isShared, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, folderId, name, color, icon, kind, defaultView, isArchived, isShared, sortOrder, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskListRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.folderId == this.folderId &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.kind == this.kind &&
          other.defaultView == this.defaultView &&
          other.isArchived == this.isArchived &&
          other.isShared == this.isShared &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ListsCompanion extends UpdateCompanion<TaskListRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> folderId;
  final Value<String> name;
  final Value<int> color;
  final Value<String> icon;
  final Value<String> kind;
  final Value<String> defaultView;
  final Value<bool> isArchived;
  final Value<bool> isShared;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const ListsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.folderId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.kind = const Value.absent(),
    this.defaultView = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isShared = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  ListsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    this.folderId = const Value.absent(),
    required String name,
    required int color,
    this.icon = const Value.absent(),
    this.kind = const Value.absent(),
    this.defaultView = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isShared = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : id = Value(id), name = Value(name), color = Value(color);
  static Insertable<TaskListRow> custom({
    Expression<String>? id,
    Expression<String?>? userId,
    Expression<String?>? folderId,
    Expression<String>? name,
    Expression<int>? color,
    Expression<String>? icon,
    Expression<String>? kind,
    Expression<String>? defaultView,
    Expression<bool>? isArchived,
    Expression<bool>? isShared,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<DateTime?>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (folderId != null) 'folder_id': folderId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (kind != null) 'kind': kind,
      if (defaultView != null) 'default_view': defaultView,
      if (isArchived != null) 'is_archived': isArchived,
      if (isShared != null) 'is_shared': isShared,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  ListsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String?>? folderId,
    Value<String>? name,
    Value<int>? color,
    Value<String>? icon,
    Value<String>? kind,
    Value<String>? defaultView,
    Value<bool>? isArchived,
    Value<bool>? isShared,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return ListsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      folderId: folderId ?? this.folderId,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      kind: kind ?? this.kind,
      defaultView: defaultView ?? this.defaultView,
      isArchived: isArchived ?? this.isArchived,
      isShared: isShared ?? this.isShared,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<String>(folderId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (defaultView.present) {
      map['default_view'] = Variable<String>(defaultView.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isShared.present) {
      map['is_shared'] = Variable<bool>(isShared.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('folderId: $folderId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('kind: $kind, ')
          ..write('defaultView: $defaultView, ')
          ..write('isArchived: $isArchived, ')
          ..write('isShared: $isShared, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}


class $SectionsTable extends Sections
    with TableInfo<$SectionsTable, SectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta =
      const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>(
      'id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _listIdMeta =
      const VerificationMeta('listId');
  @override
  late final GeneratedColumn<String> listId =
      GeneratedColumn<String>(
      'list_id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES lists (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta =
      const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>(
      'name',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder =
      GeneratedColumn<int>(
      'sort_order',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt =
      GeneratedColumn<DateTime>(
      'updated_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt =
      GeneratedColumn<DateTime>(
      'deleted_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, listId, name, sortOrder, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<SectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
        _idMeta,
        id.isAcceptableOrUnknown(data['id']!, _idMeta),
      );
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}list_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}


class SectionRow extends DataClass implements Insertable<SectionRow> {
  final String id;
  final String listId;
  final String name;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const SectionRow({
    required this.id,
    required this.listId,
    required this.name,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['list_id'] = Variable<String>(listId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      listId: Value(listId),
      name: Value(name),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SectionRow(
      id: serializer.fromJson<String>(json['id']),
      listId: serializer.fromJson<String>(json['list_id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  factory SectionRow.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => SectionRow.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'list_id': serializer.toJson<String>(listId),
      'name': serializer.toJson<String>(name),
      'sort_order': serializer.toJson<int>(sortOrder),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SectionRow copyWith({
    String? id,
    String? listId,
    String? name,
    int? sortOrder,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => SectionRow(
    id: id ?? this.id,
    listId: listId ?? this.listId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  SectionRow copyWithCompanion(SectionsCompanion data) {
    return SectionRow(
      id: data.id.present ? data.id.value : this.id,
      listId: data.listId.present ? data.listId.value : this.listId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SectionRow(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, listId, name, sortOrder, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SectionRow &&
          other.id == this.id &&
          other.listId == this.listId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SectionsCompanion extends UpdateCompanion<SectionRow> {
  final Value<String> id;
  final Value<String> listId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.listId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  SectionsCompanion.insert({
    required String id,
    required String listId,
    required String name,
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : id = Value(id), listId = Value(listId), name = Value(name);
  static Insertable<SectionRow> custom({
    Expression<String>? id,
    Expression<String>? listId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<DateTime?>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listId != null) 'list_id': listId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  SectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? listId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return SectionsCompanion(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<String>(listId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('listId: $listId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}


class $TasksTable extends Tasks
    with TableInfo<$TasksTable, TaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta =
      const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>(
      'id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta =
      const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId =
      GeneratedColumn<String>(
      'user_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _listIdMeta =
      const VerificationMeta('listId');
  @override
  late final GeneratedColumn<String> listId =
      GeneratedColumn<String>(
      'list_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES lists (id) ON DELETE CASCADE'));
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId =
      GeneratedColumn<String>(
      'parent_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES tasks (id) ON DELETE CASCADE'));
  static const VerificationMeta _sectionIdMeta =
      const VerificationMeta('sectionId');
  @override
  late final GeneratedColumn<String> sectionId =
      GeneratedColumn<String>(
      'section_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES sections (id) ON DELETE SET NULL'));
  static const VerificationMeta _titleMeta =
      const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>(
      'title',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description =
      GeneratedColumn<String>(
      'description',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _statusMeta =
      const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status =
      GeneratedColumn<String>(
      'status',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority =
      GeneratedColumn<int>(
      'priority',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _startAtMeta =
      const VerificationMeta('startAt');
  @override
  late final GeneratedColumn<DateTime> startAt =
      GeneratedColumn<DateTime>(
      'start_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  static const VerificationMeta _dueAtMeta =
      const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt =
      GeneratedColumn<DateTime>(
      'due_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  static const VerificationMeta _isAllDayMeta =
      const VerificationMeta('isAllDay');
  @override
  late final GeneratedColumn<bool> isAllDay =
      GeneratedColumn<bool>(
      'is_all_day',
      aliasedName,
      false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));
  static const VerificationMeta _timeZoneMeta =
      const VerificationMeta('timeZone');
  @override
  late final GeneratedColumn<String> timeZone =
      GeneratedColumn<String>(
      'time_zone',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _recurrenceRuleMeta =
      const VerificationMeta('recurrenceRule');
  @override
  late final GeneratedColumn<String> recurrenceRule =
      GeneratedColumn<String>(
      'recurrence_rule',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _remindersMeta =
      const VerificationMeta('reminders');
  @override
  late final GeneratedColumn<String> reminders =
      GeneratedColumn<String>(
      'reminders',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _estimatedMinutesMeta =
      const VerificationMeta('estimatedMinutes');
  @override
  late final GeneratedColumn<int> estimatedMinutes =
      GeneratedColumn<int>(
      'estimated_minutes',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _estimatedPomodorosMeta =
      const VerificationMeta('estimatedPomodoros');
  @override
  late final GeneratedColumn<int> estimatedPomodoros =
      GeneratedColumn<int>(
      'estimated_pomodoros',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt =
      GeneratedColumn<DateTime>(
      'completed_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned =
      GeneratedColumn<bool>(
      'is_pinned',
      aliasedName,
      false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt =
      GeneratedColumn<DateTime>(
      'created_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder =
      GeneratedColumn<int>(
      'sort_order',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt =
      GeneratedColumn<DateTime>(
      'updated_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt =
      GeneratedColumn<DateTime>(
      'deleted_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, userId, listId, parentId, sectionId, title, description, status, priority, startAt, dueAt, isAllDay, timeZone, recurrenceRule, reminders, estimatedMinutes, estimatedPomodoros, completedAt, isPinned, createdAt, sortOrder, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
        _idMeta,
        id.isAcceptableOrUnknown(data['id']!, _idMeta),
      );
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('list_id')) {
      context.handle(
        _listIdMeta,
        listId.isAcceptableOrUnknown(data['list_id']!, _listIdMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(data['description']!, _descriptionMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('is_all_day')) {
      context.handle(
        _isAllDayMeta,
        isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta),
      );
    }
    if (data.containsKey('time_zone')) {
      context.handle(
        _timeZoneMeta,
        timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta),
      );
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
        _recurrenceRuleMeta,
        recurrenceRule.isAcceptableOrUnknown(data['recurrence_rule']!, _recurrenceRuleMeta),
      );
    }
    if (data.containsKey('reminders')) {
      context.handle(
        _remindersMeta,
        reminders.isAcceptableOrUnknown(data['reminders']!, _remindersMeta),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(data['estimated_minutes']!, _estimatedMinutesMeta),
      );
    }
    if (data.containsKey('estimated_pomodoros')) {
      context.handle(
        _estimatedPomodorosMeta,
        estimatedPomodoros.isAcceptableOrUnknown(data['estimated_pomodoros']!, _estimatedPomodorosMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(data['completed_at']!, _completedAtMeta),
      );
    }
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      listId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}list_id'],
      ),
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      isAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_all_day'],
      )!,
      timeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone'],
      ),
      recurrenceRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_rule'],
      ),
      reminders: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminders'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      estimatedPomodoros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_pomodoros'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}


class TaskRow extends DataClass implements Insertable<TaskRow> {
  final String id;
  final String? userId;
  final String? listId;
  final String? parentId;
  final String? sectionId;
  final String title;
  final String description;
  final String status;
  final int priority;
  final DateTime? startAt;
  final DateTime? dueAt;
  final bool isAllDay;
  final String? timeZone;
  final String? recurrenceRule;
  final String reminders;
  final int estimatedMinutes;
  final int estimatedPomodoros;
  final DateTime? completedAt;
  final bool isPinned;
  final DateTime createdAt;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TaskRow({
    required this.id,
    this.userId,
    this.listId,
    this.parentId,
    this.sectionId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    this.startAt,
    this.dueAt,
    required this.isAllDay,
    this.timeZone,
    this.recurrenceRule,
    required this.reminders,
    required this.estimatedMinutes,
    required this.estimatedPomodoros,
    this.completedAt,
    required this.isPinned,
    required this.createdAt,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || listId != null) {
      map['list_id'] = Variable<String>(listId);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<String>(sectionId);
    }
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<DateTime>(startAt);
    }
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    map['is_all_day'] = Variable<bool>(isAllDay);
    if (!nullToAbsent || timeZone != null) {
      map['time_zone'] = Variable<String>(timeZone);
    }
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    map['reminders'] = Variable<String>(reminders);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['estimated_pomodoros'] = Variable<int>(estimatedPomodoros);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['is_pinned'] = Variable<bool>(isPinned);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      listId: listId == null && nullToAbsent
          ? const Value.absent()
          : Value(listId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      title: Value(title),
      description: Value(description),
      status: Value(status),
      priority: Value(priority),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      isAllDay: Value(isAllDay),
      timeZone: timeZone == null && nullToAbsent
          ? const Value.absent()
          : Value(timeZone),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      reminders: Value(reminders),
      estimatedMinutes: Value(estimatedMinutes),
      estimatedPomodoros: Value(estimatedPomodoros),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      isPinned: Value(isPinned),
      createdAt: Value(createdAt),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      listId: serializer.fromJson<String?>(json['list_id']),
      parentId: serializer.fromJson<String?>(json['parent_id']),
      sectionId: serializer.fromJson<String?>(json['section_id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<int>(json['priority']),
      startAt: serializer.fromJson<DateTime?>(json['start_at']),
      dueAt: serializer.fromJson<DateTime?>(json['due_at']),
      isAllDay: serializer.fromJson<bool>(json['is_all_day']),
      timeZone: serializer.fromJson<String?>(json['time_zone']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrence_rule']),
      reminders: serializer.fromJson<String>(json['reminders']),
      estimatedMinutes: serializer.fromJson<int>(json['estimated_minutes']),
      estimatedPomodoros: serializer.fromJson<int>(json['estimated_pomodoros']),
      completedAt: serializer.fromJson<DateTime?>(json['completed_at']),
      isPinned: serializer.fromJson<bool>(json['is_pinned']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  factory TaskRow.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => TaskRow.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'list_id': serializer.toJson<String?>(listId),
      'parent_id': serializer.toJson<String?>(parentId),
      'section_id': serializer.toJson<String?>(sectionId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<int>(priority),
      'start_at': serializer.toJson<DateTime?>(startAt),
      'due_at': serializer.toJson<DateTime?>(dueAt),
      'is_all_day': serializer.toJson<bool>(isAllDay),
      'time_zone': serializer.toJson<String?>(timeZone),
      'recurrence_rule': serializer.toJson<String?>(recurrenceRule),
      'reminders': serializer.toJson<String>(reminders),
      'estimated_minutes': serializer.toJson<int>(estimatedMinutes),
      'estimated_pomodoros': serializer.toJson<int>(estimatedPomodoros),
      'completed_at': serializer.toJson<DateTime?>(completedAt),
      'is_pinned': serializer.toJson<bool>(isPinned),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'sort_order': serializer.toJson<int>(sortOrder),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TaskRow copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    Value<String?> listId = const Value.absent(),
    Value<String?> parentId = const Value.absent(),
    Value<String?> sectionId = const Value.absent(),
    String? title,
    String? description,
    String? status,
    int? priority,
    Value<DateTime?> startAt = const Value.absent(),
    Value<DateTime?> dueAt = const Value.absent(),
    bool? isAllDay,
    Value<String?> timeZone = const Value.absent(),
    Value<String?> recurrenceRule = const Value.absent(),
    String? reminders,
    int? estimatedMinutes,
    int? estimatedPomodoros,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? isPinned,
    DateTime? createdAt,
    int? sortOrder,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TaskRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    listId: listId.present ? listId.value : this.listId,
    parentId: parentId.present ? parentId.value : this.parentId,
    sectionId: sectionId.present ? sectionId.value : this.sectionId,
    title: title ?? this.title,
    description: description ?? this.description,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    startAt: startAt.present ? startAt.value : this.startAt,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    isAllDay: isAllDay ?? this.isAllDay,
    timeZone: timeZone.present ? timeZone.value : this.timeZone,
    recurrenceRule: recurrenceRule.present ? recurrenceRule.value : this.recurrenceRule,
    reminders: reminders ?? this.reminders,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isPinned: isPinned ?? this.isPinned,
    createdAt: createdAt ?? this.createdAt,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TaskRow copyWithCompanion(TasksCompanion data) {
    return TaskRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      listId: data.listId.present ? data.listId.value : this.listId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      recurrenceRule: data.recurrenceRule.present ? data.recurrenceRule.value : this.recurrenceRule,
      reminders: data.reminders.present ? data.reminders.value : this.reminders,
      estimatedMinutes: data.estimatedMinutes.present ? data.estimatedMinutes.value : this.estimatedMinutes,
      estimatedPomodoros: data.estimatedPomodoros.present ? data.estimatedPomodoros.value : this.estimatedPomodoros,
      completedAt: data.completedAt.present ? data.completedAt.value : this.completedAt,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('listId: $listId, ')
          ..write('parentId: $parentId, ')
          ..write('sectionId: $sectionId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('timeZone: $timeZone, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('reminders: $reminders, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('estimatedPomodoros: $estimatedPomodoros, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([id, userId, listId, parentId, sectionId, title, description, status, priority, startAt, dueAt, isAllDay, timeZone, recurrenceRule, reminders, estimatedMinutes, estimatedPomodoros, completedAt, isPinned, createdAt, sortOrder, updatedAt, deletedAt]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.listId == this.listId &&
          other.parentId == this.parentId &&
          other.sectionId == this.sectionId &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.startAt == this.startAt &&
          other.dueAt == this.dueAt &&
          other.isAllDay == this.isAllDay &&
          other.timeZone == this.timeZone &&
          other.recurrenceRule == this.recurrenceRule &&
          other.reminders == this.reminders &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.estimatedPomodoros == this.estimatedPomodoros &&
          other.completedAt == this.completedAt &&
          other.isPinned == this.isPinned &&
          other.createdAt == this.createdAt &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TasksCompanion extends UpdateCompanion<TaskRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> listId;
  final Value<String?> parentId;
  final Value<String?> sectionId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> status;
  final Value<int> priority;
  final Value<DateTime?> startAt;
  final Value<DateTime?> dueAt;
  final Value<bool> isAllDay;
  final Value<String?> timeZone;
  final Value<String?> recurrenceRule;
  final Value<String> reminders;
  final Value<int> estimatedMinutes;
  final Value<int> estimatedPomodoros;
  final Value<DateTime?> completedAt;
  final Value<bool> isPinned;
  final Value<DateTime> createdAt;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.listId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.reminders = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.estimatedPomodoros = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    this.listId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.sectionId = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.reminders = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.estimatedPomodoros = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : id = Value(id), title = Value(title);
  static Insertable<TaskRow> custom({
    Expression<String>? id,
    Expression<String?>? userId,
    Expression<String?>? listId,
    Expression<String?>? parentId,
    Expression<String?>? sectionId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<int>? priority,
    Expression<DateTime?>? startAt,
    Expression<DateTime?>? dueAt,
    Expression<bool>? isAllDay,
    Expression<String?>? timeZone,
    Expression<String?>? recurrenceRule,
    Expression<String>? reminders,
    Expression<int>? estimatedMinutes,
    Expression<int>? estimatedPomodoros,
    Expression<DateTime?>? completedAt,
    Expression<bool>? isPinned,
    Expression<DateTime>? createdAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<DateTime?>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (listId != null) 'list_id': listId,
      if (parentId != null) 'parent_id': parentId,
      if (sectionId != null) 'section_id': sectionId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (startAt != null) 'start_at': startAt,
      if (dueAt != null) 'due_at': dueAt,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (timeZone != null) 'time_zone': timeZone,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (reminders != null) 'reminders': reminders,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (estimatedPomodoros != null) 'estimated_pomodoros': estimatedPomodoros,
      if (completedAt != null) 'completed_at': completedAt,
      if (isPinned != null) 'is_pinned': isPinned,
      if (createdAt != null) 'created_at': createdAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String?>? listId,
    Value<String?>? parentId,
    Value<String?>? sectionId,
    Value<String>? title,
    Value<String>? description,
    Value<String>? status,
    Value<int>? priority,
    Value<DateTime?>? startAt,
    Value<DateTime?>? dueAt,
    Value<bool>? isAllDay,
    Value<String?>? timeZone,
    Value<String?>? recurrenceRule,
    Value<String>? reminders,
    Value<int>? estimatedMinutes,
    Value<int>? estimatedPomodoros,
    Value<DateTime?>? completedAt,
    Value<bool>? isPinned,
    Value<DateTime>? createdAt,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      listId: listId ?? this.listId,
      parentId: parentId ?? this.parentId,
      sectionId: sectionId ?? this.sectionId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startAt: startAt ?? this.startAt,
      dueAt: dueAt ?? this.dueAt,
      isAllDay: isAllDay ?? this.isAllDay,
      timeZone: timeZone ?? this.timeZone,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      reminders: reminders ?? this.reminders,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      estimatedPomodoros: estimatedPomodoros ?? this.estimatedPomodoros,
      completedAt: completedAt ?? this.completedAt,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (listId.present) {
      map['list_id'] = Variable<String>(listId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (reminders.present) {
      map['reminders'] = Variable<String>(reminders.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (estimatedPomodoros.present) {
      map['estimated_pomodoros'] = Variable<int>(estimatedPomodoros.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('listId: $listId, ')
          ..write('parentId: $parentId, ')
          ..write('sectionId: $sectionId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('timeZone: $timeZone, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('reminders: $reminders, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('estimatedPomodoros: $estimatedPomodoros, ')
          ..write('completedAt: $completedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}


class $TagsTable extends Tags
    with TableInfo<$TagsTable, TagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta =
      const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>(
      'id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta =
      const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId =
      GeneratedColumn<String>(
      'user_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _nameMeta =
      const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>(
      'name',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _colorMeta =
      const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color =
      GeneratedColumn<int>(
      'color',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _parentTagIdMeta =
      const VerificationMeta('parentTagId');
  @override
  late final GeneratedColumn<String> parentTagId =
      GeneratedColumn<String>(
      'parent_tag_id',
      aliasedName,
      true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES tags (id) ON DELETE SET NULL'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder =
      GeneratedColumn<int>(
      'sort_order',
      aliasedName,
      false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt =
      GeneratedColumn<DateTime>(
      'updated_at',
      aliasedName,
      false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt =
      GeneratedColumn<DateTime>(
      'deleted_at',
      aliasedName,
      true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, color, parentTagId, sortOrder, updatedAt, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(
        _idMeta,
        id.isAcceptableOrUnknown(data['id']!, _idMeta),
      );
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('parent_tag_id')) {
      context.handle(
        _parentTagIdMeta,
        parentTagId.isAcceptableOrUnknown(data['parent_tag_id']!, _parentTagIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      parentTagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_tag_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}


class TagRow extends DataClass implements Insertable<TagRow> {
  final String id;
  final String? userId;
  final String name;
  final int color;
  final String? parentTagId;
  final int sortOrder;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TagRow({
    required this.id,
    this.userId,
    required this.name,
    required this.color,
    this.parentTagId,
    required this.sortOrder,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || parentTagId != null) {
      map['parent_tag_id'] = Variable<String>(parentTagId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      name: Value(name),
      color: Value(color),
      parentTagId: parentTagId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTagId),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['user_id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
      parentTagId: serializer.fromJson<String?>(json['parent_tag_id']),
      sortOrder: serializer.fromJson<int>(json['sort_order']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  factory TagRow.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => TagRow.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'user_id': serializer.toJson<String?>(userId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'parent_tag_id': serializer.toJson<String?>(parentTagId),
      'sort_order': serializer.toJson<int>(sortOrder),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TagRow copyWith({
    String? id,
    Value<String?> userId = const Value.absent(),
    String? name,
    int? color,
    Value<String?> parentTagId = const Value.absent(),
    int? sortOrder,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => TagRow(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    name: name ?? this.name,
    color: color ?? this.color,
    parentTagId: parentTagId.present ? parentTagId.value : this.parentTagId,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  TagRow copyWithCompanion(TagsCompanion data) {
    return TagRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      parentTagId: data.parentTagId.present ? data.parentTagId.value : this.parentTagId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('parentTagId: $parentTagId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, color, parentTagId, sortOrder, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.color == this.color &&
          other.parentTagId == this.parentTagId &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TagsCompanion extends UpdateCompanion<TagRow> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<int> color;
  final Value<String?> parentTagId;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.parentTagId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String name,
    required int color,
    this.parentTagId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : id = Value(id), name = Value(name), color = Value(color);
  static Insertable<TagRow> custom({
    Expression<String>? id,
    Expression<String?>? userId,
    Expression<String>? name,
    Expression<int>? color,
    Expression<String?>? parentTagId,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<DateTime?>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (parentTagId != null) 'parent_tag_id': parentTagId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String?>? userId,
    Value<String>? name,
    Value<int>? color,
    Value<String?>? parentTagId,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      color: color ?? this.color,
      parentTagId: parentTagId ?? this.parentTagId,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (parentTagId.present) {
      map['parent_tag_id'] = Variable<String>(parentTagId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('parentTagId: $parentTagId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}


class $TaskTagsTable extends TaskTags
    with TableInfo<$TaskTagsTable, TaskTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta =
      const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId =
      GeneratedColumn<String>(
      'task_id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES tasks (id) ON DELETE CASCADE'));
  static const VerificationMeta _tagIdMeta =
      const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId =
      GeneratedColumn<String>(
      'tag_id',
      aliasedName,
      false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES tags (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [taskId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId, tagId};
  @override
  TaskTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTag(
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $TaskTagsTable createAlias(String alias) {
    return $TaskTagsTable(attachedDatabase, alias);
  }
}


class TaskTag extends DataClass implements Insertable<TaskTag> {
  final String taskId;
  final String tagId;
  const TaskTag({
    required this.taskId,
    required this.tagId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  TaskTagsCompanion toCompanion(bool nullToAbsent) {
    return TaskTagsCompanion(
      taskId: Value(taskId),
      tagId: Value(tagId),
    );
  }

  factory TaskTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTag(
      taskId: serializer.fromJson<String>(json['task_id']),
      tagId: serializer.fromJson<String>(json['tag_id']),
    );
  }
  factory TaskTag.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => TaskTag.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'task_id': serializer.toJson<String>(taskId),
      'tag_id': serializer.toJson<String>(tagId),
    };
  }

  TaskTag copyWith({
    String? taskId,
    String? tagId,
  }) => TaskTag(
    taskId: taskId ?? this.taskId,
    tagId: tagId ?? this.tagId,
  );
  TaskTag copyWithCompanion(TaskTagsCompanion data) {
    return TaskTag(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTag(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTag &&
          other.taskId == this.taskId &&
          other.tagId == this.tagId);
}

class TaskTagsCompanion extends UpdateCompanion<TaskTag> {
  final Value<String> taskId;
  final Value<String> tagId;
  const TaskTagsCompanion({
    this.taskId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  TaskTagsCompanion.insert({
    required String taskId,
    required String tagId,
  }) : taskId = Value(taskId), tagId = Value(tagId);
  static Insertable<TaskTag> custom({
    Expression<String>? taskId,
    Expression<String>? tagId,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (tagId != null) 'tag_id': tagId,
    });
  }

  TaskTagsCompanion copyWith({
    Value<String>? taskId,
    Value<String>? tagId,
  }) {
    return TaskTagsCompanion(
      taskId: taskId ?? this.taskId,
      tagId: tagId ?? this.tagId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTagsCompanion(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }
}


abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  late final $FoldersTable folders = $FoldersTable(this);
  late final $ListsTable lists = $ListsTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TaskTagsTable taskTags = $TaskTagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    folders,
    lists,
    sections,
    tasks,
    tags,
    taskTags
  ];
}
