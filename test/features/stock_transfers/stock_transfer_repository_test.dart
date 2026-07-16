import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/stock_transfers/data/stock_transfer_repository.dart';
import 'package:accounting_app/features/stock_transfers/domain/create_transfer_request.dart';
import 'package:accounting_app/features/stock_transfers/domain/stock_transfer_status.dart';
import 'package:flutter_test/flutter_test.dart';

MockStockTransferRepository _makeRepo() => MockStockTransferRepository(
  inventoryRepository: MockInventoryRepository(),
  auditTrailRepository: MockAuditTrailRepository(),
);

void main() {
  group('MockStockTransferRepository', () {
    test('fetchTransfers returns seeded transfers', () async {
      final repo = _makeRepo();
      final result = await repo.fetchTransfers();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('seeded transfers have completed status', () async {
      final repo = _makeRepo();
      final result = await repo.fetchTransfers();

      for (final t in result.data!) {
        expect(t.status, equals(StockTransferStatus.completed));
      }
    });

    test('createTransfer succeeds with valid input', () async {
      final repo = _makeRepo();

      final request = CreateTransferRequest(
        productId: 'P-1001',
        fromWarehouseId: 'WH-001',
        toWarehouseId: 'WH-002',
        quantity: 2,
        transferDate: DateTime(2026, 6, 1),
        notes: 'Test transfer',
        createdBy: 'test_user',
      );

      final result = await repo.createTransfer(request);

      expect(result.isSuccess, isTrue);
      expect(result.data!.productId, equals('P-1001'));
      expect(result.data!.quantity, equals(2));
      expect(result.data!.status, equals(StockTransferStatus.completed));
    });

    test('createTransfer fails when source equals destination', () async {
      final repo = _makeRepo();

      final request = CreateTransferRequest(
        productId: 'P-1001',
        fromWarehouseId: 'WH-001',
        toWarehouseId: 'WH-001',
        quantity: 1,
        transferDate: DateTime(2026, 6, 1),
        notes: '',
        createdBy: 'test_user',
      );

      final result = await repo.createTransfer(request);

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('different'));
    });

    test('createTransfer fails when quantity is zero', () async {
      final repo = _makeRepo();

      final request = CreateTransferRequest(
        productId: 'P-1001',
        fromWarehouseId: 'WH-001',
        toWarehouseId: 'WH-002',
        quantity: 0,
        transferDate: DateTime(2026, 6, 1),
        notes: '',
        createdBy: 'test_user',
      );

      final result = await repo.createTransfer(request);

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('greater than zero'));
    });

    test(
      'createTransfer fails when quantity exceeds available stock',
      () async {
        final repo = _makeRepo();

        final request = CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-002',
          quantity: 9999,
          transferDate: DateTime(2026, 6, 1),
          notes: '',
          createdBy: 'test_user',
        );

        final result = await repo.createTransfer(request);

        expect(result.isSuccess, isFalse);
      },
    );

    test('createTransfer appends to list', () async {
      final repo = _makeRepo();
      final before = (await repo.fetchTransfers()).data!.length;

      await repo.createTransfer(
        CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-002',
          quantity: 1,
          transferDate: DateTime(2026, 6, 1),
          notes: '',
          createdBy: 'user',
        ),
      );

      final after = (await repo.fetchTransfers()).data!.length;
      expect(after, equals(before + 1));
    });

    test('createTransfer resolves product and warehouse names', () async {
      final repo = _makeRepo();

      final result = await repo.createTransfer(
        CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-002',
          quantity: 1,
          transferDate: DateTime(2026, 6, 1),
          notes: '',
          createdBy: 'user',
        ),
      );

      expect(result.data!.productName, isNotEmpty);
      expect(result.data!.fromWarehouseName, isNotEmpty);
      expect(result.data!.toWarehouseName, isNotEmpty);
    });

    test('cancelTransfer fails on completed transfer', () async {
      final repo = _makeRepo();

      // Fetch seeded transfers (all completed)
      final transfers = (await repo.fetchTransfers()).data!;
      final completedId = transfers.first.id;

      final result = await repo.cancelTransfer(completedId);

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('Cannot cancel a completed'));
    });

    test('completeTransfer fails on already-completed transfer', () async {
      final repo = _makeRepo();
      final transfers = (await repo.fetchTransfers()).data!;
      final completedId = transfers.first.id;

      final result = await repo.completeTransfer(completedId);

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('already completed'));
    });
  });
}
