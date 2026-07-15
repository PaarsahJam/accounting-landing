import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/warehouse_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WarehouseController', () {
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

    test('loads warehouses and stock movements', () async {
      final controller = container.read(warehouseControllerProvider.notifier);
      final warehouses = await controller.future;
      final movements = await controller.fetchMovements('P-1001');

      expect(warehouses, isNotEmpty);
      expect(movements, isNotEmpty);
    });
  });
}
