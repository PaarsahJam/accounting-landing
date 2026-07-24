import '../../audit_trail/domain/audit_entity_type.dart';
import '../domain/workflow_action.dart';
import '../domain/workflow_approval.dart';
import '../domain/workflow_condition.dart';
import '../domain/workflow_definition.dart';
import '../domain/workflow_state.dart';
import '../domain/workflow_transition.dart';
import '../domain/workflow_trigger.dart';

WorkflowDefinition createInvoiceWorkflow() {
  final draft = WorkflowState(
    id: 'draft', name: 'Draft', label: 'Draft',
    category: WorkflowStateCategory.initial,
  );
  final pendingApproval = WorkflowState(
    id: 'pending_approval', name: 'Pending Approval', label: 'Pending Approval',
    category: WorkflowStateCategory.intermediate,
  );
  final approved = WorkflowState(
    id: 'approved', name: 'Approved', label: 'Approved',
    category: WorkflowStateCategory.intermediate,
  );
  final posted = WorkflowState(
    id: 'posted', name: 'Posted', label: 'Posted',
    category: WorkflowStateCategory.intermediate,
  );
  final locked = WorkflowState(
    id: 'locked', name: 'Locked', label: 'Locked',
    category: WorkflowStateCategory.terminal,
  );
  final cancelled = WorkflowState(
    id: 'cancelled', name: 'Cancelled', label: 'Cancelled',
    category: WorkflowStateCategory.cancelled,
  );

  final states = [draft, pendingApproval, approved, posted, locked, cancelled];

  final transitions = [
    WorkflowTransition(
      id: 'draft_to_pending_approval',
      name: 'Submit for Approval',
      fromState: draft,
      toState: pendingApproval,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.submit),
      conditions: [
        MinValueCondition(field: 'totalAmount', minValue: 0),
        FieldNotEmptyCondition(field: 'customerId'),
      ],
      actions: [AuditLogAction(messageTemplate: 'Invoice submitted for approval')],
      approval: WorkflowApproval(
        requiredApprovalsCount: 1,
        approverRoles: ['approver', 'manager'],
      ),
    ),
    WorkflowTransition(
      id: 'pending_approval_to_approved',
      name: 'Approve',
      fromState: pendingApproval,
      toState: approved,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
      actions: [AuditLogAction(messageTemplate: 'Invoice approved')],
    ),
    WorkflowTransition(
      id: 'pending_approval_to_draft',
      name: 'Reject',
      fromState: pendingApproval,
      toState: draft,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reject),
      actions: [AuditLogAction(messageTemplate: 'Invoice rejected, returned to draft')],
    ),
    WorkflowTransition(
      id: 'approved_to_posted',
      name: 'Post',
      fromState: approved,
      toState: posted,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.post),
      actions: [AuditLogAction(messageTemplate: 'Invoice posted to ledger')],
    ),
    WorkflowTransition(
      id: 'posted_to_locked',
      name: 'Lock',
      fromState: posted,
      toState: locked,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.lock),
      actions: [AuditLogAction(messageTemplate: 'Invoice locked, no further changes')],
    ),
    WorkflowTransition(
      id: 'draft_to_cancelled',
      name: 'Cancel',
      fromState: draft,
      toState: cancelled,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.cancel),
    ),
    WorkflowTransition(
      id: 'pending_approval_to_cancelled',
      name: 'Cancel',
      fromState: pendingApproval,
      toState: cancelled,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.cancel),
    ),
    WorkflowTransition(
      id: 'approved_to_cancelled',
      name: 'Cancel',
      fromState: approved,
      toState: cancelled,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.cancel),
    ),
  ];

  return WorkflowDefinition(
    id: 'invoice_workflow',
    name: 'Invoice Approval',
    description: 'Standard approval workflow for sales invoices',
    entityType: AuditEntityType.salesInvoice,
    initialState: draft,
    states: states,
    transitions: transitions,
  );
}
