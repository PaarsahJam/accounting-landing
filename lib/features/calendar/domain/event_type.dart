/// Categories of events that the calendar system understands.
enum EventType {
  /// A record is due (invoice, bill, payment).
  dueDate,

  /// User-set reminder.
  reminder,

  /// Action item or to-do.
  task,

  /// Scheduled follow-up on a lead, customer, or issue.
  followUp,

  /// Pending approval deadline.
  approval,

  /// Scheduled or received payment.
  payment,

  /// CRM meeting or call.
  meeting;

  String get label {
    switch (this) {
      case EventType.dueDate:
        return 'Due Date';
      case EventType.reminder:
        return 'Reminder';
      case EventType.task:
        return 'Task';
      case EventType.followUp:
        return 'Follow-up';
      case EventType.approval:
        return 'Approval';
      case EventType.payment:
        return 'Payment';
      case EventType.meeting:
        return 'Meeting';
    }
  }
}
