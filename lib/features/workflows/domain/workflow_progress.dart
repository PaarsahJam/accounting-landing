/// Immutable snapshot of the workflow copilot's task progress.
class WorkflowProgress {
  const WorkflowProgress({
    this.activeTaskId,
    this.completedStepIds = const {},
    this.finishedTaskIds = const {},
  });

  /// The task currently being worked on, or null when idle.
  final String? activeTaskId;

  /// Step ids completed within the active task.
  final Set<String> completedStepIds;

  /// Task ids that have been fully completed.
  final Set<String> finishedTaskIds;

  bool get isActive => activeTaskId != null;

  bool isFinished(String taskId) => finishedTaskIds.contains(taskId);

  static const empty = WorkflowProgress();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkflowProgress &&
        other.activeTaskId == activeTaskId &&
        other.completedStepIds.length == completedStepIds.length &&
        completedStepIds.containsAll(other.completedStepIds) &&
        other.finishedTaskIds.length == finishedTaskIds.length &&
        finishedTaskIds.containsAll(other.finishedTaskIds);
  }

  @override
  int get hashCode => Object.hash(
        activeTaskId,
        Object.hashAll(completedStepIds.toList()..sort()),
        Object.hashAll(finishedTaskIds.toList()..sort()),
      );
}
