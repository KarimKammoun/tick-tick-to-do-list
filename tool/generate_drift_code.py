#!/usr/bin/env python3
"""Replica of drift_dev's output for lib/core/database/database_tables.dart.

WHY THIS SCRIPT EXISTS
----------------------
`dart run build_runner build` is the normal way to produce
`lib/core/database/app_database.g.dart`. The development sandbox of this
repository has no Dart/Flutter SDK and cannot download one (see
docs/PROGRESS.md), so the generated file is produced here, from the same
information the generator uses, and checked into the repository.

HOW TO REGENERATE
-----------------
The authoritative command is, on any machine with the Flutter SDK:

    dart run build_runner build --delete-conflicting-outputs

Prefer it as soon as a table changes. This script is kept only so the file can
be reviewed and diffed when the sandbox cannot run the generator; it mirrors the
drift 2.x output shape (see drift/test/generated/*.g.dart upstream).

Run: python3 tool/generate_drift_code.py
"""

from __future__ import annotations

import os
from dataclasses import dataclass, field

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


@dataclass
class Column:
    dart: str          # getter name in the table class
    sql: str           # column name in sqlite
    type: str          # dart type
    nullable: bool
    drift: str         # DriftSqlType member
    kind: str = ""     # '', 'default', 'client', 'ref'
    default: str | None = None   # dart literal for defaultValue
    references: str | None = None  # 'table.column ondelete=...'

    @property
    def inner_type(self) -> str:
        """Sql-level Dart type, without the nullability marker."""
        return self.type[:-1] if self.type.endswith("?") else self.type

    @property
    def required_during_insert(self) -> bool:
        """Drift requires a value when the column can neither be absent nor
        defaulted."""
        return not self.nullable and self.kind not in ("default", "client")


@dataclass
class Table:
    dsl: str
    row: str
    companion: str
    sql_name: str
    columns: list[Column]
    primary_key: list[str] = field(default_factory=list)
    extra: list[str] = field(default_factory=list)
    info: str = ""


SYNC = [
    Column("id", "id", "String", False, "string"),
    Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
    Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
    Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
]

TABLES = [
    Table(
        dsl="Folders",
        row="FolderRow",
        companion="FoldersCompanion",
        sql_name="folders",
        columns=[
            Column("id", "id", "String", False, "string"),
            Column("userId", "user_id", "String?", True, "string"),
            Column("name", "name", "String", False, "string"),
            Column("isCollapsed", "is_collapsed", "bool", False, "bool", "default", "false"),
            Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
            Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
            Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
        ],
        primary_key=["id"],
    ),
    Table(
        dsl="Lists",
        row="TaskListRow",
        companion="ListsCompanion",
        sql_name="lists",
        columns=[
            Column("id", "id", "String", False, "string"),
            Column("userId", "user_id", "String?", True, "string"),
            Column("folderId", "folder_id", "String?", True, "string",
                   "ref", references="folders.id|setNull"),
            Column("name", "name", "String", False, "string"),
            Column("color", "color", "int", False, "int"),
            Column("icon", "icon", "String", False, "string", "default", "'list'"),
            Column("kind", "kind", "String", False, "string", "default", "'tasks'"),
            Column("defaultView", "default_view", "String", False, "string",
                   "default", "'list'"),
            Column("isArchived", "is_archived", "bool", False, "bool", "default", "false"),
            Column("isShared", "is_shared", "bool", False, "bool", "default", "false"),
            Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
            Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
            Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
        ],
        primary_key=["id"],
    ),
    Table(
        dsl="Sections",
        row="SectionRow",
        companion="SectionsCompanion",
        sql_name="sections",
        columns=[
            Column("id", "id", "String", False, "string"),
            Column("listId", "list_id", "String", False, "string",
                   "ref", references="lists.id|cascade"),
            Column("name", "name", "String", False, "string"),
            Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
            Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
            Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
        ],
        primary_key=["id"],
    ),
    Table(
        dsl="Tasks",
        row="TaskRow",
        companion="TasksCompanion",
        sql_name="tasks",
        columns=[
            Column("id", "id", "String", False, "string"),
            Column("userId", "user_id", "String?", True, "string"),
            Column("listId", "list_id", "String?", True, "string",
                   "ref", references="lists.id|cascade"),
            Column("parentId", "parent_id", "String?", True, "string",
                   "ref", references="tasks.id|cascade"),
            Column("sectionId", "section_id", "String?", True, "string",
                   "ref", references="sections.id|setNull"),
            Column("title", "title", "String", False, "string"),
            Column("description", "description", "String", False, "string", "default", "''"),
            Column("status", "status", "String", False, "string", "default", "'todo'"),
            Column("priority", "priority", "int", False, "int", "default", "0"),
            Column("startAt", "start_at", "DateTime?", True, "dateTime"),
            Column("dueAt", "due_at", "DateTime?", True, "dateTime"),
            Column("isAllDay", "is_all_day", "bool", False, "bool", "default", "false"),
            Column("timeZone", "time_zone", "String?", True, "string"),
            Column("recurrenceRule", "recurrence_rule", "String?", True, "string"),
            Column("reminders", "reminders", "String", False, "string", "default", "'[]'"),
            Column("estimatedMinutes", "estimated_minutes", "int", False, "int", "default", "0"),
            Column("estimatedPomodoros", "estimated_pomodoros", "int", False, "int", "default", "0"),
            Column("completedAt", "completed_at", "DateTime?", True, "dateTime"),
            Column("isPinned", "is_pinned", "bool", False, "bool", "default", "false"),
            Column("createdAt", "created_at", "DateTime", False, "dateTime", "client"),
            Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
            Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
            Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
        ],
        primary_key=["id"],
    ),
    Table(
        dsl="Tags",
        row="TagRow",
        companion="TagsCompanion",
        sql_name="tags",
        columns=[
            Column("id", "id", "String", False, "string"),
            Column("userId", "user_id", "String?", True, "string"),
            Column("name", "name", "String", False, "string"),
            Column("color", "color", "int", False, "int"),
            Column("parentTagId", "parent_tag_id", "String?", True, "string",
                   "ref", references="tags.id|setNull"),
            Column("sortOrder", "sort_order", "int", False, "int", "default", "0"),
            Column("updatedAt", "updated_at", "DateTime", False, "dateTime", "client"),
            Column("deletedAt", "deleted_at", "DateTime?", True, "dateTime"),
        ],
        primary_key=["id"],
    ),
    Table(
        dsl="TaskTags",
        row="TaskTag",
        companion="TaskTagsCompanion",
        sql_name="task_tags",
        columns=[
            Column("taskId", "task_id", "String", False, "string",
                   "ref", references="tasks.id|cascade"),
            Column("tagId", "tag_id", "String", False, "string",
                   "ref", references="tags.id|cascade"),
        ],
        primary_key=["taskId", "tagId"],
    ),
]

ON_DELETE = {
    "cascade": "ON DELETE CASCADE",
    "setNull": "ON DELETE SET NULL",
}

out: list[str] = []
w = out.append


def camel_to_lower_first(name: str) -> str:
    return name[0].lower() + name[1:]


def column_code(table: Table, column: Column) -> str:
    params = [
        f"'{column.sql}'",
        "aliasedName",
        "true" if column.nullable else "false",
        f"type: DriftSqlType.{column.drift}",
        f"requiredDuringInsert: {'true' if column.required_during_insert else 'false'}",
    ]
    constraints = []
    if column.references:
        target, action = column.references.split("|")
        constraints.append(f"REFERENCES {target.split('.')[0]} ({target.split('.')[1]}) "
                           f"{ON_DELETE[action]}")
    if constraints:
        literal = ", ".join(constraints)
        params.append(
            "defaultConstraints: GeneratedColumn.constraintIsAlways("
            f"'{literal}')"
        )
    if column.kind == "default":
        params.append(f"defaultValue: const Constant({column.default})")
    if column.kind == "client":
        params.append("clientDefault: () => DateTime.now().toUtc()")
    body = ",\n      ".join(params)
    return (
        f"  static const VerificationMeta _{column.dart}Meta =\n"
        f"      const VerificationMeta('{column.dart}');\n"
        f"  @override\n"
        f"  late final GeneratedColumn<{column.inner_type}> {column.dart} =\n"
        f"      GeneratedColumn<{column.inner_type}>(\n"
        f"      {body});"
    )


def map_expression(column: Column) -> str:
    access = (
        f"attachedDatabase.typeMapping.read(\n"
        f"        DriftSqlType.{column.drift},\n"
        f"        data['${{effectivePrefix}}{column.sql}'],\n"
        f"      )"
    )
    if column.nullable:
        return f"{column.dart}: {access},"
    return f"{column.dart}: {access}!,"


def data_class(table: Table) -> str:
    fields = "\n".join(
        f"  final {c.type} {c.dart};" for c in table.columns
    )
    required = [
        f"required this.{c.dart}" if not c.nullable else f"this.{c.dart}"
        for c in table.columns
    ]
    ctor = ",\n    ".join(required)
    to_columns = []
    for c in table.columns:
        assignment = f"map['{c.sql}'] = Variable<{c.inner_type}>({c.dart});"
        if c.nullable:
            assignment = (
                f"if (!nullToAbsent || {c.dart} != null) {{\n"
                f"      {assignment}\n"
                f"    }}"
            )
        to_columns.append(assignment)
    to_columns_code = "\n    ".join(to_columns)

    companion_fields = "\n".join(
        f"  final Value<{c.type}> {c.dart};" for c in table.columns
    )
    companion_ctor = "\n".join(
        f"    this.{c.dart} = const Value.absent()," for c in table.columns
    )
    insert_ctor = "\n".join(
        (
            f"    required {c.type} {c.dart},"
            if c.required_during_insert
            else f"    this.{c.dart} = const Value.absent(),"
        )
        for c in table.columns
    )
    insert_init = ", ".join(
        f"{c.dart} = Value({c.dart})"
        for c in table.columns
        if c.required_during_insert
    )
    custom = "\n".join(
        f"    Expression<{c.type}>? {c.dart}," for c in table.columns
    )
    custom_map = "\n".join(
        f"      if ({c.dart} != null) '{c.sql}': {c.dart}," for c in table.columns
    )
    copy_with = "\n".join(
        f"    Value<{c.type}>? {c.dart}," for c in table.columns
    )
    copy_body = "\n".join(
        f"      {c.dart}: {c.dart} ?? this.{c.dart}," for c in table.columns
    )
    companion_to_columns = "\n".join(
        f"    if ({c.dart}.present) {{\n"
        f"      map['{c.sql}'] = Variable<{c.inner_type}>({c.dart}.value);\n"
        f"    }}"
        for c in table.columns
    )
    row_to_companion = "\n".join(
        (
            f"      {c.dart}: {c.dart} == null && nullToAbsent\n"
            f"          ? const Value.absent()\n"
            f"          : Value({c.dart}),"
            if c.nullable
            else f"      {c.dart}: Value({c.dart}),"
        )
        for c in table.columns
    )
    row_copy_with = "\n".join(
        (
            f"    Value<{c.type}> {c.dart} = const Value.absent()," if c.nullable
            else f"    {c.type}? {c.dart},"
        )
        for c in table.columns
    )
    row_copy_body = "\n".join(
        (
            f"    {c.dart}: {c.dart}.present ? {c.dart}.value : this.{c.dart},"
            if c.nullable
            else f"    {c.dart}: {c.dart} ?? this.{c.dart},"
        )
        for c in table.columns
    )
    copy_with_companion = "\n".join(
        f"      {c.dart}: data.{c.dart}.present ? data.{c.dart}.value : this.{c.dart},"
        for c in table.columns
    )
    hash_args = ", ".join(c.dart for c in table.columns)
    if len(table.columns) > 20:
        hash_args = "hashAll([" + hash_args + "])"
    else:
        hash_args = "hash(" + hash_args + ")"
    equals = "\n          ".join(
        f"other.{c.dart} == this.{c.dart} &&" for c in table.columns
    ).rstrip(" &")
    to_string = "\n          ".join(
        f"..write('{c.dart}: ${c.dart}, ')" for c in table.columns[:-1]
    )
    last = table.columns[-1].dart
    json_from = "\n".join(
        f"      {c.dart}: serializer.fromJson<{c.type}>(json['{c.sql}']),"
        for c in table.columns
    )
    json_to = "\n".join(
        f"      '{c.sql}': serializer.toJson<{c.type}>({c.dart}),"
        for c in table.columns
    )

    return f"""
class {table.row} extends DataClass implements Insertable<{table.row}> {{
{fields}
  const {table.row}({{
    {ctor},
  }});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {{
    final map = <String, Expression>{{}};
    {to_columns_code}
    return map;
  }}

  {table.companion} toCompanion(bool nullToAbsent) {{
    return {table.companion}(
{row_to_companion}
    );
  }}

  factory {table.row}.fromJson(
    Map<String, dynamic> json, {{
    ValueSerializer? serializer,
  }}) {{
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return {table.row}(
{json_from}
    );
  }}
  factory {table.row}.fromJsonString(
    String encodedJson, {{
    ValueSerializer? serializer,
  }}) => {table.row}.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({{ValueSerializer? serializer}}) {{
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{{
{json_to}
    }};
  }}

  {table.row} copyWith({{
{row_copy_with}
  }}) => {table.row}(
{row_copy_body}
  );
  {table.row} copyWithCompanion({table.companion} data) {{
    return {table.row}(
{copy_with_companion}
    );
  }}

  @override
  String toString() {{
    return (StringBuffer('{table.row}(')
          {to_string}
          ..write('{last}: ${last}')
          ..write(')'))
        .toString();
  }}

  @override
  int get hashCode => Object.{hash_args};
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is {table.row} &&
          {equals});
}}

class {table.companion} extends UpdateCompanion<{table.row}> {{
{companion_fields}
  const {table.companion}({{
{companion_ctor}
  }});
  {table.companion}.insert({{
{insert_ctor}
  }}) : {insert_init if insert_init else 'super()'};
  static Insertable<{table.row}> custom({{
{custom}
  }}) {{
    return RawValuesInsertable({{
{custom_map}
    }});
  }}

  {table.companion} copyWith({{
{copy_with}
  }}) {{
    return {table.companion}(
{copy_body}
    );
  }}

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {{
    final map = <String, Expression>{{}};
{companion_to_columns}
    return map;
  }}

  @override
  String toString() {{
    return (StringBuffer('{table.companion}(')
          {to_string}
          ..write('{last}: ${last}')
          ..write(')'))
        .toString();
  }}
}}
"""


def table_info(table: Table) -> str:
    columns = "\n".join(column_code(table, c) for c in table.columns)
    column_list = ", ".join(c.dart for c in table.columns)
    verification = "\n".join(
        f"""    if (data.containsKey('{c.sql}')) {{
      context.handle(
        _{c.dart}Meta,
        {c.dart}.isAcceptableOrUnknown(data['{c.sql}']!, _{c.dart}Meta),
      );
    }}"""
        + (
            f""" else if (isInserting) {{
      context.missing(_{c.dart}Meta);
    }}"""
            if c.required_during_insert
            else ""
        )
        for c in table.columns
    )
    map_body = "\n".join(f"      {map_expression(c)}" for c in table.columns)
    primary = ", ".join(table.primary_key)
    return f"""
class {table.info} extends {table.dsl}
    with TableInfo<{table.info}, {table.row}> {{
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  {table.info}(this.attachedDatabase, [this._alias]);
{columns}
  @override
  List<GeneratedColumn> get $columns => [{column_list}];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = '{table.sql_name}';
  @override
  VerificationContext validateIntegrity(
    Insertable<{table.row}> instance, {{
    bool isInserting = false,
  }}) {{
    final context = VerificationContext();
    final data = instance.toColumns(true);
{verification}
    return context;
  }}

  @override
  Set<GeneratedColumn> get $primaryKey => {{{primary}}};
  @override
  {table.row} map(Map<String, dynamic> data, {{String? tablePrefix}}) {{
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return {table.row}(
{map_body}
    );
  }}

  @override
  {table.info} createAlias(String alias) {{
    return {table.info}(attachedDatabase, alias);
  }}
}}
"""


def main() -> None:
    w("// GENERATED CODE - DO NOT MODIFY BY HAND")
    w("")
    w("part of 'app_database.dart';")
    w("")
    w("// ignore_for_file: type=lint, unused_element, unused_field")
    for table in TABLES:
        table.info = "$" + table.dsl + "Table"  # type: ignore[attr-defined]
        w(table_info(table))
        w(data_class(table))

    w("""
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
""")
    for table in TABLES:
        getter = camel_to_lower_first(table.dsl)
        w(f"  late final {table.info} {getter} = {table.info}(this);")
    w("  @override")
    w("  Iterable<TableInfo<Table, Object?>> get allTables =>")
    w("      allSchemaEntities.whereType<TableInfo<Table, Object?>>();")
    w("  @override")
    w("  List<DatabaseSchemaEntity> get allSchemaEntities => [")
    w(",\n".join("    " + camel_to_lower_first(t.dsl) for t in TABLES))
    w("  ];")
    w("}")

    target = os.path.join(ROOT, "lib", "core", "database", "app_database.g.dart")
    with open(target, "w", encoding="utf-8") as handle:
        handle.write("\n".join(out) + "\n")
    print("wrote", target)


if __name__ == "__main__":
    main()
