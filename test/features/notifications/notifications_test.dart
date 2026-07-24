import 'package:flutter_test/flutter_test.dart';

import '../../../lib/features/notifications/data/notification_repository.dart';
import '../../../lib/features/notifications/domain/app_notification.dart';
import '../../../lib/features/notifications/domain/notification_channel.dart';
import '../../../lib/features/notifications/domain/notification_preference.dart';
import '../../../lib/features/notifications/domain/notification_severity.dart';
import '../../../lib/features/notifications/domain/notification_type.dart';
import '../../../lib/features/notifications/generators/notification_generators.dart';
import '../../../lib/features/notifications/services/notification_service.dart';

void main() {
  group('AppNotification', () {
    test('creates notification with required fields', () {
      final now = DateTime.now();
      final notification = AppNotification(
        id: 'n1',
        type: NotificationType.approval,
        title: 'Test',
        body: 'Test body',
        createdAt: now,
      );
      expect(notification.id, 'n1');
      expect(notification.type, NotificationType.approval);
      expect(notification.isRead, false);
      expect(notification.channels, [NotificationChannel.inApp]);
    });

    test('copyWith preserves unchanged fields', () {
      final n = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now(),
      );
      final updated = n.copyWith(isRead: true);
      expect(updated.isRead, true);
      expect(updated.id, 'n1');
      expect(updated.title, 'T');
    });

    test('equality is based on id', () {
      final now = DateTime.now();
      final a = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'A', body: 'Body',
        createdAt: now,
      );
      final b = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'B', body: 'Different',
        createdAt: now,
      );
      expect(a, equals(b));
    });

    test('timeAgo returns relative format', () {
      final recent = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      );
      expect(recent.timeAgo, '5m ago');

      final old = AppNotification(
        id: 'n2', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      );
      expect(old.timeAgo, '3d ago');
    });
  });

  group('NotificationType enum', () {
    test('all types have labels', () {
      for (final type in NotificationType.values) {
        expect(type.label, isNotEmpty);
      }
    });
  });

  group('NotificationChannel enum', () {
    test('all channels have labels', () {
      for (final channel in NotificationChannel.values) {
        expect(channel.label, isNotEmpty);
      }
    });
  });

  group('NotificationSeverity enum', () {
    test('all severities have labels', () {
      for (final s in NotificationSeverity.values) {
        expect(s.label, isNotEmpty);
      }
    });
  });

  group('NotificationPreference', () {
    test('defaults to in-app enabled, others disabled', () {
      final pref = NotificationPreference(type: NotificationType.approval);
      expect(pref.inAppEnabled, true);
      expect(pref.localEnabled, false);
      expect(pref.pushEnabled, false);
      expect(pref.emailEnabled, false);
    });

    test('isEnabledForChannel checks specific channel', () {
      final pref = NotificationPreference(
        type: NotificationType.approval,
        inAppEnabled: true,
        localEnabled: false,
        pushEnabled: true,
        emailEnabled: false,
      );
      expect(pref.isEnabledForChannel(NotificationChannel.inApp), true);
      expect(pref.isEnabledForChannel(NotificationChannel.local), false);
      expect(pref.isEnabledForChannel(NotificationChannel.push), true);
      expect(pref.isEnabledForChannel(NotificationChannel.email), false);
    });

    test('copyWith only overrides specified fields', () {
      final pref = NotificationPreference(type: NotificationType.approval);
      final updated = pref.copyWith(localEnabled: true);
      expect(updated.localEnabled, true);
      expect(updated.inAppEnabled, true);
      expect(updated.emailEnabled, false);
    });
  });

  group('NotificationPreferences', () {
    test('notifications enabled by default', () {
      const prefs = NotificationPreferences();
      expect(prefs.notificationsEnabled, true);
      expect(prefs.quietHoursEnabled, false);
    });

    test('isTypeEnabled returns false when master toggle is off', () {
      const prefs = NotificationPreferences(notificationsEnabled: false);
      expect(
        prefs.isTypeEnabled(
          NotificationType.approval,
          NotificationChannel.inApp,
        ),
        false,
      );
    });

    test('isTypeEnabled checks per-type preference', () {
      final prefs = NotificationPreferences(
        notificationsEnabled: true,
        perTypePreferences: [
          NotificationPreference(
            type: NotificationType.approval,
            inAppEnabled: false,
          ),
        ],
      );
      expect(
        prefs.isTypeEnabled(
          NotificationType.approval,
          NotificationChannel.inApp,
        ),
        false,
      );
      expect(
        prefs.isTypeEnabled(
          NotificationType.dueDate,
          NotificationChannel.inApp,
        ),
        true,
      );
    });

    test('getPreference returns null for unregistered type', () {
      const prefs = NotificationPreferences();
      expect(prefs.getPreference(NotificationType.approval), isNull);
    });
  });

  group('NotificationGenerators', () {
    test('approvalNotification creates correct notification', () {
      final n = approvalNotification(
        id: 'a1',
        entityType: 'salesInvoice',
        entityId: 'INV-001',
        entityLabel: 'INV-2026-0001',
        action: 'approved',
        performedBy: 'Alice',
      );
      expect(n.type, NotificationType.approval);
      expect(n.severity, NotificationSeverity.info);
      expect(n.body, contains('Alice'));
      expect(n.relatedEntityType, 'salesInvoice');
    });

    test('approvalNotification uses warning severity on reject', () {
      final n = approvalNotification(
        id: 'a2',
        entityType: 'vendorBill',
        entityId: 'VB-001',
        entityLabel: 'VB-2026-0001',
        action: 'rejected',
        performedBy: 'Bob',
      );
      expect(n.severity, NotificationSeverity.warning);
    });

    test('mentionNotification includes context', () {
      final n = mentionNotification(
        id: 'm1',
        mentionedBy: 'Kaveh',
        context: 'a comment on PO-0051',
        entityType: 'purchaseOrder',
        entityId: 'PO-0051',
      );
      expect(n.type, NotificationType.mention);
      expect(n.title, 'You were mentioned');
      expect(n.body, contains('Kaveh'));
      expect(n.channels, contains(NotificationChannel.push));
    });

    test('dueDateNotification creates overdue variant', () {
      final n = dueDateNotification(
        id: 'd1',
        entityType: 'vendorBill',
        entityLabel: 'VB-0018',
        dueDate: DateTime.now().subtract(const Duration(days: 2)),
        daysUntilDue: -2,
      );
      expect(n.type, NotificationType.dueDate);
      expect(n.severity, NotificationSeverity.error);
      expect(n.title, 'Overdue vendorBill');
      expect(n.body, contains('2 days ago'));
    });

    test('dueDateNotification uses warning for due today', () {
      final n = dueDateNotification(
        id: 'd2',
        entityType: 'invoice',
        entityLabel: 'INV-0042',
        dueDate: DateTime.now(),
        daysUntilDue: 0,
      );
      expect(n.severity, NotificationSeverity.warning);
      expect(n.body, contains('today'));
    });

    test('failedSyncNotification includes error message', () {
      final n = failedSyncNotification(
        id: 'f1',
        serviceName: 'Bank Reconciliation',
        errorMessage: 'Connection timeout',
      );
      expect(n.type, NotificationType.failedSync);
      expect(n.severity, NotificationSeverity.error);
      expect(n.title, 'Sync Failed');
      expect(n.body, contains('Connection timeout'));
      expect(n.channels, contains(NotificationChannel.email));
    });

    test('documentStatusNotification detects cancelled status', () {
      final n = documentStatusNotification(
        id: 'ds1',
        documentType: 'purchaseOrder',
        documentLabel: 'PO-0051',
        oldStatus: 'approved',
        newStatus: 'cancelled',
      );
      expect(n.type, NotificationType.documentStatus);
      expect(n.severity, NotificationSeverity.warning);
      expect(n.title, 'purchaseOrder cancelled');
    });

    test('documentStatusNotification info for normal transitions', () {
      final n = documentStatusNotification(
        id: 'ds2',
        documentType: 'invoice',
        documentLabel: 'INV-0042',
        oldStatus: 'draft',
        newStatus: 'approved',
        performedBy: 'Alice',
      );
      expect(n.severity, NotificationSeverity.info);
      expect(n.body, contains('Alice'));
    });
  });

  group('NotificationPreferencesController logic', () {
    test('quiet hours logic blocks during quiet period', () {
      // Quiet hours 22:00 - 07:00
      final prefs = NotificationPreferences(
        quietHoursEnabled: true,
        quietHoursStart: TimeOfDay(hour: 22, minute: 0),
        quietHoursEnd: TimeOfDay(hour: 7, minute: 0),
      );
      final now = DateTime.now();
      final currentHour = now.hour;
      final currentMinute = now.minute;
      final inQuietHours = (currentHour >= 22 || currentHour < 7) ||
          (currentHour == 7 && currentMinute == 0);
      expect(
        prefs.isTypeEnabled(NotificationType.system, NotificationChannel.inApp),
        !inQuietHours,
      );
    });

    test('quiet hours disabled does not block', () {
      const prefs = NotificationPreferences(quietHoursEnabled: false);
      expect(
        prefs.isTypeEnabled(NotificationType.system, NotificationChannel.inApp),
        true,
      );
    });
  });

  group('NotificationRepository', () {
    late MockNotificationRepository repository;

    setUp(() {
      repository = MockNotificationRepository();
    });

    test('fetchNotifications returns seeded data', () async {
      final result = await repository.fetchNotifications();
      expect(result.isSuccess, true);
      expect(result.data!.length, greaterThan(0));
    });

    test('fetchNotifications with unreadOnly filters correctly', () async {
      final allResult = await repository.fetchNotifications();
      final unreadResult = await repository.fetchNotifications(unreadOnly: true);
      final unreadCount =
          allResult.data!.where((n) => !n.isRead).length;
      expect(unreadResult.data!.length, unreadCount);
    });

    test('markAsRead updates notification', () async {
      final result = await repository.markAsRead('notif-1');
      expect(result.isSuccess, true);
      expect(result.data!.isRead, true);
    });

    test('markAllAsRead marks all', () async {
      await repository.markAllAsRead();
      final result = await repository.fetchNotifications();
      expect(result.data!.every((n) => n.isRead), true);
    });

    test('deleteNotification removes single notification', () async {
      await repository.deleteNotification('notif-1');
      final result = await repository.fetchNotifications();
      expect(result.data!.any((n) => n.id == 'notif-1'), false);
    });

    test('clearAll removes all notifications', () async {
      await repository.clearAll();
      final result = await repository.fetchNotifications();
      expect(result.data!.isEmpty, true);
    });

    test('fetchPreferences returns defaults', () async {
      final result = await repository.fetchPreferences();
      expect(result.isSuccess, true);
      expect(result.data!.notificationsEnabled, true);
    });

    test('savePreferences persists changes', () async {
      const prefs = NotificationPreferences(notificationsEnabled: false);
      await repository.savePreferences(prefs);
      final result = await repository.fetchPreferences();
      expect(result.data!.notificationsEnabled, false);
    });
  });

  group('LocalNotificationService', () {
    late MockLocalNotificationService service;

    setUp(() {
      service = MockLocalNotificationService();
    });

    test('show adds to shown list', () async {
      final n = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now(),
      );
      await service.show(n);
      expect(service.shown.length, 1);
      expect(service.shown.first.id, 'n1');
    });

    test('schedule adds to scheduled list', () async {
      final n = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now(),
      );
      final at = DateTime.now().add(const Duration(hours: 1));
      await service.schedule(at, n);
      expect(service.scheduled.length, 1);
      expect(service.scheduled.first.at, at);
    });

    test('cancel removes from both lists', () async {
      final n = AppNotification(
        id: 'n1', type: NotificationType.system,
        title: 'T', body: 'B',
        createdAt: DateTime.now(),
      );
      await service.show(n);
      await service.cancel('n1');
      expect(service.shown.isEmpty, true);
    });
  });
}
