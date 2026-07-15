import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockInventoryRepository', () {
    test('fetches categories and units', () async {
      final repository = MockInventoryRepository();

      final categories = await repository.fetchCategories();
      final units = await repository.fetchUnits();

      expect(categories.isSuccess, isTrue);
      expect(units.isSuccess, isTrue);
      expect(categories.data, isNotEmpty);
      expect(units.data, isNotEmpty);
    });

    test('fetches warehouses and stock movements', () async {
      final repository = MockInventoryRepository();

      final warehouses = await repository.fetchWarehouses();
      final movements = await repository.fetchStockMovements('P-1001');

      expect(warehouses.isSuccess, isTrue);
      expect(warehouses.data, isNotEmpty);
      expect(movements.isSuccess, isTrue);
      expect(movements.data, isNotEmpty);
    });
  });
}
