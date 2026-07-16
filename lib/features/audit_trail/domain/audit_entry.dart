// lib/features/audit_trail/domain/audit_entry.dart

import 'audit_action.dart';
import 'audit_entity_type.dart';

/// An immutable record of a single auditable event.
///
/// Entries are append-only — they are never mutated after creation.
class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.entityLabel,
    required this.action,
    required this.performedAt,
    this.performedBy = 'system',
    this.note,
    this.previousValue,
    this.newValue,
  });

  /// Unique identifier for this audit entry.
  final String id;

  /// The type of entity this entry belongs to.
  final AuditEntityType entityType;

  /// The owning entity's id (e.g. `"SI-2026-000001"`).
  final String entityId;

  /// Human-readable label for the entity (e.g. `"Sales Invoice #SI-2026-000001"`).
  final String entityLabel;

  /// What happened.
  final AuditAction action;

  /// When it happened (UTC preferred).
  final DateTime performedAt;

  /// Who performed the action (user name / id, defaults to `"system"`).
  final String performedBy;

  /// Optional free-form note or comment attached to this entry.
  final String? note;

  /// Optional: snapshot of the field value *before* the change.
  final String? previousValue;

  /// Optional: snapshot of the field value *after* the change.
  final String? newValue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditEntry && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'AuditEntry(id: $id, entity: $entityType/$entityId, action: ${action.label})';
}
