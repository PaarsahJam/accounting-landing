import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/product.dart';
import '../domain/product_category.dart';
import '../domain/stock_movement.dart';
import '../domain/stock_record.dart';
import '../domain/unit_of_measure.dart';
import '../domain/warehouse.dart';

abstract class InventoryRepository {
  Future<AppResult<List<Product>>> fetchProducts();
  Future<AppResult<Product>> createProduct(Product product);
  Future<AppResult<Product>> updateProduct(Product product);
  Future<AppResult<void>> deleteProduct(String id);
  Future<AppResult<List<ProductCategory>>> fetchCategories();
  Future<AppResult<List<UnitOfMeasure>>> fetchUnits();
  Future<AppResult<List<Warehouse>>> fetchWarehouses();
  Future<AppResult<List<StockRecord>>> fetchStockRecords(String productId);
  Future<AppResult<List<StockMovement>>> fetchStockMovements(String productId);
}

class MockInventoryRepository implements InventoryRepository {
  MockInventoryRepository();

  final List<Product> _products = [
    const Product(
      id: 'P-1001',
      sku: 'SKU-1001',
      name: 'Laptop Stand',
      description: 'Ergonomic aluminum stand',
      categoryId: 'CAT-001',
      unitId: 'UOM-001',
      price: 89,
      stockOnHand: 12,
      active: true,
    ),
    const Product(
      id: 'P-1002',
      sku: 'SKU-1002',
      name: 'Wireless Mouse',
      description: 'Compact wireless mouse',
      categoryId: 'CAT-002',
      unitId: 'UOM-001',
      price: 49,
      stockOnHand: 25,
      active: true,
    ),
  ];

  final List<ProductCategory> _categories = const [
    ProductCategory(
      id: 'CAT-001',
      name: 'Office',
      description: 'Office supplies',
    ),
    ProductCategory(
      id: 'CAT-002',
      name: 'Electronics',
      description: 'Electronic devices',
    ),
  ];

  final List<UnitOfMeasure> _units = const [
    UnitOfMeasure(id: 'UOM-001', code: 'EA', name: 'Each'),
    UnitOfMeasure(id: 'UOM-002', code: 'PK', name: 'Pack'),
  ];

  final List<Warehouse> _warehouses = const [
    Warehouse(
      id: 'WH-001',
      code: 'MAIN',
      name: 'Main Warehouse',
      location: 'North Wing',
      active: true,
    ),
    Warehouse(
      id: 'WH-002',
      code: 'RMA',
      name: 'Returns Warehouse',
      location: 'South Wing',
      active: true,
    ),
  ];

  final List<StockRecord> _stockRecords = const [
    StockRecord(
      productId: 'P-1001',
      warehouseId: 'WH-001',
      quantity: 12,
      location: 'North Wing',
    ),
    StockRecord(
      productId: 'P-1002',
      warehouseId: 'WH-002',
      quantity: 25,
      location: 'South Wing',
    ),
  ];

  final List<StockMovement> _movements = [
    StockMovement(
      id: 'SM-001',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Receipt',
      quantity: 12,
      description: 'Opening balance',
      occurredAt: DateTime(2024, 1, 4),
    ),
    StockMovement(
      id: 'SM-002',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Issue',
      quantity: 2,
      description: 'Issued to production',
      occurredAt: DateTime(2024, 1, 10),
    ),
  ];

  @override
  Future<AppResult<List<Product>>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_products));
  }

  @override
  Future<AppResult<Product>> createProduct(Product product) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _products.add(product);
    return AppResult.success(product);
  }

  @override
  Future<AppResult<Product>> updateProduct(Product product) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _products.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      return AppResult.success(product);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Product not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteProduct(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _products.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _products.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Product not found'),
    );
  }

  @override
  Future<AppResult<List<ProductCategory>>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return AppResult.success(List.unmodifiable(_categories));
  }

  @override
  Future<AppResult<List<UnitOfMeasure>>> fetchUnits() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return AppResult.success(List.unmodifiable(_units));
  }

  @override
  Future<AppResult<List<Warehouse>>> fetchWarehouses() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return AppResult.success(List.unmodifiable(_warehouses));
  }

  @override
  Future<AppResult<List<StockRecord>>> fetchStockRecords(
    String productId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final records = _stockRecords
        .where((record) => record.productId == productId)
        .toList();
    return AppResult.success(List.unmodifiable(records));
  }

  @override
  Future<AppResult<List<StockMovement>>> fetchStockMovements(
    String productId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final movements = _movements
        .where((movement) => movement.productId == productId)
        .toList();
    return AppResult.success(List.unmodifiable(movements));
  }
}
