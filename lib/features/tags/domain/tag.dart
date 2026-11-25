import 'package:flutter/painting.dart';

/// Domain model of a tag (spec 5.7: coloured pills, optional hierarchy).
class Tag {
  const Tag({
    required this.id,
    required this.name,
    required this.color,
    this.parentTagId,
    this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String name;
  final Color color;
  final String? parentTagId;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;
}
