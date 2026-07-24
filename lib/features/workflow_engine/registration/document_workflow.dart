import '../../audit_trail/domain/audit_entity_type.dart';
import '../domain/workflow_action.dart';
import '../domain/workflow_condition.dart';
import '../domain/workflow_definition.dart';
import '../domain/workflow_state.dart';
import '../domain/workflow_transition.dart';
import '../domain/workflow_trigger.dart';

WorkflowDefinition createDocumentWorkflow() {
  final uploaded = WorkflowState(
    id: 'uploaded', name: 'Uploaded', label: 'Uploaded',
    category: WorkflowStateCategory.initial,
  );
  final processing = WorkflowState(
    id: 'processing', name: 'Processing', label: 'Processing',
    category: WorkflowStateCategory.intermediate,
  );
  final classified = WorkflowState(
    id: 'classified', name: 'Classified', label: 'Classified',
    category: WorkflowStateCategory.intermediate,
  );
  final reviewed = WorkflowState(
    id: 'reviewed', name: 'Reviewed', label: 'Reviewed',
    category: WorkflowStateCategory.intermediate,
  );
  final archived = WorkflowState(
    id: 'archived', name: 'Archived', label: 'Archived',
    category: WorkflowStateCategory.terminal,
  );
  final rejected = WorkflowState(
    id: 'rejected', name: 'Rejected', label: 'Rejected',
    category: WorkflowStateCategory.cancelled,
  );

  final states = [uploaded, processing, classified, reviewed, archived, rejected];

  final transitions = [
    WorkflowTransition(
      id: 'uploaded_to_processing',
      name: 'Start Processing',
      fromState: uploaded,
      toState: processing,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Process'),
      conditions: [
        FieldNotEmptyCondition(field: 'filePath'),
      ],
      actions: [AuditLogAction(messageTemplate: 'Document processing started')],
    ),
    WorkflowTransition(
      id: 'processing_to_classified',
      name: 'Classify',
      fromState: processing,
      toState: classified,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Classify'),
      conditions: [
        FieldNotEmptyCondition(field: 'documentType'),
      ],
    ),
    WorkflowTransition(
      id: 'classified_to_reviewed',
      name: 'Review',
      fromState: classified,
      toState: reviewed,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
    ),
    WorkflowTransition(
      id: 'classified_to_rejected',
      name: 'Reject',
      fromState: classified,
      toState: rejected,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reject),
    ),
    WorkflowTransition(
      id: 'reviewed_to_archived',
      name: 'Archive',
      fromState: reviewed,
      toState: archived,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.post),
      actions: [AuditLogAction(messageTemplate: 'Document archived')],
    ),
    WorkflowTransition(
      id: 'uploaded_to_rejected',
      name: 'Reject',
      fromState: uploaded,
      toState: rejected,
      trigger: WorkflowTrigger(type: WorkflowTriggerType.reject),
    ),
  ];

  return WorkflowDefinition(
    id: 'document_workflow',
    name: 'Document Processing',
    description: 'Document upload, classification, review, and archival workflow',
    entityType: AuditEntityType.financialReport,
    initialState: uploaded,
    states: states,
    transitions: transitions,
  );
}
