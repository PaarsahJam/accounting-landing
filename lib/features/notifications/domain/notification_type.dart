enum NotificationType {
  approval,
  mention,
  dueDate,
  failedSync,
  documentStatus,
  payment,
  invoice,
  system,
  reminder,
  update;

  String get label {
    switch (this) {
      case NotificationType.approval:
        return 'Approval';
      case NotificationType.mention:
        return 'Mention';
      case NotificationType.dueDate:
        return 'Due Date';
      case NotificationType.failedSync:
        return 'Failed Sync';
      case NotificationType.documentStatus:
        return 'Document Status';
      case NotificationType.payment:
        return 'Payment';
      case NotificationType.invoice:
        return 'Invoice';
      case NotificationType.system:
        return 'System';
      case NotificationType.reminder:
        return 'Reminder';
      case NotificationType.update:
        return 'Update';
    }
  }
}
