import 'notification_channel.dart';
import 'notification_type.dart';

class NotificationPreference {
  final NotificationType type;
  final bool inAppEnabled;
  final bool localEnabled;
  final bool pushEnabled;
  final bool emailEnabled;

  const NotificationPreference({
    required this.type,
    this.inAppEnabled = true,
    this.localEnabled = false,
    this.pushEnabled = false,
    this.emailEnabled = false,
  });

  bool isEnabledForChannel(NotificationChannel channel) {
    switch (channel) {
      case NotificationChannel.inApp:
        return inAppEnabled;
      case NotificationChannel.local:
        return localEnabled;
      case NotificationChannel.push:
        return pushEnabled;
      case NotificationChannel.email:
        return emailEnabled;
    }
  }

  NotificationPreference copyWith({
    NotificationType? type,
    bool? inAppEnabled,
    bool? localEnabled,
    bool? pushEnabled,
    bool? emailEnabled,
  }) {
    return NotificationPreference(
      type: type ?? this.type,
      inAppEnabled: inAppEnabled ?? this.inAppEnabled,
      localEnabled: localEnabled ?? this.localEnabled,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      emailEnabled: emailEnabled ?? this.emailEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationPreference &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          inAppEnabled == other.inAppEnabled &&
          localEnabled == other.localEnabled &&
          pushEnabled == other.pushEnabled &&
          emailEnabled == other.emailEnabled;

  @override
  int get hashCode =>
      Object.hash(type, inAppEnabled, localEnabled, pushEnabled, emailEnabled);

  @override
  String toString() => 'NotificationPreference(type: $type)';
}

class NotificationPreferences {
  final bool notificationsEnabled;
  final bool quietHoursEnabled;
  final TimeOfDay? quietHoursStart;
  final TimeOfDay? quietHoursEnd;
  final List<NotificationPreference> perTypePreferences;

  const NotificationPreferences({
    this.notificationsEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.perTypePreferences = const [],
  });

  NotificationPreference? getPreference(NotificationType type) {
    try {
      return perTypePreferences.firstWhere((p) => p.type == type);
    } catch (_) {
      return null;
    }
  }

  bool isTypeEnabled(NotificationType type, NotificationChannel channel) {
    if (!notificationsEnabled) return false;
    if (quietHoursEnabled && _isInQuietHours) return false;
    final pref = getPreference(type);
    return pref?.isEnabledForChannel(channel) ?? true;
  }

  bool get _isInQuietHours {
    if (!quietHoursEnabled || quietHoursStart == null || quietHoursEnd == null) {
      return false;
    }
    final now = DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;
    final startMinutes = quietHoursStart!.hour * 60 + quietHoursStart!.minute;
    final endMinutes = quietHoursEnd!.hour * 60 + quietHoursEnd!.minute;
    if (startMinutes <= endMinutes) {
      return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
    }
    return currentMinutes >= startMinutes || currentMinutes <= endMinutes;
  }

  NotificationPreferences copyWith({
    bool? notificationsEnabled,
    bool? quietHoursEnabled,
    TimeOfDay? quietHoursStart,
    TimeOfDay? quietHoursEnd,
    List<NotificationPreference>? perTypePreferences,
    bool clearQuietHoursStart = false,
    bool clearQuietHoursEnd = false,
  }) {
    return NotificationPreferences(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: clearQuietHoursStart ? null : (quietHoursStart ?? this.quietHoursStart),
      quietHoursEnd: clearQuietHoursEnd ? null : (quietHoursEnd ?? this.quietHoursEnd),
      perTypePreferences: perTypePreferences ?? this.perTypePreferences,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationPreferences &&
          runtimeType == other.runtimeType &&
          notificationsEnabled == other.notificationsEnabled &&
          quietHoursEnabled == other.quietHoursEnabled &&
          quietHoursStart == other.quietHoursStart &&
          quietHoursEnd == other.quietHoursEnd &&
          _listEquals(perTypePreferences, other.perTypePreferences);

  @override
  int get hashCode => Object.hash(
    notificationsEnabled,
    quietHoursEnabled,
    quietHoursStart,
    quietHoursEnd,
    Object.hashAll(perTypePreferences),
  );

  static bool _listEquals(List<dynamic> a, List<dynamic> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() =>
      'NotificationPreferences(enabled: $notificationsEnabled, types: ${perTypePreferences.length})';
}

class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => Object.hash(hour, minute);

  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
