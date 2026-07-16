import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/inventory_valuation_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InventoryValuationController', () {
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

    test('builds and returns non-empty valuations', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      final state = await notifier.future;

      expect(state.valuations, isNotEmpty);
    });

    test('grandTotalValue is sum of all valuation totalValues', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      final state = await notifier.future;

      final expected = state.valuations.fold(
        0.0,
        (sum, v) => sum + v.totalValue,
      );
      expect(state.grandTotalValue, closeTo(expected, 0.001));
    });

    test('totalProducts is distinct product count', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      final state = await notifier.future;

      final expected = state.valuations.map((v) => v.productId).toSet().length;
      expect(state.totalProducts, equals(expected));
    });

    test('totalWarehouses is distinct warehouse count', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      final state = await notifier.future;

      final expected = state.valuations
          .map((v) => v.warehouseId)
          .toSet()
          .length;
      expect(state.totalWarehouses, equals(expected));
    });

    test('valuationDate is set on build', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      final state = await notifier.future;

      expect(state.valuationDate.isAfter(DateTime(2000)), isTrue);
    });

    test('refresh reloads state successfully', () async {
      container.listen(inventoryValuationControllerProvider, (_, _) {});
      final notifier = container.read(
        inventoryValuationControllerProvider.notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container.read(inventoryValuationControllerProvider).value;
      expect(state, isNotNull);
      expect(state!.valuations, isNotEmpty);
    });
  });
}
