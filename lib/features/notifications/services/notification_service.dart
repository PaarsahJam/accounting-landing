import '../domain/app_notification.dart';
import '../domain/notification_channel.dart';
import '../domain/notification_preference.dart';

/// Core orchestrator that dispatches notifications through all enabled channels.
class NotificationService {
  final LocalNotificationService? localService;
  final PushNotificationService? pushService;
  final EmailNotificationHook? emailHook;

  NotificationService({
    this.localService,
    this.pushService,
    this.emailHook,
  });

  Future<void> dispatch(
    AppNotification notification,
    NotificationPreferences preferences,
  ) async {
    for (final channel in notification.channels) {
      if (!preferences.isTypeEnabled(notification.type, channel)) continue;
      switch (channel) {
        case NotificationChannel.inApp:
          break;
        case NotificationChannel.local:
          await localService?.show(notification);
          break;
        case NotificationChannel.push:
          await pushService?.send(notification);
          break;
        case NotificationChannel.email:
          await emailHook?.send(notification);
          break;
      }
    }
  }

  Future<void> dispatchAll(
    List<AppNotification> notifications,
    NotificationPreferences preferences,
  ) async {
    for (final notification in notifications) {
      await dispatch(notification, preferences);
    }
  }
}

/// Abstract local notification service (platform-specific).
abstract class LocalNotificationService {
  Future<bool> requestPermission();
  Future<void> show(AppNotification notification);
  Future<void> schedule(DateTime at, AppNotification notification);
  Future<void> cancel(String id);
  Future<void> cancelAll();
}

/// Abstract push notification service (ready for future integration).
abstract class PushNotificationService {
  Future<void> registerDeviceToken(String token);
  Future<void> unregisterDeviceToken();
  Future<void> send(AppNotification notification);
  Stream<Map<String, dynamic>> get onMessageReceived;
}

/// Abstract email notification hook (ready for future integration).
abstract class EmailNotificationHook {
  Future<void> send(AppNotification notification, {String? toAddress});
}

/// Mock local notification service for development/testing.
class MockLocalNotificationService implements LocalNotificationService {
  final List<AppNotification> shown = [];
  final List<({DateTime at, AppNotification notification})> scheduled = [];

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> show(AppNotification notification) async {
    shown.add(notification);
  }

  @override
  Future<void> schedule(DateTime at, AppNotification notification) async {
    scheduled.add((at: at, notification: notification));
  }

  @override
  Future<void> cancel(String id) async {
    shown.removeWhere((n) => n.id == id);
    scheduled.removeWhere((s) => s.notification.id == id);
  }

  @override
  Future<void> cancelAll() async {
    shown.clear();
    scheduled.clear();
  }
}
