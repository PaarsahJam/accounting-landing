import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/stock_ledger_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockLedgerController', () {
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

    test('builds successfully and returns non-empty entries', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      final state = await notifier.future;

      expect(state.productId, equals('P-1001'));
      expect(state.entries, isNotEmpty);
    });

    test('computes totalInbound correctly', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      final state = await notifier.future;

      final expected = state.entries
          .where((e) => e.quantity > 0)
          .fold(0.0, (s, e) => s + e.quantity);
      expect(state.totalInbound, closeTo(expected, 0.001));
    });

    test('computes totalOutbound correctly (positive value)', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      final state = await notifier.future;

      final expected = state.entries
          .where((e) => e.quantity < 0)
          .fold(0.0, (s, e) => s + e.quantity.abs());
      expect(state.totalOutbound, closeTo(expected, 0.001));
    });

    test('setWarehouseFilter updates state synchronously', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      await notifier.future;

      notifier.setWarehouseFilter('WH-001');

      final updated = container
          .read(stockLedgerControllerProvider('P-1001'))
          .value;
      expect(updated?.warehouseFilter, equals('WH-001'));
    });

    test('setWarehouseFilter to null clears the filter', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      await notifier.future;

      notifier.setWarehouseFilter('WH-001');
      notifier.setWarehouseFilter(null);

      final updated = container
          .read(stockLedgerControllerProvider('P-1001'))
          .value;
      expect(updated?.warehouseFilter, isNull);
    });

    test('refresh reloads entries', () async {
      container.listen(stockLedgerControllerProvider('P-1001'), (_, _) {});
      final notifier = container.read(
        stockLedgerControllerProvider('P-1001').notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container
          .read(stockLedgerControllerProvider('P-1001'))
          .value;
      expect(state, isNotNull);
      expect(state!.entries, isNotEmpty);
    });
  });
}
