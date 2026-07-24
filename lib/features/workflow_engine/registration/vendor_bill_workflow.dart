import '../../audit_trail/domain/audit_entity_type.dart';
import '../domain/workflow_action.dart';
import '../domain/workflow_approval.dart';
import '../domain/workflow_condition.dart';
import '../domain/workflow_definition.dart';
import '../domain/workflow_state.dart';
import '../domain/workflow_transition.dart';
import '../domain/workflow_trigger.dart';

WorkflowDefinition createVendorBillWorkflow() {
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
  final scheduled = WorkflowState(
    id: 'scheduled', name: 'Scheduled for Payment', label: 'Scheduled for Payment',
    category: WorkflowStateCategory.intermediate,
  );
  final paid = WorkflowState(
    id: 'paid', name: 'Paid', label: 'Paid',
    category: WorkflowStateCategory.terminal,
  );
  final cancelled = WorkflowState(
    id: 'cancelled', name: 'Cancelled', label: 'Cancelled',
    category: WorkflowStateCategory.cancelled,
  );

  final states = [draft, pendingApproval, approved, scheduled, paid, cancelled];

  final transitions = [
    WorkflowTransition(
      id: 'draft_to_pending_approval',
      name: 'Submit for Approval',
      fromState: draft,
      toState: pendingApproval,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.submit),
      conditions: [
        MinValueCondition(field: 'totalAmount', minValue: 0),
        FieldNotEmptyCondition(field: 'vendorId'),
      ],
      approval: WorkflowApproval(
        requiredApprovalsCount: 2,
        approverRoles: ['manager', 'finance_manager'],
      ),
    ),
    WorkflowTransition(
      id: 'pending_approval_to_approved',
      name: 'Approve',
      fromState: pendingApproval,
      toState: approved,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
      conditions: [
        MaxValueCondition(field: 'totalAmount', maxValue: 100000000),
      ],
    ),
    WorkflowTransition(
      id: 'pending_approval_to_draft',
      name: 'Reject',
      fromState: pendingApproval,
      toState: draft,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reject),
    ),
    WorkflowTransition(
      id: 'approved_to_scheduled',
      name: 'Schedule Payment',
      fromState: approved,
      toState: scheduled,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Schedule'),
      conditions: [
        FieldNotEmptyCondition(field: 'paymentDate'),
      ],
    ),
    WorkflowTransition(
      id: 'scheduled_to_paid',
      name: 'Mark Paid',
      fromState: scheduled,
      toState: paid,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Pay'),
      actions: [AuditLogAction(messageTemplate: 'Vendor bill paid')],
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
    id: 'vendor_bill_workflow',
    name: 'Vendor Bill Approval',
    description: 'Approval and payment scheduling workflow for vendor bills',
    entityType: AuditEntityType.vendorBill,
    initialState: draft,
    states: states,
    transitions: transitions,
  );
}
