import '../domain/app_notification.dart';
import '../domain/notification_channel.dart';
import '../domain/notification_severity.dart';
import '../domain/notification_type.dart';

AppNotification approvalNotification({
  required String id,
  required String entityType,
  required String entityId,
  required String entityLabel,
  required String action,
  required String performedBy,
}) {
  final title = '$action $entityType';
  final body = '$entityLabel has been $action by $performedBy';
  return AppNotification(
    id: id,
    type: NotificationType.approval,
    severity: action == 'rejected' ? NotificationSeverity.warning : NotificationSeverity.info,
    title: title,
    body: body,
    senderName: performedBy,
    relatedEntityType: entityType,
    relatedEntityId: entityId,
    createdAt: DateTime.now(),
    channels: const [NotificationChannel.inApp, NotificationChannel.local],
  );
}

AppNotification mentionNotification({
  required String id,
  required String mentionedBy,
  required String context,
  required String? entityType,
  required String? entityId,
}) {
  return AppNotification(
    id: id,
    type: NotificationType.mention,
    severity: NotificationSeverity.info,
    title: 'You were mentioned',
    body: '$mentionedBy mentioned you in $context',
    senderName: mentionedBy,
    relatedEntityType: entityType,
    relatedEntityId: entityId,
    createdAt: DateTime.now(),
    channels: const [NotificationChannel.inApp, NotificationChannel.local, NotificationChannel.push],
  );
}

AppNotification dueDateNotification({
  required String id,
  required String entityType,
  required String entityLabel,
  required DateTime dueDate,
  int daysUntilDue = 0,
}) {
  final isOverdue = daysUntilDue < 0;
  final urgency = isOverdue
      ? NotificationSeverity.error
      : daysUntilDue <= 1
          ? NotificationSeverity.warning
          : NotificationSeverity.info;
  final prefix = isOverdue ? 'Overdue' : 'Due';
  final dayLabel = isOverdue
      ? '${-daysUntilDue} days ago'
      : daysUntilDue == 0
          ? 'today'
          : 'in $daysUntilDue days';

  return AppNotification(
    id: id,
    type: NotificationType.dueDate,
    severity: urgency,
    title: '$prefix $entityType',
    body: '$entityLabel is $dayLabel',
    relatedEntityType: entityType,
    relatedEntityId: entityLabel,
    createdAt: DateTime.now(),
    channels: const [NotificationChannel.inApp, NotificationChannel.local, NotificationChannel.push],
  );
}

AppNotification failedSyncNotification({
  required String id,
  required String serviceName,
  required String errorMessage,
  int retryCount = 0,
}) {
  return AppNotification(
    id: id,
    type: NotificationType.failedSync,
    severity: NotificationSeverity.error,
    title: 'Sync Failed',
    body: '$serviceName failed to sync: $errorMessage',
    relatedEntityType: 'sync',
    relatedEntityId: serviceName,
    createdAt: DateTime.now(),
    channels: const [
      NotificationChannel.inApp,
      NotificationChannel.local,
      NotificationChannel.push,
      NotificationChannel.email,
    ],
  );
}

AppNotification documentStatusNotification({
  required String id,
  required String documentType,
  required String documentLabel,
  required String oldStatus,
  required String newStatus,
  String? performedBy,
}) {
  final title = '$documentType $newStatus';
  final performer = performedBy != null ? ' by $performedBy' : '';
  final body = '$documentLabel moved from $oldStatus to $newStatus$performer';
  final isError = newStatus == 'cancelled' || newStatus == 'rejected';
  return AppNotification(
    id: id,
    type: NotificationType.documentStatus,
    severity: isError ? NotificationSeverity.warning : NotificationSeverity.info,
    title: title,
    body: body,
    senderName: performedBy,
    relatedEntityType: documentType,
    relatedEntityId: documentLabel,
    createdAt: DateTime.now(),
    channels: const [NotificationChannel.inApp, NotificationChannel.local],
  );
}
