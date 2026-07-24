import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/product_dao.dart';
import 'package:accounting_app/features/inventory/data/drift_product_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:drift/native.dart';
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

  group('DriftProductRepository', () {
    late AppDatabase database;
    late DriftProductRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository = DriftProductRepository(database: database);
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchProducts returns empty list when no products exist', () async {
      final result = await repository.fetchProducts();

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('createProduct inserts and returns the product', () async {
      final product = Product(
        id: 'P-2001',
        sku: 'SKU-2001',
        name: 'Test Product',
        description: 'A test product',
        categoryId: 'CAT-001',
        unitId: 'UOM-001',
        price: 99.99,
        stockOnHand: 10,
        active: true,
      );

      final createResult = await repository.createProduct(product);
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchProducts();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.id, 'P-2001');
      expect(fetchResult.data!.first.name, 'Test Product');
      expect(fetchResult.data!.first.price, 99.99);
      expect(fetchResult.data!.first.active, isTrue);
    });

    test('updateProduct modifies an existing product', () async {
      final product = Product(
        id: 'P-2002',
        sku: 'SKU-2002',
        name: 'Original',
        description: 'Original description',
        categoryId: 'CAT-001',
        unitId: 'UOM-001',
        price: 50.0,
        stockOnHand: 5,
        active: true,
      );
      await repository.createProduct(product);

      final updated = product.copyWith(
        name: 'Updated',
        price: 45.0,
        active: false,
      );
      final updateResult = await repository.updateProduct(updated);
      expect(updateResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchProducts();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.name, 'Updated');
      expect(fetchResult.data!.first.price, 45.0);
      expect(fetchResult.data!.first.active, isFalse);
    });

    test('deleteProduct removes a product', () async {
      final product = Product(
        id: 'P-2003',
        sku: 'SKU-2003',
        name: 'Delete Me',
        description: '',
        categoryId: 'CAT-001',
        unitId: 'UOM-001',
        price: 10.0,
        stockOnHand: 0,
        active: true,
      );
      await repository.createProduct(product);

      final deleteResult = await repository.deleteProduct('P-2003');
      expect(deleteResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchProducts();
      expect(fetchResult.data, isEmpty);
    });

    test('searchProducts filters by name, sku, or id', () async {
      final dao = ProductDao(database);
      await dao.insertProduct(ProductsTableCompanion.insert(
        id: 'P-3001',
        sku: 'LAPTOP-001',
        name: 'Gaming Laptop',
        description: 'High-end gaming laptop',
        categoryId: 'CAT-002',
        unitId: 'UOM-001',
        price: 1499.99,
        stockOnHand: 5,
        active: true,
      ));
      await dao.insertProduct(ProductsTableCompanion.insert(
        id: 'P-3002',
        sku: 'MOUSE-001',
        name: 'Wireless Mouse',
        description: 'Ergonomic mouse',
        categoryId: 'CAT-002',
        unitId: 'UOM-001',
        price: 49.99,
        stockOnHand: 20,
        active: true,
      ));

      final laptopResults = await dao.searchProducts('Laptop');
      expect(laptopResults.length, 1);
      expect(laptopResults.first.id, 'P-3001');

      final mouseResults = await dao.searchProducts('MOUSE');
      expect(mouseResults.length, 1);
      expect(mouseResults.first.id, 'P-3002');

      final allResults = await dao.searchProducts('P-3');
      expect(allResults.length, 2);
    });

    test('non-product methods delegate to mock (fetchCategories)', () async {
      final categories = await repository.fetchCategories();
      expect(categories.isSuccess, isTrue);
      expect(categories.data, isNotEmpty);
    });

    test('domain mapping round-trips correctly', () async {
      final original = Product(
        id: 'P-4001',
        sku: 'SKU-4001',
        name: 'Round Trip',
        description: 'Round-trip test',
        categoryId: 'CAT-001',
        unitId: 'UOM-001',
        price: 25.0,
        stockOnHand: 100,
        active: true,
      );

      await repository.createProduct(original);
      final fetched = await repository.fetchProducts();
      final roundTripped = fetched.data!.first;

      expect(roundTripped.id, original.id);
      expect(roundTripped.sku, original.sku);
      expect(roundTripped.name, original.name);
      expect(roundTripped.description, original.description);
      expect(roundTripped.categoryId, original.categoryId);
      expect(roundTripped.unitId, original.unitId);
      expect(roundTripped.price, original.price);
      expect(roundTripped.stockOnHand, original.stockOnHand);
      expect(roundTripped.active, original.active);
    });
  });
}
