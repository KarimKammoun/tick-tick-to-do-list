/// Domain model of a folder grouping several lists (spec section 4).
class Folder {
  const Folder({
    required this.id,
    required this.name,
    this.isCollapsed = false,
    this.sortOrder = 0,
    this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String name;
  final bool isCollapsed;
  final int sortOrder;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;
}
