class WorkflowApproval {
  final int requiredApprovalsCount;
  final List<String> approverRoles;
  final List<WorkflowApprovalEntry> currentApprovals;

  const WorkflowApproval({
    this.requiredApprovalsCount = 1,
    this.approverRoles = const [],
    this.currentApprovals = const [],
  });

  WorkflowApproval copyWith({
    int? requiredApprovalsCount,
    List<String>? approverRoles,
    List<WorkflowApprovalEntry>? currentApprovals,
  }) {
    return WorkflowApproval(
      requiredApprovalsCount:
          requiredApprovalsCount ?? this.requiredApprovalsCount,
      approverRoles: approverRoles ?? this.approverRoles,
      currentApprovals: currentApprovals ?? this.currentApprovals,
    );
  }

  bool get isFulfilled => currentApprovals.length >= requiredApprovalsCount;
  bool get hasRejections =>
      currentApprovals.any((a) => a.decision == ApprovalDecision.rejected);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowApproval &&
          runtimeType == other.runtimeType &&
          requiredApprovalsCount == other.requiredApprovalsCount &&
          _listEquals(approverRoles, other.approverRoles) &&
          _listEquals(currentApprovals, other.currentApprovals);

  @override
  int get hashCode =>
      Object.hash(requiredApprovalsCount, Object.hashAll(approverRoles), Object.hashAll(currentApprovals));

  static bool _listEquals(List<dynamic> a, List<dynamic> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() =>
      'WorkflowApproval(required: $requiredApprovalsCount, current: ${currentApprovals.length})';
}

enum ApprovalDecision { pending, approved, rejected }

class WorkflowApprovalEntry {
  final String approverId;
  final String approverName;
  final ApprovalDecision decision;
  final String? note;
  final DateTime decidedAt;

  const WorkflowApprovalEntry({
    required this.approverId,
    required this.approverName,
    this.decision = ApprovalDecision.pending,
    this.note,
    required this.decidedAt,
  });

  WorkflowApprovalEntry copyWith({
    String? approverId,
    String? approverName,
    ApprovalDecision? decision,
    String? note,
    DateTime? decidedAt,
  }) {
    return WorkflowApprovalEntry(
      approverId: approverId ?? this.approverId,
      approverName: approverName ?? this.approverName,
      decision: decision ?? this.decision,
      note: note ?? this.note,
      decidedAt: decidedAt ?? this.decidedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowApprovalEntry &&
          runtimeType == other.runtimeType &&
          approverId == other.approverId &&
          approverName == other.approverName &&
          decision == other.decision &&
          note == other.note &&
          decidedAt == other.decidedAt;

  @override
  int get hashCode =>
      Object.hash(approverId, approverName, decision, note, decidedAt);

  @override
  String toString() =>
      'WorkflowApprovalEntry(approver: $approverName, decision: $decision)';
}
