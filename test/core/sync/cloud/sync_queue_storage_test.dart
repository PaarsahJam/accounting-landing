import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/cloud/sync_queue_storage.dart';

SyncOperation makeOp(String id) => SyncOperation(
      id: id,
      operationType: OperationType.create,
      entityType: 'customer',
      entityId: 'CUST-$id',
      data: {'name': 'Test'},
    );

void main() {
  group('MemorySyncQueueStorage', () {
    late MemorySyncQueueStorage storage;

    setUp(() {
      storage = MemorySyncQueueStorage();
    });

    test('loadPending returns empty list initially', () async {
      final ops = await storage.loadPending();
      expect(ops, isEmpty);
    });

    test('append adds operation', () async {
      await storage.append(makeOp('1'));
      final ops = await storage.loadPending();
      expect(ops, hasLength(1));
      expect(ops.first.id, equals('1'));
    });

    test('remove deletes operation by id', () async {
      await storage.append(makeOp('1'));
      await storage.append(makeOp('2'));
      await storage.remove('1');
      final ops = await storage.loadPending();
      expect(ops, hasLength(1));
      expect(ops.first.id, equals('2'));
    });

    test('savePending replaces all operations', () async {
      await storage.append(makeOp('1'));
      await storage.savePending([makeOp('A'), makeOp('B')]);
      final ops = await storage.loadPending();
      expect(ops, hasLength(2));
      expect(ops.map((o) => o.id), containsAll(['A', 'B']));
    });

    test('clear removes all operations', () async {
      await storage.append(makeOp('1'));
      await storage.clear();
      final ops = await storage.loadPending();
      expect(ops, isEmpty);
    });
  });
}
