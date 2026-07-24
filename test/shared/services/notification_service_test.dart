import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/services/notification_service.dart';

void main() {
  group('NotificationService', () {
    test('checkPermission returns notDetermined', () async {
      final service = NotificationService();
      final result = await service.checkPermission();
      expect(result, NotificationPermission.notDetermined);
    });

    test('requestPermission returns true', () async {
      final service = NotificationService();
      final result = await service.requestPermission();
      expect(result, isTrue);
    });
  });
}
