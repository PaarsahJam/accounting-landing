import 'package:flutter/material.dart';

import '../domain/app_notification.dart';
import '../domain/notification_severity.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  final AppNotification notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _severityColor(theme);
    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: theme.colorScheme.error,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Opacity(
        opacity: notification.isRead ? 0.65 : 1.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withAlpha(30),
            child: Icon(_severityIcon, color: color, size: 20),
          ),
          title: Text(
            notification.title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                notification.body,
                style: theme.textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    notification.timeAgo,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (notification.senderName != null) ...[
                    const SizedBox(width: 8),
                    Icon(Icons.person_outline, size: 12, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 2),
                    Text(
                      notification.senderName!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          trailing: notification.isRead
              ? null
              : Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
          onTap: onTap,
        ),
      ),
    );
  }

  Color _severityColor(ThemeData theme) {
    switch (notification.severity) {
      case NotificationSeverity.info:
        return theme.colorScheme.primary;
      case NotificationSeverity.warning:
        return theme.colorScheme.error;
      case NotificationSeverity.error:
        return theme.colorScheme.error;
      case NotificationSeverity.success:
        return Colors.green;
    }
  }

  IconData get _severityIcon {
    switch (notification.severity) {
      case NotificationSeverity.info:
        return Icons.info_outline;
      case NotificationSeverity.warning:
        return Icons.warning_amber_outlined;
      case NotificationSeverity.error:
        return Icons.error_outline;
      case NotificationSeverity.success:
        return Icons.check_circle_outline;
    }
  }
}
