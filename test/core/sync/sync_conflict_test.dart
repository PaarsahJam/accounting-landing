import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/sync/sync_conflict.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';

void main() {
  late ConflictDetector detector;

  setUp(() {
    detector = const ConflictDetector();
  });

  SyncOperation makeOp(String id,
          {int localVersion = 1, OperationType type = OperationType.update}) =>
      SyncOperation(
        id: id,
        operationType: type,
        entityType: 'customer',
        entityId: 'CUST-$id',
        data: {'name': 'Updated'},
        localVersion: localVersion,
        createdAt: DateTime.now(),
      );

  group('detection', () {
    test('returns null when versions match', () {
      final conflict = detector.detect(makeOp('1', localVersion: 3), 3);
      expect(conflict, isNull);
    });

    test('returns null when local version is higher (no conflict)', () {
      final conflict = detector.detect(makeOp('1', localVersion: 5), 3);
      expect(conflict, isNull);
    });

    test('returns resolution when local version is behind server', () {
      final conflict = detector.detect(makeOp('1', localVersion: 2), 5);
      expect(conflict, isNotNull);
      expect(conflict!.resolved, isTrue);
    });

    test('returns null for create operations (no conflict possible)', () {
      final conflict = detector.detect(
        makeOp('1', type: OperationType.create, localVersion: 1),
        5,
      );
      expect(conflict, isNull);
    });
  });

  group('clientWins strategy', () {
    test('bumps localVersion to server version', () {
      final result = detector.resolve(
        makeOp('1', localVersion: 2),
        5,
        strategy: ConflictStrategy.clientWins,
      );
      expect(result.resolved, isTrue);
      expect(result.resolvedOperation, isNotNull);
      expect(result.resolvedOperation!.localVersion, equals(5));
    });

    test('keeps original data in resolved operation', () {
      final op = makeOp('1', localVersion: 2);
      final result = detector.resolve(
        op,
        5,
        strategy: ConflictStrategy.clientWins,
      );
      expect(result.resolvedOperation!.data['name'], equals('Updated'));
    });
  });

  group('serverWins strategy', () {
    test('returns null resolvedOperation (discard local)', () {
      final result = detector.resolve(
        makeOp('1', localVersion: 2),
        5,
        strategy: ConflictStrategy.serverWins,
      );
      expect(result.resolved, isTrue);
      expect(result.resolvedOperation, isNull);
    });
  });

  group('abort strategy', () {
    test('returns resolved=false and keeps operation in queue', () {
      final result = detector.resolve(
        makeOp('1', localVersion: 2),
        5,
        strategy: ConflictStrategy.abort,
      );
      expect(result.resolved, isFalse);
      expect(result.resolvedOperation, isNull);
      expect(result.resolutionNote, contains('manual resolution'));
    });
  });

  group('ConflictSummary', () {
    test('tracks detection and resolution counts', () {
      final summary = const ConflictSummary(
        totalChecked: 10,
        conflictsDetected: 3,
        resolved: 2,
        aborted: 1,
      );
      expect(summary.hasConflicts, isTrue);
      expect(summary.resolved, equals(2));
      expect(summary.aborted, equals(1));
    });
  });
}
