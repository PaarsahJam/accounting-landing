// lib/features/audit_trail/domain/audit_filter.dart

import 'audit_action.dart';
import 'audit_entity_type.dart';

/// Immutable filter applied when querying the audit trail.
class AuditFilter {
  const AuditFilter({
    this.entityType,
    this.entityId,
    this.action,
    this.performedBy,
    this.from,
    this.to,
  });

  /// Restrict to a single entity type. `null` = all types.
  final AuditEntityType? entityType;

  /// Restrict to a single entity id. `null` = all ids.
  final String? entityId;

  /// Restrict to a single action. `null` = all actions.
  final AuditAction? action;

  /// Restrict to a single performer. `null` = all performers.
  final String? performedBy;

  /// Start of date range (inclusive). `null` = no lower bound.
  final DateTime? from;

  /// End of date range (inclusive). `null` = no upper bound.
  final DateTime? to;

  /// Returns `true` when [entry] passes every non-null criterion.
  bool matches(dynamic entry) {
    if (entityType != null && entry.entityType != entityType) return false;
    if (entityId != null && entry.entityId != entityId) return false;
    if (action != null && entry.action != action) return false;
    if (performedBy != null && entry.performedBy != performedBy) return false;
    if (from != null && entry.performedAt.isBefore(from!)) return false;
    if (to != null && entry.performedAt.isAfter(to!)) return false;
    return true;
  }

  AuditFilter copyWith({
    AuditEntityType? entityType,
    String? entityId,
    AuditAction? action,
    String? performedBy,
    DateTime? from,
    DateTime? to,
    bool clearEntityType = false,
    bool clearEntityId = false,
    bool clearAction = false,
    bool clearPerformedBy = false,
    bool clearFrom = false,
    bool clearTo = false,
  }) {
    return AuditFilter(
      entityType: clearEntityType ? null : entityType ?? this.entityType,
      entityId: clearEntityId ? null : entityId ?? this.entityId,
      action: clearAction ? null : action ?? this.action,
      performedBy: clearPerformedBy ? null : performedBy ?? this.performedBy,
      from: clearFrom ? null : from ?? this.from,
      to: clearTo ? null : to ?? this.to,
    );
  }

  /// Returns `true` when no filter criterion is set.
  bool get isEmpty =>
      entityType == null &&
      entityId == null &&
      action == null &&
      performedBy == null &&
      from == null &&
      to == null;
}
