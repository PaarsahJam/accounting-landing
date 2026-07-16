import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/stock_adjustment.dart';
import 'package:accounting_app/features/inventory/domain/stock_adjustment_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockAdjustmentController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          inventoryRepositoryProvider.overrideWithValue(
            MockInventoryRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads adjustments on build', () async {
      container.listen(stockAdjustmentControllerProvider, (_, _) {});
      final notifier = container.read(
        stockAdjustmentControllerProvider.notifier,
      );
      final adjustments = await notifier.future;

      expect(adjustments, isNotEmpty);
    });

    test('createAdjustment prepends to state', () async {
      container.listen(stockAdjustmentControllerProvider, (_, _) {});
      final notifier = container.read(
        stockAdjustmentControllerProvider.notifier,
      );
      final initial = await notifier.future;
      final beforeCount = initial.length;

      final newAdj = StockAdjustment(
        id: 'ADJ-CT-001',
        productId: 'P-1001',
        warehouseId: 'WH-001',
        adjustmentDate: DateTime(2026, 1, 15),
        quantityBefore: 100,
        quantityAdjusted: -10,
        reason: 'Controller test',
        reference: 'ADJ-CT-001',
        createdAt: DateTime(2026, 1, 15),
        createdBy: 'test_user',
      );

      await notifier.createAdjustment(newAdj);

      final updated = container.read(stockAdjustmentControllerProvider).value!;
      expect(updated.length, equals(beforeCount + 1));
      expect(updated.first.id, equals('ADJ-CT-001'));
      expect(updated.first.quantityAfter, equals(90));
    });

    test('refresh reloads the adjustments list', () async {
      container.listen(stockAdjustmentControllerProvider, (_, _) {});
      final notifier = container.read(
        stockAdjustmentControllerProvider.notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container.read(stockAdjustmentControllerProvider).value;
      expect(state, isNotNull);
      expect(state!, isNotEmpty);
    });
  });
}
