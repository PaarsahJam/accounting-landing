import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/sync/cloud/cloud_sync_config.dart';

void main() {
  group('CloudSyncConfig', () {
    test('constructs with required fields', () {
      final config = const CloudSyncConfig(
        accountId: 'acc-1',
        companyId: 'comp-1',
      );
      expect(config.accountId, equals('acc-1'));
      expect(config.companyId, equals('comp-1'));
      expect(config.lastSyncCursor, isNull);
      expect(config.lastPullCursor, isNull);
      expect(config.deviceId, isNull);
    });

    test('advancePushCursor updates sync cursor', () {
      final now = DateTime(2026, 7, 23);
      final config = CloudSyncConfig(accountId: 'a', companyId: 'c')
          .advancePushCursor(now);
      expect(config.lastSyncCursor, equals(now));
      expect(config.lastPullCursor, isNull);
    });

    test('advancePullCursor updates pull cursor', () {
      final now = DateTime(2026, 7, 23);
      final config = CloudSyncConfig(accountId: 'a', companyId: 'c')
          .advancePullCursor(now);
      expect(config.lastPullCursor, equals(now));
      expect(config.lastSyncCursor, isNull);
    });

    test('hasPendingSync is true when push cursor differs from pull', () {
      final config = CloudSyncConfig(
        accountId: 'a',
        companyId: 'c',
        lastSyncCursor: DateTime(2026, 7, 23, 10),
        lastPullCursor: DateTime(2026, 7, 23, 9),
      );
      expect(config.hasPendingSync, isTrue);
    });

    test('hasPendingSync is false when cursors match', () {
      final t = DateTime(2026, 7, 23);
      final config = CloudSyncConfig(
        accountId: 'a',
        companyId: 'c',
        lastSyncCursor: t,
        lastPullCursor: t,
      );
      expect(config.hasPendingSync, isFalse);
    });

    test('JSON round-trip', () {
      final now = DateTime(2026, 7, 23, 12, 30, 0, 0);
      final original = CloudSyncConfig(
        accountId: 'acc-1',
        companyId: 'comp-1',
        lastSyncCursor: now,
        deviceId: 'device-x',
      );
      final json = original.toJson();
      final restored = CloudSyncConfig.fromJson(json);
      expect(restored.accountId, equals('acc-1'));
      expect(restored.companyId, equals('comp-1'));
      expect(restored.lastSyncCursor, equals(now));
      expect(restored.deviceId, equals('device-x'));
      expect(restored.lastPullCursor, isNull);
    });

    test('JSON string round-trip', () {
      final original = CloudSyncConfig(
        accountId: 'a',
        companyId: 'c',
        lastPullCursor: DateTime(2026, 7, 23),
      );
      final str = original.toJsonString();
      final restored = CloudSyncConfig.fromJsonString(str);
      expect(restored.accountId, equals('a'));
      expect(restored.companyId, equals('c'));
      expect(restored.lastPullCursor, isNotNull);
    });
  });
}
