import '../../audit_trail/domain/audit_entity_type.dart';
import '../domain/workflow_action.dart';
import '../domain/workflow_approval.dart';
import '../domain/workflow_condition.dart';
import '../domain/workflow_definition.dart';
import '../domain/workflow_state.dart';
import '../domain/workflow_transition.dart';
import '../domain/workflow_trigger.dart';

WorkflowDefinition createPaymentWorkflow() {
  final initiated = WorkflowState(
    id: 'initiated', name: 'Initiated', label: 'Initiated',
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
  final processed = WorkflowState(
    id: 'processed', name: 'Processed', label: 'Processed',
    category: WorkflowStateCategory.intermediate,
  );
  final completed = WorkflowState(
    id: 'completed', name: 'Completed', label: 'Completed',
    category: WorkflowStateCategory.terminal,
  );
  final failed = WorkflowState(
    id: 'failed', name: 'Failed', label: 'Failed',
    category: WorkflowStateCategory.terminal,
  );
  final cancelled = WorkflowState(
    id: 'cancelled', name: 'Cancelled', label: 'Cancelled',
    category: WorkflowStateCategory.cancelled,
  );

  final states = [
    initiated, pendingApproval, approved, processed,
    completed, failed, cancelled,
  ];

  final transitions = [
    WorkflowTransition(
      id: 'initiated_to_pending_approval',
      name: 'Submit',
      fromState: initiated,
      toState: pendingApproval,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.submit),
      conditions: [
        MinValueCondition(field: 'amount', minValue: 1),
        FieldNotEmptyCondition(field: 'payeeId'),
      ],
      approval: WorkflowApproval(
        requiredApprovalsCount: 2,
        approverRoles: ['manager', 'treasury'],
      ),
    ),
    WorkflowTransition(
      id: 'pending_approval_to_approved',
      name: 'Approve',
      fromState: pendingApproval,
      toState: approved,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
    ),
    WorkflowTransition(
      id: 'pending_approval_to_initiated',
      name: 'Reject',
      fromState: pendingApproval,
      toState: initiated,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reject),
    ),
    WorkflowTransition(
      id: 'approved_to_processed',
      name: 'Process',
      fromState: approved,
      toState: processed,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Process'),
      actions: [AuditLogAction(messageTemplate: 'Payment processed by bank')],
    ),
    WorkflowTransition(
      id: 'processed_to_completed',
      name: 'Complete',
      fromState: processed,
      toState: completed,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Confirm'),
      conditions: [
        FieldNotEmptyCondition(field: 'transactionReference'),
      ],
    ),
    WorkflowTransition(
      id: 'processed_to_failed',
      name: 'Fail',
      fromState: processed,
      toState: failed,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Fail'),
    ),
    WorkflowTransition(
      id: 'initiated_to_cancelled',
      name: 'Cancel',
      fromState: initiated,
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
      id: 'failed_to_initiated',
      name: 'Retry',
      fromState: failed,
      toState: initiated,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reopen),
    ),
  ];

  return WorkflowDefinition(
    id: 'payment_workflow',
    name: 'Payment Processing',
    description: 'Payment approval, processing, and confirmation workflow',
    entityType: AuditEntityType.vendorPayment,
    initialState: initiated,
    states: states,
    transitions: transitions,
  );
}
