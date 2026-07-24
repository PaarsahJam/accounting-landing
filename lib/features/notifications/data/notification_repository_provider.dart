import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'notification_repository.dart';

part 'notification_repository_provider.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) =>
    MockNotificationRepository();
