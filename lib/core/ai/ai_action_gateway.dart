import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';

import 'ai_action.dart';

/// The result of checking an AI action against safety gates.
class AiConfirmationRequirement {
  const AiConfirmationRequirement({
    required this.requiresConfirmation,
    this.reason,
  });

  /// Whether explicit user confirmation is required before the action runs.
  final bool requiresConfirmation;

  /// Human-readable explanation if [requiresConfirmation] is true.
  final String? reason;
}

/// A pending action that has been approved by the user and is ready to execute.
class ConfirmedAction<T> {
  const ConfirmedAction({
    required this.actionType,
    required this.description,
    required this.action,
    this.entityType,
    this.entityId,
    this.entityLabel,
  });

  final AiActionType actionType;
  final String description;

  /// The actual mutation to execute.
  final Future<AppResult<T>> Function() action;
  final AuditEntityType? entityType;
  final String? entityId;
  final String? entityLabel;
}

/// Safety gate that enforces confirmation for financial mutations and
/// logs AI-initiated actions to the audit trail.
///
/// The AI layer is not allowed to directly mutate any domain data.
/// Instead it produces [ConfirmedAction]s that the UI presents to the
/// user. Only after the user explicitly confirms does the mutation run.
class AiActionGateway {
  AiActionGateway({
    required AuditTrailRepository auditRepository,
    required String performedBy,
  })  : _auditRepository = auditRepository,
        _performedBy = performedBy;

  final AuditTrailRepository _auditRepository;
  final String _performedBy;

  /// Checks whether [actionType] requires user confirmation.
  AiConfirmationRequirement checkAction(AiActionType actionType) {
    if (isFinancialMutation(actionType)) {
      return const AiConfirmationRequirement(
        requiresConfirmation: true,
        reason: 'Financial mutations require explicit user confirmation.',
      );
    }
    return const AiConfirmationRequirement(requiresConfirmation: false);
  }

  /// Wraps an action that the user has confirmed, executing it and
  /// logging the outcome to the audit trail.
  ///
  /// Returns the result of the action. On success, an audit entry is
  /// appended. On failure, a separate failure audit entry is appended.
  Future<AppResult<T>> executeConfirmed<T>(
    ConfirmedAction<T> confirmed,
  ) async {
    try {
      final result = await confirmed.action();

      if (result.isSuccess) {
        await _logAuditEntry(
          action: _auditActionFor(confirmed.actionType),
          entityType: confirmed.entityType ?? AuditEntityType.syncOperation,
          entityId: confirmed.entityId ?? 'ai-suggestion',
          entityLabel: confirmed.entityLabel ?? confirmed.description,
          note: 'AI-initiated action confirmed by user: ${confirmed.description}',
        );
      } else {
        await _logAuditEntry(
          action: AuditAction.aiActionGenerated,
          entityType: AuditEntityType.syncOperation,
          entityId: 'ai-suggestion',
          entityLabel: confirmed.description,
          note: 'AI-initiated action failed: ${result.error?.message}',
        );
      }

      return result;
    } catch (e) {
      await _logAuditEntry(
        action: AuditAction.aiActionGenerated,
        entityType: AuditEntityType.syncOperation,
        entityId: 'ai-suggestion',
        entityLabel: confirmed.description,
        note: 'AI-initiated action threw exception: $e',
      );
      return AppResult.failure(
        UnknownFailure(message: 'AI action execution failed: $e'),
      );
    }
  }

  AuditAction _auditActionFor(AiActionType type) {
    switch (type) {
      case AiActionType.draftCreate:
        return AuditAction.created;
      case AiActionType.draftUpdate:
        return AuditAction.edited;
      case AiActionType.draftDelete:
        return AuditAction.deleted;
      case AiActionType.summarize:
      case AiActionType.suggestAction:
        return AuditAction.aiActionGenerated;
    }
  }

  Future<void> _logAuditEntry({
    required AuditAction action,
    required AuditEntityType entityType,
    required String entityId,
    required String entityLabel,
    String? note,
  }) async {
    await _auditRepository.addEntry(
      AuditEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        entityType: entityType,
        entityId: entityId,
        entityLabel: entityLabel,
        action: action,
        performedAt: DateTime.now(),
        performedBy: _performedBy,
        note: note,
      ),
    );
  }
}
