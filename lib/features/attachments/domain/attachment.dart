import 'attachment_file_type.dart';

/// Metadata record for a document attachment.
///
/// No real file bytes are stored — this is a pure metadata model
/// backed by a mock repository.
class Attachment {
  const Attachment({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.filename,
    required this.fileType,
    required this.fileSizeBytes,
    required this.uploadedAt,
    required this.uploadedBy,
    this.notes = '',
  });

  final String id;

  /// The owning entity type (matches [AuditEntityType] label strings, stored
  /// as a plain [String] so the attachment feature stays decoupled from audit).
  final String entityType;

  /// The owning entity's id.
  final String entityId;

  final String filename;
  final AttachmentFileType fileType;

  /// Size in bytes (mock value — no real file).
  final int fileSizeBytes;

  final DateTime uploadedAt;
  final String uploadedBy;
  final String notes;

  /// Human-readable file size string.
  String get formattedSize {
    if (fileSizeBytes < 1024) return '$fileSizeBytes B';
    if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Attachment copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? filename,
    AttachmentFileType? fileType,
    int? fileSizeBytes,
    DateTime? uploadedAt,
    String? uploadedBy,
    String? notes,
  }) {
    return Attachment(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      filename: filename ?? this.filename,
      fileType: fileType ?? this.fileType,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attachment && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Attachment(id: $id, filename: $filename)';
}
