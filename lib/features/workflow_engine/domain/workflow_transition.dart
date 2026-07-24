import 'workflow_action.dart';
import 'workflow_approval.dart';
import 'workflow_condition.dart';
import 'workflow_state.dart';
import 'workflow_trigger.dart';

class WorkflowTransition {
  final String id;
  final String name;
  final WorkflowState fromState;
  final WorkflowState toState;
  final WorkflowTrigger trigger;
  final List<WorkflowCondition> conditions;
  final List<WorkflowAction> actions;
  final WorkflowApproval? approval;

  const WorkflowTransition({
    required this.id,
    required this.name,
    required this.fromState,
    required this.toState,
    required this.trigger,
    this.conditions = const [],
    this.actions = const [],
    this.approval,
  });

  bool get requiresApproval => approval != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowTransition &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fromState == other.fromState &&
          toState == other.toState &&
          trigger == other.trigger;

  @override
  int get hashCode => Object.hash(id, fromState, toState, trigger);

  @override
  String toString() =>
      'WorkflowTransition(id: $id, $fromState -> $toState via ${trigger.label})';
}
