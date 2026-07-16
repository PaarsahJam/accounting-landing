import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockInventoryRepository — Stock Ledger', () {
    late MockInventoryRepository repository;

    setUp(() {
      repository = MockInventoryRepository();
    });

    test('fetchLedger returns entries for a known product', () async {
      final result = await repository.fetchLedger(productId: 'P-1001');

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('fetchLedger returns entries for another product', () async {
      final result = await repository.fetchLedger(productId: 'P-1002');

      expect(result.isSuccess, isTrue);
    });

    test(
      'fetchLedger with warehouseId filter returns only that warehouse',
      () async {
        final result = await repository.fetchLedger(
          productId: 'P-1001',
          warehouseId: 'WH-001',
        );

        expect(result.isSuccess, isTrue);
        if (result.data != null && result.data!.isNotEmpty) {
          for (final entry in result.data!) {
            expect(entry.warehouseId, equals('WH-001'));
          }
        }
      },
    );

    test('fetchLedger running balance is monotonically computed', () async {
      final result = await repository.fetchLedger(productId: 'P-1001');

      expect(result.isSuccess, isTrue);
      final entries = result.data!;
      if (entries.length >= 2) {
        // running balance should end at sum of quantities
        final sumQty = entries.fold(0.0, (s, e) => s + e.quantity);
        expect(entries.last.runningBalance, closeTo(sumQty, 0.01));
      }
    });

    test('fetchAdjustments returns list', () async {
      final result = await repository.fetchAdjustments();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('createAdjustment persists and returns the new adjustment', () async {
      final existing = await repository.fetchAdjustments();
      final before = existing.data!.length;

      final adj = (await repository.fetchAdjustments()).data!.first;
      final newAdj = adj.copyWith(
        id: 'ADJ-TEST-001',
        quantityAdjusted: 5,
        reason: 'Unit test',
      );

      final result = await repository.createAdjustment(newAdj);

      expect(result.isSuccess, isTrue);
      expect(result.data!.id, equals('ADJ-TEST-001'));

      final after = await repository.fetchAdjustments();
      expect(after.data!.length, equals(before + 1));
    });

    test('fetchTransfers returns list', () async {
      final result = await repository.fetchTransfers();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('fetchValuation returns non-empty list', () async {
      final result = await repository.fetchValuation();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('fetchCostLayers returns layers for a known product', () async {
      final result = await repository.fetchCostLayers('P-1001');

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('all valuation total values are non-negative', () async {
      final result = await repository.fetchValuation();

      expect(result.isSuccess, isTrue);
      for (final v in result.data!) {
        expect(v.totalValue, greaterThanOrEqualTo(0));
      }
    });
  });
}
