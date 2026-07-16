// lib/features/document_numbering/document_record.dart

import 'document_status.dart';

/// A lightweight, feature-agnostic record that carries document lifecycle data.
///
/// Each feature (PO, VB, SI …) holds its own domain model.  A [DocumentRecord]
/// is the cross-cutting projection that the approval workflow and shared widgets
/// operate on.
class DocumentRecord {
  const DocumentRecord({
    required this.id,
    required this.documentNumber,
    required this.documentType,
    required this.status,
    required this.createdAt,
    this.approvedAt,
    this.postedAt,
  });

  /// Unique document identifier (same as the owning domain entity id).
  final String id;

  /// Formatted document number, e.g. `PO-2026-000001`.
  final String documentNumber;

  /// Free-form label for the document type, e.g. `"Purchase Order"`.
  final String documentType;

  /// Current lifecycle status.
  final DocumentStatus status;

  /// Timestamp when the document was created.
  final DateTime createdAt;

  /// Timestamp when the document was moved to [DocumentStatus.approved].
  final DateTime? approvedAt;

  /// Timestamp when the document was moved to [DocumentStatus.posted].
  final DateTime? postedAt;

  DocumentRecord copyWith({
    String? id,
    String? documentNumber,
    String? documentType,
    DocumentStatus? status,
    DateTime? createdAt,
    DateTime? approvedAt,
    DateTime? postedAt,
  }) {
    return DocumentRecord(
      id: id ?? this.id,
      documentNumber: documentNumber ?? this.documentNumber,
      documentType: documentType ?? this.documentType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      approvedAt: approvedAt ?? this.approvedAt,
      postedAt: postedAt ?? this.postedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          documentNumber == other.documentNumber &&
          documentType == other.documentType &&
          status == other.status &&
          createdAt == other.createdAt &&
          approvedAt == other.approvedAt &&
          postedAt == other.postedAt;

  @override
  int get hashCode => Object.hash(
    id,
    documentNumber,
    documentType,
    status,
    createdAt,
    approvedAt,
    postedAt,
  );

  @override
  String toString() =>
      'DocumentRecord(id: $id, number: $documentNumber, status: $status)';
}
