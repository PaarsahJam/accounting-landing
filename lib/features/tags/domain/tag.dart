/// A label that can be attached to any entity in the system.
class Tag {
  const Tag({
    required this.id,
    required this.name,
    required this.color,
    this.description = '',
  });

  final String id;

  /// Display name of the tag (e.g. "Urgent", "Reviewed").
  final String name;

  /// Hex colour string (e.g. `'#E53935'`). Used for visual differentiation.
  final String color;

  /// Optional longer explanation of the tag's purpose.
  final String description;

  Tag copyWith({String? id, String? name, String? color, String? description}) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Tag(id: $id, name: $name, color: $color)';
}

/// A join record linking a [Tag] to an entity (e.g. a purchase order).
class EntityTag {
  const EntityTag({
    required this.entityType,
    required this.entityId,
    required this.tagId,
  });

  /// Owning entity type string (e.g. `'purchaseOrder'`, `'salesInvoice'`).
  final String entityType;

  /// Owning entity id.
  final String entityId;

  /// The id of the linked [Tag].
  final String tagId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityTag &&
          entityType == other.entityType &&
          entityId == other.entityId &&
          tagId == other.tagId;

  @override
  int get hashCode => Object.hash(entityType, entityId, tagId);

  @override
  String toString() =>
      'EntityTag(entityType: $entityType, entityId: $entityId, tagId: $tagId)';
}
