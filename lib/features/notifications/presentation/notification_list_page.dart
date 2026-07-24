import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/notification_controller.dart';
import 'notification_tile.dart';

class NotificationListPage extends ConsumerWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNotifications = ref.watch(notificationControllerProvider);

    return ResponsivePageScaffold(
      title: 'Notifications',
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            final notifier = ref.read(notificationControllerProvider.notifier);
            if (value == 'mark_all_read') {
              notifier.markAllAsRead();
            } else if (value == 'clear_all') {
              notifier.clearAll();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'mark_all_read', child: Text('Mark all as read')),
            const PopupMenuItem(value: 'clear_all', child: Text('Clear all')),
          ],
        ),
      ],
      child: asyncNotifications.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (notifications) {
          if (notifications.isEmpty) {
            return AppEmptyState(
              title: 'No notifications',
              message: 'You\'re all caught up!',
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(notificationControllerProvider.notifier).refresh(),
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationTile(
                  notification: notification,
                  onTap: () {
                    if (!notification.isRead) {
                      ref
                          .read(notificationControllerProvider.notifier)
                          .markAsRead(notification.id);
                    }
                  },
                  onDismiss: () {
                    ref
                        .read(notificationControllerProvider.notifier)
                        .deleteNotification(notification.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
