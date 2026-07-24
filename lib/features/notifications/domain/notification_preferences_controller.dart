import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/notification_repository.dart';
import '../data/notification_repository_provider.dart';
import 'notification_channel.dart';
import 'notification_preference.dart';
import 'notification_type.dart';

part 'notification_preferences_controller.g.dart';

@riverpod
class NotificationPreferencesController
    extends _$NotificationPreferencesController {
  late final NotificationRepository _repository;

  @override
  FutureOr<NotificationPreferences> build() async {
    _repository = ref.watch(notificationRepositoryProvider);
    final result = await _repository.fetchPreferences();
    if (result.isSuccess) {
      return result.data ?? const NotificationPreferences();
    }
    AppLogger.warning('Failed to load notification preferences',
        error: result.error);
    throw result.error ??
        const UnknownFailure(message: 'Unknown error');
  }

  Future<void> toggleNotifications(bool enabled) async {
    try {
      final current = state.asData?.value ?? const NotificationPreferences();
      final updated = current.copyWith(notificationsEnabled: enabled);
      final saveResult = await _repository.savePreferences(updated);
      if (!saveResult.isSuccess) {
        throw saveResult.error ??
            const UnknownFailure(message: 'Failed to save preferences');
      }
      state = AsyncValue.data(updated);
    } catch (e, _) {
      AppLogger.warning('Failed to toggle notifications', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> toggleChannel(
    NotificationType type,
    NotificationChannel channel,
    bool enabled,
  ) async {
    try {
      final current = state.asData?.value ?? const NotificationPreferences();
      final existing = current.getPreference(type);
      final updatedPref = (existing ?? NotificationPreference(type: type))
          .copyWith(
        inAppEnabled:
            channel == NotificationChannel.inApp ? enabled : null,
        localEnabled:
            channel == NotificationChannel.local ? enabled : null,
        pushEnabled:
            channel == NotificationChannel.push ? enabled : null,
        emailEnabled:
            channel == NotificationChannel.email ? enabled : null,
      );
      final others = current.perTypePreferences
          .where((p) => p.type != type)
          .toList();
      final updated = current.copyWith(
        perTypePreferences: [...others, updatedPref],
      );
      final saveResult = await _repository.savePreferences(updated);
      if (!saveResult.isSuccess) {
        throw saveResult.error ??
            const UnknownFailure(message: 'Failed to save preferences');
      }
      state = AsyncValue.data(updated);
    } catch (e, _) {
      AppLogger.warning('Failed to toggle channel', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> toggleAllChannels(
    NotificationType type,
    NotificationChannel channel,
    bool enabled,
  ) async {
    try {
      final current = state.asData?.value ?? const NotificationPreferences();
      final updatedPrefs = NotificationType.values
          .map(
            (t) =>
                (current.getPreference(t) ?? NotificationPreference(type: t))
                    .copyWith(
              inAppEnabled:
                  channel == NotificationChannel.inApp ? enabled : null,
              localEnabled:
                  channel == NotificationChannel.local ? enabled : null,
              pushEnabled:
                  channel == NotificationChannel.push ? enabled : null,
              emailEnabled:
                  channel == NotificationChannel.email ? enabled : null,
            ),
          )
          .toList();
      final updated = current.copyWith(perTypePreferences: updatedPrefs);
      final saveResult = await _repository.savePreferences(updated);
      if (!saveResult.isSuccess) {
        throw saveResult.error ??
            const UnknownFailure(message: 'Failed to save preferences');
      }
      state = AsyncValue.data(updated);
    } catch (e, _) {
      AppLogger.warning('Failed to toggle all channels', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> setQuietHours({
    required bool enabled,
    int? startHour,
    int? startMinute,
    int? endHour,
    int? endMinute,
  }) async {
    try {
      final current = state.asData?.value ?? const NotificationPreferences();
      final updated = current.copyWith(
        quietHoursEnabled: enabled,
        quietHoursStart:
            startHour != null && startMinute != null
                ? TimeOfDay(hour: startHour, minute: startMinute)
                : current.quietHoursStart,
        quietHoursEnd:
            endHour != null && endMinute != null
                ? TimeOfDay(hour: endHour, minute: endMinute)
                : current.quietHoursEnd,
      );
      final saveResult = await _repository.savePreferences(updated);
      if (!saveResult.isSuccess) {
        throw saveResult.error ??
            const UnknownFailure(message: 'Failed to save preferences');
      }
      state = AsyncValue.data(updated);
    } catch (e, _) {
      AppLogger.warning('Failed to set quiet hours', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchPreferences();
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(
        result.data ?? const NotificationPreferences(),
      );
    } catch (e, st) {
      AppLogger.warning('Failed to refresh preferences', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
