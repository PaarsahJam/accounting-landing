enum WorkflowTriggerType { submit, approve, reject, cancel, post, lock, reopen, custom }

class WorkflowTrigger {
  final WorkflowTriggerType type;
  final String? customLabel;

  const WorkflowTrigger({required this.type, this.customLabel});

  String get label {
    if (customLabel != null) return customLabel!;
    switch (type) {
      case WorkflowTriggerType.submit:
        return 'Submit';
      case WorkflowTriggerType.approve:
        return 'Approve';
      case WorkflowTriggerType.reject:
        return 'Reject';
      case WorkflowTriggerType.cancel:
        return 'Cancel';
      case WorkflowTriggerType.post:
        return 'Post';
      case WorkflowTriggerType.lock:
        return 'Lock';
      case WorkflowTriggerType.reopen:
        return 'Reopen';
      case WorkflowTriggerType.custom:
        return customLabel ?? 'Custom';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowTrigger &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          customLabel == other.customLabel;

  @override
  int get hashCode => Object.hash(type, customLabel);

  @override
  String toString() => 'WorkflowTrigger(type: $type)';
}
