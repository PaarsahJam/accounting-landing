import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/app_notification.dart';
import '../domain/notification_channel.dart';
import '../domain/notification_preference.dart';
import '../domain/notification_severity.dart';
import '../domain/notification_type.dart';

abstract class NotificationRepository {
  Future<AppResult<List<AppNotification>>> fetchNotifications({
    bool unreadOnly = false,
    int limit = 50,
  });

  Future<AppResult<AppNotification>> markAsRead(String id);

  Future<AppResult<void>> markAllAsRead();

  Future<AppResult<void>> deleteNotification(String id);

  Future<AppResult<void>> clearAll();

  Future<AppResult<NotificationPreferences>> fetchPreferences();

  Future<AppResult<void>> savePreferences(NotificationPreferences preferences);
}

class MockNotificationRepository implements NotificationRepository {
  final List<AppNotification> _notifications = [];
  NotificationPreferences _preferences = const NotificationPreferences();

  MockNotificationRepository() {
    _seed();
  }

  void _seed() {
    _notifications.addAll([
      AppNotification(
        id: 'notif-1',
        type: NotificationType.approval,
        severity: NotificationSeverity.success,
        title: 'Invoice Approved',
        body: 'INV-2026-0042 has been approved by Ava Rahimi',
        senderName: 'Ava Rahimi',
        relatedEntityType: 'salesInvoice',
        relatedEntityId: 'INV-2026-0042',
        createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        channels: const [NotificationChannel.inApp],
      ),
      AppNotification(
        id: 'notif-2',
        type: NotificationType.dueDate,
        severity: NotificationSeverity.warning,
        title: 'Due Date Reminder',
        body: 'Vendor bill VB-2026-0018 is due tomorrow',
        relatedEntityType: 'vendorBill',
        relatedEntityId: 'VB-2026-0018',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        channels: const [NotificationChannel.inApp, NotificationChannel.local],
      ),
      AppNotification(
        id: 'notif-3',
        type: NotificationType.mention,
        severity: NotificationSeverity.info,
        title: 'You were mentioned',
        body: 'Kaveh Moradi mentioned you in a comment on PO-2026-0051',
        senderName: 'Kaveh Moradi',
        relatedEntityType: 'purchaseOrder',
        relatedEntityId: 'PO-2026-0051',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        channels: const [NotificationChannel.inApp],
      ),
      AppNotification(
        id: 'notif-4',
        type: NotificationType.failedSync,
        severity: NotificationSeverity.error,
        title: 'Bank Sync Failed',
        body: 'Bank reconciliation service failed to sync: Connection timeout',
        relatedEntityType: 'sync',
        relatedEntityId: 'bank_reconciliation',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        channels: const [
          NotificationChannel.inApp,
          NotificationChannel.local,
          NotificationChannel.email,
        ],
      ),
      AppNotification(
        id: 'notif-5',
        type: NotificationType.documentStatus,
        severity: NotificationSeverity.info,
        title: 'Purchase Order Approved',
        body: 'PO-2026-0052 has been approved',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        channels: const [NotificationChannel.inApp],
      ),
    ]);
  }

  @override
  Future<AppResult<List<AppNotification>>> fetchNotifications({
    bool unreadOnly = false,
    int limit = 50,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      var result = _notifications.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (unreadOnly) {
        result = result.where((n) => !n.isRead).toList();
      }
      if (result.length > limit) {
        result = result.sublist(0, limit);
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<AppNotification>> markAsRead(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index < 0) {
        return AppResult.failure(
          UnknownFailure(message: 'Notification not found: $id'),
        );
      }
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      return AppResult.success(_notifications[index]);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> markAllAsRead() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      for (var i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> deleteNotification(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _notifications.removeWhere((n) => n.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> clearAll() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _notifications.clear();
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<NotificationPreferences>> fetchPreferences() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return AppResult.success(_preferences);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> savePreferences(
    NotificationPreferences preferences,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _preferences = preferences;
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }
}
