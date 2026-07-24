enum NotificationChannel {
  inApp,
  local,
  push,
  email;

  String get label {
    switch (this) {
      case NotificationChannel.inApp:
        return 'In-App';
      case NotificationChannel.local:
        return 'Local';
      case NotificationChannel.push:
        return 'Push';
      case NotificationChannel.email:
        return 'Email';
    }
  }
}
