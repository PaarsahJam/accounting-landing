enum NotificationSeverity {
  info,
  warning,
  error,
  success;

  String get label {
    switch (this) {
      case NotificationSeverity.info:
        return 'Info';
      case NotificationSeverity.warning:
        return 'Warning';
      case NotificationSeverity.error:
        return 'Error';
      case NotificationSeverity.success:
        return 'Success';
    }
  }
}
