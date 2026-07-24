import 'notification_channel.dart';
import 'notification_severity.dart';
import 'notification_type.dart';

class AppNotification {
  final String id;
  final NotificationType type;
  final NotificationSeverity severity;
  final String title;
  final String body;
  final String? senderName;
  final String? senderAvatar;
  final String? relatedEntityType;
  final String? relatedEntityId;
  final String? actionRoute;
  final DateTime createdAt;
  final bool isRead;
  final List<NotificationChannel> channels;

  const AppNotification({
    required this.id,
    required this.type,
    this.severity = NotificationSeverity.info,
    required this.title,
    required this.body,
    this.senderName,
    this.senderAvatar,
    this.relatedEntityType,
    this.relatedEntityId,
    this.actionRoute,
    required this.createdAt,
    this.isRead = false,
    this.channels = const [NotificationChannel.inApp],
  });

  AppNotification copyWith({
    String? id,
    NotificationType? type,
    NotificationSeverity? severity,
    String? title,
    String? body,
    String? senderName,
    String? senderAvatar,
    String? relatedEntityType,
    String? relatedEntityId,
    String? actionRoute,
    DateTime? createdAt,
    bool? isRead,
    List<NotificationChannel>? channels,
  }) {
    return AppNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      title: title ?? this.title,
      body: body ?? this.body,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      actionRoute: actionRoute ?? this.actionRoute,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      channels: channels ?? this.channels,
    );
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${createdAt.month}/${createdAt.day}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppNotification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AppNotification(id: $id, type: $type, title: $title)';
}
