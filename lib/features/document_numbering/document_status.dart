// lib/features/document_numbering/document_status.dart

/// Lifecycle statuses for any approvable document.
enum DocumentStatus {
  draft,
  pendingApproval,
  approved,
  posted,
  locked,
  cancelled;

  /// Human-readable label used when no localization context is available.
  String get label {
    switch (this) {
      case DocumentStatus.draft:
        return 'Draft';
      case DocumentStatus.pendingApproval:
        return 'Pending Approval';
      case DocumentStatus.approved:
        return 'Approved';
      case DocumentStatus.posted:
        return 'Posted';
      case DocumentStatus.locked:
        return 'Locked';
      case DocumentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Defines which transitions are permitted in the document lifecycle.
extension StatusTransition on DocumentStatus {
  /// Returns `true` when transitioning from `this` to [toStatus] is allowed.
  bool canTransitionTo(DocumentStatus toStatus) {
    switch (this) {
      case DocumentStatus.draft:
        return toStatus == DocumentStatus.pendingApproval ||
            toStatus == DocumentStatus.cancelled;
      case DocumentStatus.pendingApproval:
        return toStatus == DocumentStatus.approved ||
            toStatus == DocumentStatus.cancelled;
      case DocumentStatus.approved:
        return toStatus == DocumentStatus.posted ||
            toStatus == DocumentStatus.cancelled;
      case DocumentStatus.posted:
        return toStatus == DocumentStatus.locked;
      case DocumentStatus.locked:
        return false;
      case DocumentStatus.cancelled:
        return false;
    }
  }

  /// Ordered list of all statuses for display in an approval timeline.
  static const List<DocumentStatus> timeline = [
    DocumentStatus.draft,
    DocumentStatus.pendingApproval,
    DocumentStatus.approved,
    DocumentStatus.posted,
    DocumentStatus.locked,
  ];
}
