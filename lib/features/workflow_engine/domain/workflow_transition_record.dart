class WorkflowTransitionRecord {
  final String id;
  final String transitionId;
  final String transitionName;
  final String fromStateId;
  final String fromStateName;
  final String toStateId;
  final String toStateName;
  final String triggerType;
  final String performedBy;
  final DateTime performedAt;
  final String? note;
  final bool conditionsPassed;
  final bool actionsSucceeded;

  const WorkflowTransitionRecord({
    required this.id,
    required this.transitionId,
    required this.transitionName,
    required this.fromStateId,
    required this.fromStateName,
    required this.toStateId,
    required this.toStateName,
    required this.triggerType,
    required this.performedBy,
    required this.performedAt,
    this.note,
    this.conditionsPassed = true,
    this.actionsSucceeded = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowTransitionRecord &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'WorkflowTransitionRecord($fromStateName -> $toStateName by $performedBy)';
}
