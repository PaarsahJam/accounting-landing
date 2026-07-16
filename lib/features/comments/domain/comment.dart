/// A single comment or internal note attached to a document entity.
class Comment {
  const Comment({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.author,
    required this.createdAt,
    required this.message,
    this.editedAt,
  });

  final String id;

  /// Owning entity type (e.g. `'salesInvoice'`, `'purchaseOrder'`).
  final String entityType;

  /// Owning entity id (e.g. `'SI-2026-000001'`).
  final String entityId;

  final String author;
  final DateTime createdAt;
  final String message;

  /// Non-null when the comment has been edited after creation.
  final DateTime? editedAt;

  bool get isEdited => editedAt != null;

  Comment copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? author,
    DateTime? createdAt,
    String? message,
    Object? editedAt = _sentinel,
  }) {
    return Comment(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      editedAt: editedAt == _sentinel ? this.editedAt : editedAt as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Comment(id: $id, author: $author)';
}

const _sentinel = Object();
