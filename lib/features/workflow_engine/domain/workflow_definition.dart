import '../../audit_trail/domain/audit_entity_type.dart';
import 'workflow_state.dart';
import 'workflow_transition.dart';
import 'workflow_trigger.dart';

class WorkflowDefinition {
  final String id;
  final String name;
  final String description;
  final AuditEntityType entityType;
  final WorkflowState initialState;
  final List<WorkflowState> states;
  final List<WorkflowTransition> transitions;

  const WorkflowDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.entityType,
    required this.initialState,
    required this.states,
    required this.transitions,
  });

  WorkflowState? getState(String stateId) {
    try {
      return states.firstWhere((s) => s.id == stateId);
    } catch (_) {
      return null;
    }
  }

  List<WorkflowTransition> getTransitionsFrom(String stateId) {
    return transitions.where((t) => t.fromState.id == stateId).toList();
  }

  WorkflowTransition? getTransition(String transitionId) {
    try {
      return transitions.firstWhere((t) => t.id == transitionId);
    } catch (_) {
      return null;
    }
  }

  List<WorkflowTransition> getTransitionsByTrigger(WorkflowTriggerType triggerType) {
    return transitions.where((t) => t.trigger.type == triggerType).toList();
  }

  bool isValidState(String stateId) => states.any((s) => s.id == stateId);

  bool isValidTransition(String fromStateId, String toStateId) =>
      transitions.any((t) => t.fromState.id == fromStateId && t.toState.id == toStateId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowDefinition &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorkflowDefinition(id: $id, name: $name)';
}
