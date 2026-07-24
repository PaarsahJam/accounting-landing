import '../../audit_trail/domain/audit_action.dart';
import '../../audit_trail/domain/audit_entry.dart';
import '../../audit_trail/domain/audit_entity_type.dart';
import '../../audit_trail/domain/audit_trail_controller.dart';
import 'workflow_transition_record.dart';

/// Helper to create [AuditEntry] instances from workflow events.
class WorkflowAuditHelper {
  static AuditEntry createEntryForTransition({
    required WorkflowTransitionRecord record,
    required AuditEntityType entityType,
    required String entityId,
    required String entityLabel,
  }) {
    final auditAction = _mapTriggerToAuditAction(record.triggerType);
    return AuditEntry(
      id: record.id,
      entityType: entityType,
      entityId: entityId,
      entityLabel: entityLabel,
      action: auditAction,
      performedAt: record.performedAt,
      performedBy: record.performedBy,
      note: record.note ??
          'Transitioned from ${record.fromStateName} to ${record.toStateName}',
      previousValue: record.fromStateName,
      newValue: record.toStateName,
    );
  }

  static AuditAction _mapTriggerToAuditAction(String triggerType) {
    switch (triggerType) {
      case 'submit':
        return AuditAction.submittedForApproval;
      case 'approve':
        return AuditAction.approved;
      case 'reject':
        return AuditAction.rejected;
      case 'cancel':
        return AuditAction.cancelled;
      case 'post':
        return AuditAction.posted;
      case 'lock':
        return AuditAction.locked;
      case 'reopen':
        return AuditAction.reopened;
      default:
        return AuditAction.edited;
    }
  }
}

/// Mixin/helper to call from controllers for audit trail integration.
extension WorkflowAuditRecording on Object {
  Future<void> recordWorkflowTransition(
    dynamic ref, {
    required WorkflowTransitionRecord record,
    required AuditEntityType entityType,
    required String entityId,
    required String entityLabel,
  }) async {
    final entry = WorkflowAuditHelper.createEntryForTransition(
      record: record,
      entityType: entityType,
      entityId: entityId,
      entityLabel: entityLabel,
    );
    await _addAuditEntry(ref, entry);
  }

  Future<void> _addAuditEntry(dynamic ref, AuditEntry entry) async {
    final controller = ref.read(auditTrailControllerProvider.notifier);
    await controller.addEntry(entry);
  }
}
