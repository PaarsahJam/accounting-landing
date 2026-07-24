import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/notification_repository.dart';
import '../data/notification_repository_provider.dart';
import 'app_notification.dart';

part 'notification_controller.g.dart';

@riverpod
class NotificationController extends _$NotificationController {
  late final NotificationRepository _repository;

  @override
  FutureOr<List<AppNotification>> build() async {
    _repository = ref.watch(notificationRepositoryProvider);
    final result = await _repository.fetchNotifications();
    if (result.isSuccess) {
      return result.data ?? const <AppNotification>[];
    }
    AppLogger.warning('Failed to load notifications', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  int get unreadCount {
    final list = state.asData?.value ?? <AppNotification>[];
    return list.where((n) => !n.isRead).length;
  }

  Future<void> markAsRead(String id) async {
    try {
      final result = await _repository.markAsRead(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <AppNotification>[];
      state = AsyncValue.data(
        current.map((n) => n.id == id ? result.data! : n).toList(),
      );
    } catch (e, _) {
      AppLogger.warning('Failed to mark notification as read', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final result = await _repository.markAllAsRead();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <AppNotification>[];
      state = AsyncValue.data(
        current.map((n) => n.copyWith(isRead: true)).toList(),
      );
    } catch (e, _) {
      AppLogger.warning('Failed to mark all as read', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      final result = await _repository.deleteNotification(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <AppNotification>[];
      state = AsyncValue.data(
        current.where((n) => n.id != id).toList(),
      );
    } catch (e, _) {
      AppLogger.warning('Failed to delete notification', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> clearAll() async {
    try {
      final result = await _repository.clearAll();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = const AsyncValue.data(<AppNotification>[]);
    } catch (e, _) {
      AppLogger.warning('Failed to clear notifications', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchNotifications();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <AppNotification>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh notifications', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provider that exposes only the unread count.
@riverpod
int unreadNotificationCount(Ref ref) {
  final notifications = ref.watch(notificationControllerProvider);
  return notifications.when(
    loading: () => 0,
    error: (_, _) => 0,
    data: (list) => list.where((n) => !n.isRead).length,
  );
}
