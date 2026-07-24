enum EventStatus {
  /// Event is upcoming and actionable.
  pending,

  /// Event has been resolved or actioned.
  completed,

  /// Event has been cancelled.
  cancelled;

  String get label {
    switch (this) {
      case EventStatus.pending:
        return 'Pending';
      case EventStatus.completed:
        return 'Completed';
      case EventStatus.cancelled:
        return 'Cancelled';
    }
  }
}
