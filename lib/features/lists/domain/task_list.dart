import 'package:flutter/painting.dart';

/// Kind of a list (spec section 4: `type` = tasks / notes).
enum ListType {
  tasks,
  notes;

  static ListType fromName(String name) => ListType.values.firstWhere(
        (ListType type) => type.name == name,
        orElse: () => ListType.tasks,
      );
}

/// Default view of a list (spec 5.8).
enum ListDefaultView {
  list,
  kanban,
  timeline;

  static ListDefaultView fromName(String name) =>
      ListDefaultView.values.firstWhere(
        (ListDefaultView view) => view.name == name,
        orElse: () => ListDefaultView.list,
      );
}

/// Domain model of a list.
class TaskList {
  const TaskList({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    this.folderId,
    this.kind = ListType.tasks,
    this.defaultView = ListDefaultView.list,
    this.sortOrder = 0,
    this.isArchived = false,
    this.isShared = false,
    this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String? folderId;
  final String name;
  final Color color;
  final String icon;
  final ListType kind;
  final ListDefaultView defaultView;
  final int sortOrder;
  final bool isArchived;
  final bool isShared;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;

  TaskList copyWith({
    String? name,
    Color? color,
    String? icon,
    String? folderId,
    bool clearFolder = false,
    ListDefaultView? defaultView,
    int? sortOrder,
    bool? isArchived,
  }) {
    return TaskList(
      id: id,
      folderId: clearFolder ? null : (folderId ?? this.folderId),
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      kind: kind,
      defaultView: defaultView ?? this.defaultView,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      isShared: isShared,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}
