enum WorkflowStateCategory { initial, intermediate, terminal, cancelled }

class WorkflowState {
  final String id;
  final String name;
  final String label;
  final WorkflowStateCategory category;

  const WorkflowState({
    required this.id,
    required this.name,
    required this.label,
    required this.category,
  });

  bool get isInitial => category == WorkflowStateCategory.initial;
  bool get isTerminal => category == WorkflowStateCategory.terminal;
  bool get isCancelled => category == WorkflowStateCategory.cancelled;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorkflowState(id: $id, name: $name)';
}
