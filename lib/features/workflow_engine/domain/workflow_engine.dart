import 'dart:async';

import '../../audit_trail/domain/audit_entity_type.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import 'workflow_approval.dart';
import 'workflow_definition.dart';
import 'workflow_instance.dart';
import 'workflow_registry.dart';
import 'workflow_transition.dart';
import 'workflow_transition_record.dart';

class TransitionResult {
  final WorkflowInstance instance;
  final WorkflowTransitionRecord record;
  final List<String> conditionsFailed;
  final List<String> actionsFailed;

  const TransitionResult({
    required this.instance,
    required this.record,
    this.conditionsFailed = const [],
    this.actionsFailed = const [],
  });

  bool get succeeded => conditionsFailed.isEmpty && actionsFailed.isEmpty;
}

class WorkflowEngine {
  final WorkflowRegistry registry;

  const WorkflowEngine({required this.registry});

  WorkflowDefinition? getDefinition(String id) => registry.get(id);

  List<WorkflowTransition> getAvailableTransitions(WorkflowInstance instance) {
    final definition = registry.get(instance.definitionId);
    if (definition == null) return [];
    return definition.getTransitionsFrom(instance.currentStateId);
  }

  bool canTransition(
    WorkflowInstance instance,
    WorkflowTransition transition, {
    Map<String, dynamic>? contextOverride,
    bool checkApproval = true,
    bool checkConditions = true,
    bool checkActions = false,
  }) {
    final definition = registry.get(instance.definitionId);
    if (definition == null) return false;

    if (transition.fromState.id != instance.currentStateId) return false;
    if (transition.requiresApproval && checkApproval) {
      final approval = instance.approval;
      if (approval.hasRejections) return false;
      if (!approval.isFulfilled) return false;
    }
    if (checkConditions && transition.conditions.isNotEmpty) {
      final mergedContext = {...instance.context, ...?contextOverride};
      for (final condition in transition.conditions) {
        final result = condition.evaluate(mergedContext);
        if (!result.isSuccess || result.data != true) return false;
      }
    }
    return true;
  }

  Future<AppResult<TransitionResult>> transition({
    required WorkflowInstance instance,
    required String transitionId,
    required String performedBy,
    String? note,
    Map<String, dynamic>? contextOverride,
  }) async {
    final definition = registry.get(instance.definitionId);
    if (definition == null) {
      return AppResult.failure(
        ValidationFailure(message: 'Workflow definition ${instance.definitionId} not found'),
      );
    }

    final transition = definition.getTransition(transitionId);
    if (transition == null) {
      return AppResult.failure(
        ValidationFailure(message: 'Transition $transitionId not found'),
      );
    }

    if (transition.fromState.id != instance.currentStateId) {
      return AppResult.failure(
        ValidationFailure(
          message:
              'Cannot transition from "${instance.currentStateId}" via "$transitionId"',
        ),
      );
    }

    final mergedContext = {...instance.context, ...?contextOverride};
    final conditionsFailed = <String>[];
    for (final condition in transition.conditions) {
      final result = condition.evaluate(mergedContext);
      if (!result.isSuccess) {
        return AppResult.failure(result.error!);
      }
      if (result.data != true) {
        conditionsFailed.add(condition.description);
      }
    }

    if (conditionsFailed.isNotEmpty) {
      return AppResult.success(
        TransitionResult(
          instance: instance,
          record: WorkflowTransitionRecord(
            id: _generateId(),
            transitionId: transition.id,
            transitionName: transition.name,
            fromStateId: transition.fromState.id,
            fromStateName: transition.fromState.name,
            toStateId: transition.toState.id,
            toStateName: transition.toState.name,
            triggerType: transition.trigger.type.name,
            performedBy: performedBy,
            performedAt: DateTime.now(),
            note: note,
            conditionsPassed: false,
            actionsSucceeded: true,
          ),
          conditionsFailed: conditionsFailed,
        ),
      );
    }

    final actionsFailed = <String>[];
    for (final action in transition.actions) {
      final result = await action.execute(mergedContext);
      if (!result.isSuccess) {
        actionsFailed.add(action.description);
      }
    }

    final historyEntry = WorkflowTransitionRecord(
      id: _generateId(),
      transitionId: transition.id,
      transitionName: transition.name,
      fromStateId: transition.fromState.id,
      fromStateName: transition.fromState.name,
      toStateId: transition.toState.id,
      toStateName: transition.toState.name,
      triggerType: transition.trigger.type.name,
      performedBy: performedBy,
      performedAt: DateTime.now(),
      note: note,
      conditionsPassed: conditionsFailed.isEmpty,
      actionsSucceeded: actionsFailed.isEmpty,
    );

    final updatedInstance = instance.copyWith(
      currentStateId: transition.toState.id,
      history: [...instance.history, historyEntry],
      updatedAt: DateTime.now(),
    );

    return AppResult.success(
      TransitionResult(
        instance: updatedInstance,
        record: historyEntry,
        conditionsFailed: conditionsFailed,
        actionsFailed: actionsFailed,
      ),
    );
  }

  Future<AppResult<WorkflowInstance>> addApproval({
    required WorkflowInstance instance,
    required String approverId,
    required String approverName,
    required ApprovalDecision decision,
    String? note,
  }) async {
    final entry = WorkflowApprovalEntry(
      approverId: approverId,
      approverName: approverName,
      decision: decision,
      note: note,
      decidedAt: DateTime.now(),
    );

    final updatedApproval = instance.approval.copyWith(
      currentApprovals: [...instance.approval.currentApprovals, entry],
    );

    return AppResult.success(
      instance.copyWith(
        approval: updatedApproval,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<WorkflowInstance> createInstance({
    required String definitionId,
    required String entityId,
    required AuditEntityType entityType,
    Map<String, dynamic> context = const {},
  }) async {
    final definition = registry.get(definitionId);
    if (definition == null) {
      throw ArgumentError('Workflow definition $definitionId not found');
    }
    return WorkflowInstance(
      id: _generateId(),
      definitionId: definitionId,
      entityType: entityType,
      entityId: entityId,
      currentStateId: definition.initialState.id,
      context: context,
      history: [],
      approval: const WorkflowApproval(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static int _counter = 0;

  String _generateId() {
    _counter++;
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'wf-$ts-$_counter';
  }
}
