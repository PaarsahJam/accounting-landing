import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_action.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_approval.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_audit_helper.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_condition.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_definition.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_engine.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_instance.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_registry.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_state.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_transition.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_transition_record.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_trigger.dart';
import 'package:accounting_app/features/workflow_engine/registration/document_workflow.dart';
import 'package:accounting_app/features/workflow_engine/registration/invoice_workflow.dart';
import 'package:accounting_app/features/workflow_engine/registration/payment_workflow.dart';
import 'package:accounting_app/features/workflow_engine/registration/vendor_bill_workflow.dart';

void main() {
  group('WorkflowState', () {
    test('isInitial returns true only for initial state', () {
      final initial = WorkflowState(
        id: 'draft', name: 'Draft', label: 'Draft',
        category: WorkflowStateCategory.initial,
      );
      final terminal = WorkflowState(
        id: 'locked', name: 'Locked', label: 'Locked',
        category: WorkflowStateCategory.terminal,
      );
      expect(initial.isInitial, true);
      expect(initial.isTerminal, false);
      expect(terminal.isInitial, false);
      expect(terminal.isTerminal, true);
    });

    test('equality is based on id', () {
      final a = WorkflowState(
        id: 'draft', name: 'Draft', label: 'Draft',
        category: WorkflowStateCategory.initial,
      );
      final b = WorkflowState(
        id: 'draft', name: 'Draft', label: 'Draft',
        category: WorkflowStateCategory.initial,
      );
      expect(a, equals(b));
    });
  });

  group('WorkflowTrigger', () {
    test('label returns correct value for each type', () {
      expect(WorkflowTrigger(type: WorkflowTriggerType.submit).label, 'Submit');
      expect(WorkflowTrigger(type: WorkflowTriggerType.approve).label, 'Approve');
      expect(WorkflowTrigger(type: WorkflowTriggerType.reject).label, 'Reject');
      expect(WorkflowTrigger(type: WorkflowTriggerType.cancel).label, 'Cancel');
      expect(WorkflowTrigger(type: WorkflowTriggerType.post).label, 'Post');
      expect(
        WorkflowTrigger(type: WorkflowTriggerType.custom, customLabel: 'Review').label,
        'Review',
      );
    });
  });

  group('WorkflowCondition', () {
    test('MinValueCondition passes when value meets minimum', () {
      final condition = MinValueCondition(field: 'amount', minValue: 100);
      final result = condition.evaluate({'amount': 150});
      expect(result.isSuccess, true);
      expect(result.data, true);
    });

    test('MinValueCondition fails when value is below minimum', () {
      final condition = MinValueCondition(field: 'amount', minValue: 100);
      final result = condition.evaluate({'amount': 50});
      expect(result.isSuccess, true);
      expect(result.data, false);
    });

    test('FieldNotEmptyCondition fails on empty string', () {
      final condition = FieldNotEmptyCondition(field: 'name');
      expect(condition.evaluate({'name': ''}).data, false);
      expect(condition.evaluate({'name': 'hello'}).data, true);
      expect(condition.evaluate({}).data, false);
    });

    test('CompositeCondition with requireAll requires all to pass', () {
      final condition = CompositeCondition(
        conditions: [
          MinValueCondition(field: 'amount', minValue: 100),
          FieldNotEmptyCondition(field: 'name'),
        ],
        requireAll: true,
      );
      expect(condition.evaluate({'amount': 200, 'name': 'test'}).data, true);
      expect(condition.evaluate({'amount': 50, 'name': 'test'}).data, false);
    });

    test('CompositeCondition with requireAny passes when any passes', () {
      final condition = CompositeCondition(
        conditions: [
          MinValueCondition(field: 'amount', minValue: 100),
          FieldNotEmptyCondition(field: 'name'),
        ],
        requireAll: false,
      );
      expect(condition.evaluate({'amount': 50, 'name': ''}).data, false);
      expect(condition.evaluate({'amount': 200, 'name': ''}).data, true);
    });
  });

  group('WorkflowAction', () {
    test('AuditLogAction execute returns success', () async {
      final action = AuditLogAction(messageTemplate: 'Test log');
      final result = await action.execute({});
      expect(result.isSuccess, true);
    });

    test('CompositeAction executes all actions', () async {
      final action = CompositeAction(
        actions: [
          AuditLogAction(messageTemplate: 'Step 1'),
          AuditLogAction(messageTemplate: 'Step 2'),
        ],
      );
      final result = await action.execute({});
      expect(result.isSuccess, true);
    });
  });

  group('WorkflowApproval', () {
    test('isFulfilled when approvals meet requirement', () {
      final approval = WorkflowApproval(
        requiredApprovalsCount: 2,
        currentApprovals: [
          WorkflowApprovalEntry(
            approverId: 'u1', approverName: 'Alice',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
          WorkflowApprovalEntry(
            approverId: 'u2', approverName: 'Bob',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
        ],
      );
      expect(approval.isFulfilled, true);
      expect(approval.hasRejections, false);
    });

    test('hasRejections detects rejections', () {
      final approval = WorkflowApproval(
        requiredApprovalsCount: 1,
        currentApprovals: [
          WorkflowApprovalEntry(
            approverId: 'u1', approverName: 'Alice',
            decision: ApprovalDecision.rejected,
            decidedAt: DateTime.now(),
          ),
        ],
      );
      expect(approval.hasRejections, true);
      expect(approval.isFulfilled, false);
    });
  });

  group('WorkflowDefinition', () {
    late WorkflowDefinition definition;
    late WorkflowState draft, approved, cancelled;

    setUp(() {
      draft = WorkflowState(
        id: 'draft', name: 'Draft', label: 'Draft',
        category: WorkflowStateCategory.initial,
      );
      approved = WorkflowState(
        id: 'approved', name: 'Approved', label: 'Approved',
        category: WorkflowStateCategory.intermediate,
      );
      cancelled = WorkflowState(
        id: 'cancelled', name: 'Cancelled', label: 'Cancelled',
        category: WorkflowStateCategory.cancelled,
      );
      definition = WorkflowDefinition(
        id: 'test_wf',
        name: 'Test Workflow',
        description: 'A test workflow',
        entityType: AuditEntityType.salesInvoice,
        initialState: draft,
        states: [draft, approved, cancelled],
        transitions: [
          WorkflowTransition(
            id: 'draft_to_approved',
            name: 'Submit',
            fromState: draft,
            toState: approved,
            trigger: WorkflowTrigger(type: WorkflowTriggerType.submit),
          ),
          WorkflowTransition(
            id: 'draft_to_cancelled',
            name: 'Cancel',
            fromState: draft,
            toState: cancelled,
            trigger: WorkflowTrigger(type: WorkflowTriggerType.cancel),
          ),
        ],
      );
    });

    test('getState returns correct state', () {
      expect(definition.getState('draft'), equals(draft));
      expect(definition.getState('nonexistent'), isNull);
    });

    test('getTransitionsFrom returns transitions from given state', () {
      final fromDraft = definition.getTransitionsFrom('draft');
      expect(fromDraft.length, 2);
      expect(fromDraft.every((t) => t.fromState.id == 'draft'), true);
    });

    test('isValidTransition checks transition validity', () {
      expect(definition.isValidTransition('draft', 'approved'), true);
      expect(definition.isValidTransition('draft', 'cancelled'), true);
      expect(definition.isValidTransition('approved', 'draft'), false);
    });

    test('getStates returns all registered states', () {
      expect(definition.states.length, 3);
    });
  });

  group('WorkflowRegistry', () {
    test('singleton pattern returns same instance', () {
      expect(WorkflowRegistry(), same(WorkflowRegistry()));
    });

    test('register and retrieve definition', () {
      final registry = WorkflowRegistry();
      registry.clear();

      final definition = WorkflowDefinition(
        id: 'test',
        name: 'Test',
        description: '',
        entityType: AuditEntityType.salesInvoice,
        initialState: WorkflowState(
          id: 'start', name: 'Start', label: 'Start',
          category: WorkflowStateCategory.initial,
        ),
        states: [
          WorkflowState(
            id: 'start', name: 'Start', label: 'Start',
            category: WorkflowStateCategory.initial,
          ),
        ],
        transitions: [],
      );
      registry.register(definition);
      expect(registry.get('test'), equals(definition));
      expect(registry.isRegistered('test'), true);
      expect(registry.isRegistered('unknown'), false);
    });

    test('registerAll registers multiple definitions', () {
      final registry = WorkflowRegistry();
      registry.clear();

      registry.registerAll([
        WorkflowDefinition(
          id: 'wf1', name: 'WF1', description: '',
          entityType: AuditEntityType.salesInvoice,
          initialState: WorkflowState(
            id: 's', name: 'S', label: 'S',
            category: WorkflowStateCategory.initial,
          ),
          states: [
            WorkflowState(
              id: 's', name: 'S', label: 'S',
              category: WorkflowStateCategory.initial,
            ),
          ],
          transitions: [],
        ),
        WorkflowDefinition(
          id: 'wf2', name: 'WF2', description: '',
          entityType: AuditEntityType.vendorBill,
          initialState: WorkflowState(
            id: 's', name: 'S', label: 'S',
            category: WorkflowStateCategory.initial,
          ),
          states: [
            WorkflowState(
              id: 's', name: 'S', label: 'S',
              category: WorkflowStateCategory.initial,
            ),
          ],
          transitions: [],
        ),
      ]);
      expect(registry.getAll().length, 2);
    });
  });

  group('WorkflowEngine', () {
    late WorkflowRegistry registry;
    late WorkflowEngine engine;
    late WorkflowInstance instance;
    late WorkflowState draft, pendingApproval, approved, cancelled;

    setUp(() {
      registry = WorkflowRegistry();
      registry.clear();

      draft = WorkflowState(
        id: 'draft', name: 'Draft', label: 'Draft',
        category: WorkflowStateCategory.initial,
      );
      pendingApproval = WorkflowState(
        id: 'pending_approval', name: 'Pending Approval', label: 'Pending Approval',
        category: WorkflowStateCategory.intermediate,
      );
      approved = WorkflowState(
        id: 'approved', name: 'Approved', label: 'Approved',
        category: WorkflowStateCategory.intermediate,
      );
      cancelled = WorkflowState(
        id: 'cancelled', name: 'Cancelled', label: 'Cancelled',
        category: WorkflowStateCategory.cancelled,
      );

      registry.register(WorkflowDefinition(
        id: 'test_wf',
        name: 'Test',
        description: '',
        entityType: AuditEntityType.salesInvoice,
        initialState: draft,
        states: [draft, pendingApproval, approved, cancelled],
        transitions: [
          WorkflowTransition(
            id: 'submit',
            name: 'Submit',
            fromState: draft,
            toState: pendingApproval,
            trigger: WorkflowTrigger(type: WorkflowTriggerType.submit),
            conditions: [
              MinValueCondition(field: 'totalAmount', minValue: 0),
            ],
            approval: WorkflowApproval(
              requiredApprovalsCount: 1,
              approverRoles: ['manager'],
            ),
          ),
          WorkflowTransition(
            id: 'approve',
            name: 'Approve',
            fromState: pendingApproval,
            toState: approved,
            trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
          ),
          WorkflowTransition(
            id: 'cancel',
            name: 'Cancel',
            fromState: draft,
            toState: cancelled,
            trigger: WorkflowTrigger(type: WorkflowTriggerType.cancel),
          ),
        ],
      ));

      engine = WorkflowEngine(registry: registry);

      instance = WorkflowInstance(
        id: 'inst-1',
        definitionId: 'test_wf',
        entityType: AuditEntityType.salesInvoice,
        entityId: 'inv-001',
        currentStateId: 'draft',
        context: {'totalAmount': 50000},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    test('getAvailableTransitions returns transitions from current state', () {
      final available = engine.getAvailableTransitions(instance);
      expect(available.length, 1);
      expect(available.first.id, 'submit');
    });

    test('transition succeeds when conditions pass', () async {
      final result = await engine.transition(
        instance: instance,
        transitionId: 'submit',
        performedBy: 'user1',
        note: 'Submitting for approval',
      );
      expect(result.isSuccess, true);
      final transitionResult = result.data!;
      expect(transitionResult.succeeded, true);
      expect(transitionResult.instance.currentStateId, 'pending_approval');
      expect(transitionResult.record.conditionsPassed, true);
      expect(transitionResult.record.fromStateName, 'Draft');
      expect(transitionResult.record.toStateName, 'Pending Approval');
      expect(transitionResult.record.performedBy, 'user1');
    });

    test('transition returns failure when conditions fail', () async {
      instance = instance.copyWith(context: {'totalAmount': -1});
      final result = await engine.transition(
        instance: instance,
        transitionId: 'submit',
        performedBy: 'user1',
      );
      expect(result.isSuccess, true);
      final transitionResult = result.data!;
      expect(transitionResult.succeeded, false);
      expect(transitionResult.conditionsFailed, isNotEmpty);
      expect(transitionResult.instance.currentStateId, 'draft');
    });

    test('transition returns failure when transition not found', () async {
      final result = await engine.transition(
        instance: instance,
        transitionId: 'nonexistent',
        performedBy: 'user1',
      );
      expect(result.isSuccess, false);
    });

    test('transition returns failure when wrong source state', () async {
      final result = await engine.transition(
        instance: instance.copyWith(currentStateId: 'approved'),
        transitionId: 'submit',
        performedBy: 'user1',
      );
      expect(result.isSuccess, false);
    });

    test('canTransition checks approval requirement', () {
      final submitTransition = registry.get('test_wf')!.getTransition('submit')!;
      expect(
        engine.canTransition(instance, submitTransition, checkApproval: false),
        true,
      );
      expect(
        engine.canTransition(instance, submitTransition, checkApproval: true),
        false,
      );
    });

    test('createInstance creates instance in initial state', () async {
      final newInstance = await engine.createInstance(
        definitionId: 'test_wf',
        entityId: 'inv-002',
        entityType: AuditEntityType.salesInvoice,
      );
      expect(newInstance.currentStateId, 'draft');
      expect(newInstance.definitionId, 'test_wf');
      expect(newInstance.entityId, 'inv-002');
    });

    test('addApproval adds entry and fulfills requirement', () async {
      final result = await engine.addApproval(
        instance: instance,
        approverId: 'u1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        note: 'Looks good',
      );
      expect(result.isSuccess, true);
      final updated = result.data!;
      expect(updated.approval.currentApprovals.length, 1);
      expect(updated.approval.isFulfilled, true);
      expect(updated.approval.currentApprovals.first.approverName, 'Alice');
    });
  });

  group('WorkflowAuditHelper', () {
    test('maps submit trigger to submittedForApproval action', () {
      final record = WorkflowTransitionRecord(
        id: 'rec-1',
        transitionId: 't1',
        transitionName: 'Submit',
        fromStateId: 'draft',
        fromStateName: 'Draft',
        toStateId: 'pending',
        toStateName: 'Pending Approval',
        triggerType: 'submit',
        performedBy: 'user1',
        performedAt: DateTime.now(),
      );
      final entry = WorkflowAuditHelper.createEntryForTransition(
        record: record,
        entityType: AuditEntityType.salesInvoice,
        entityId: 'inv-001',
        entityLabel: 'INV-2026-0001',
      );
      expect(entry.action, AuditAction.submittedForApproval);
      expect(entry.entityType, AuditEntityType.salesInvoice);
      expect(entry.entityId, 'inv-001');
      expect(entry.previousValue, 'Draft');
      expect(entry.newValue, 'Pending Approval');
    });

    test('maps approve trigger to approved action', () {
      final record = WorkflowTransitionRecord(
        id: 'rec-2',
        transitionId: 't2',
        transitionName: 'Approve',
        fromStateId: 'pending',
        fromStateName: 'Pending Approval',
        toStateId: 'approved',
        toStateName: 'Approved',
        triggerType: 'approve',
        performedBy: 'user1',
        performedAt: DateTime.now(),
      );
      final entry = WorkflowAuditHelper.createEntryForTransition(
        record: record,
        entityType: AuditEntityType.vendorBill,
        entityId: 'vb-001',
        entityLabel: 'VB-2026-0001',
      );
      expect(entry.action, AuditAction.approved);
    });

    test('maps reject trigger to rejected action', () {
      final record = WorkflowTransitionRecord(
        id: 'rec-3',
        transitionId: 't3',
        transitionName: 'Reject',
        fromStateId: 'pending',
        fromStateName: 'Pending Approval',
        toStateId: 'draft',
        toStateName: 'Draft',
        triggerType: 'reject',
        performedBy: 'user1',
        performedAt: DateTime.now(),
      );
      final entry = WorkflowAuditHelper.createEntryForTransition(
        record: record,
        entityType: AuditEntityType.vendorPayment,
        entityId: 'pmt-001',
        entityLabel: 'PMT-2026-0001',
      );
      expect(entry.action, AuditAction.rejected);
    });
  });

  group('Concrete workflow registrations', () {
    test('invoice workflow has correct states and transitions', () {
      final registry = WorkflowRegistry();
      registry.clear();

      final invoiceWf = createInvoiceWorkflow();
      expect(invoiceWf.states.length, 6);
      expect(invoiceWf.transitions.length, 8);
      expect(invoiceWf.entityType, AuditEntityType.salesInvoice);
      expect(invoiceWf.initialState.id, 'draft');
    });

    test('vendor bill workflow has correct states', () {
      final vbWf = createVendorBillWorkflow();
      expect(vbWf.states.length, 6);
      expect(vbWf.transitions.length, 8);
      expect(vbWf.entityType, AuditEntityType.vendorBill);
      expect(vbWf.initialState.id, 'draft');
    });

    test('payment workflow includes retry transition from failed', () {
      final pmtWf = createPaymentWorkflow();
      expect(pmtWf.states.length, 7);
      expect(pmtWf.transitions.length, 9);

      final fromFailed = pmtWf.getTransitionsFrom('failed');
      expect(fromFailed, isNotEmpty);
      expect(fromFailed.any((t) => t.toState.id == 'initiated'), true);
    });

    test('document workflow has correct lifecycle', () {
      final docWf = createDocumentWorkflow();
      expect(docWf.states.length, 6);
      expect(docWf.transitions.length, 6);

      final fromUploaded = docWf.getTransitionsFrom('uploaded');
      expect(fromUploaded.any((t) => t.toState.id == 'processing'), true);
    });
  });
}
