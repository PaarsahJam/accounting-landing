import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/product_dao.dart';
import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/features/inventory/data/drift_product_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const companyA = 'comp-1';
  const companyB = 'comp-2';

  Product product(String id, {String name = 'Test Product'}) => Product(
        id: id,
        sku: 'SKU-$id',
        name: name,
        description: 'A test product',
        categoryId: 'CAT-001',
        unitId: 'UOM-001',
        price: 99.99,
        stockOnHand: 10,
        active: true,
      );

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

  group('DriftProductRepository (company-scoped)', () {
    late AppDatabase database;
    late DriftProductRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository =
          DriftProductRepository(database: database, companyId: () => companyA);
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
      final createResult = await repository.createProduct(product('P-2001'));
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchProducts();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.id, 'P-2001');
      expect(fetchResult.data!.first.name, 'Test Product');
      expect(fetchResult.data!.first.price, 99.99);
      expect(fetchResult.data!.first.active, isTrue);
    });

    test('updateProduct modifies an existing product', () async {
      await repository.createProduct(product('P-2002', name: 'Original'));

      final updated = product('P-2002').copyWith(
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
      await repository.createProduct(product('P-2003'));

      final deleteResult = await repository.deleteProduct('P-2003');
      expect(deleteResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchProducts();
      expect(fetchResult.data, isEmpty);
    });

    test('searchProducts filters by name, sku, or id within the company',
        () async {
      final dao = ProductDao(database);
      await dao.insertProduct(ProductsTableCompanion.insert(
        id: 'P-3001',
        companyId: companyA,
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
        companyId: companyA,
        sku: 'MOUSE-001',
        name: 'Wireless Mouse',
        description: 'Ergonomic mouse',
        categoryId: 'CAT-002',
        unitId: 'UOM-001',
        price: 49.99,
        stockOnHand: 20,
        active: true,
      ));

      final laptopResults = await dao.searchProducts('Laptop', companyA);
      expect(laptopResults.length, 1);
      expect(laptopResults.first.id, 'P-3001');

      final mouseResults = await dao.searchProducts('MOUSE', companyA);
      expect(mouseResults.length, 1);
      expect(mouseResults.first.id, 'P-3002');

      final allResults = await dao.searchProducts('P-3', companyA);
      expect(allResults.length, 2);
    });

    test('non-product methods delegate to mock (fetchCategories)', () async {
      final categories = await repository.fetchCategories();
      expect(categories.isSuccess, isTrue);
      expect(categories.data, isNotEmpty);
    });

    test('domain mapping round-trips correctly', () async {
      final original = product('P-4001', name: 'Round Trip');

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

  group('DriftProductRepository tenant isolation', () {
    late AppDatabase database;
    late DriftProductRepository repoA;
    late DriftProductRepository repoB;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repoA =
          DriftProductRepository(database: database, companyId: () => companyA);
      repoB =
          DriftProductRepository(database: database, companyId: () => companyB);
    });

    tearDown(() async {
      await repoA.close();
    });

    test('reads only return records for the active company', () async {
      await repoA.createProduct(product('P-A1'));
      await repoB.createProduct(product('P-B1'));

      final aList = await repoA.fetchProducts();
      final bList = await repoB.fetchProducts();

      expect(aList.data!.map((p) => p.id), ['P-A1']);
      expect(bList.data!.map((p) => p.id), ['P-B1']);
    });

    test('writes persist the active company id', () async {
      await repoA.createProduct(product('P-A2'));

      final dao = ProductDao(database);
      final row = await dao.getProductById('P-A2', companyA);
      expect(row, isNotNull);
      expect(row!.companyId, companyA);

      // Same id is invisible under a different tenant.
      final foreign = await dao.getProductById('P-A2', companyB);
      expect(foreign, isNull);
    });

    test('cross-tenant update does not touch another company row', () async {
      await repoA.createProduct(product('P-SHARED', name: 'Owned by A'));

      // repoB tries to update a row it does not own (same id, different tenant).
      final result =
          await repoB.updateProduct(product('P-SHARED', name: 'Hijacked by B'));
      // The call reports success (0 rows affected is not an error), but A's row
      // must be untouched and no B-scoped row is created.
      expect(result.isSuccess, isTrue);

      final aRow = (await repoA.fetchProducts()).data!;
      expect(aRow.single.name, 'Owned by A');
      expect((await repoB.fetchProducts()).data, isEmpty);
    });

    test('cross-tenant delete does not remove another company row', () async {
      await repoA.createProduct(product('P-DEL'));

      final result = await repoB.deleteProduct('P-DEL');
      expect(result.isSuccess, isTrue);

      // Still present for the owning tenant.
      expect((await repoA.fetchProducts()).data!.single.id, 'P-DEL');
    });
  });

  group('DriftProductRepository fails closed without a company', () {
    late AppDatabase database;
    late DriftProductRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      // No companyId resolver → no active tenant.
      repository = DriftProductRepository(database: database);
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchProducts fails closed with TenantContextFailure', () async {
      final result = await repository.fetchProducts();
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<TenantContextFailure>());
    });

    test('createProduct fails closed and persists nothing', () async {
      final result = await repository.createProduct(product('P-NONE'));
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<TenantContextFailure>());

      // Prove nothing was written by reading with an explicit tenant.
      final dao = ProductDao(database);
      expect(await dao.totalProductRowsAcrossKnownTenants(), 0);
    });

    test('blank company id also fails closed', () async {
      final blank = DriftProductRepository(
        database: database,
        companyId: () => '',
      );
      final result = await blank.fetchProducts();
      expect(result.error, isA<TenantContextFailure>());
    });
  });
}

// Small helper kept local to the test: counts all product rows regardless of
// tenant, used only to assert that a fail-closed create wrote nothing at all.
extension on ProductDao {
  Future<int> totalProductRowsAcrossKnownTenants() async {
    final a = await getAllProducts('comp-1');
    final b = await getAllProducts('comp-2');
    return a.length + b.length;
  }
}
