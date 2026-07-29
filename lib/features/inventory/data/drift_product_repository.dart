import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/product_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/cost_layer.dart';
import '../domain/inventory_valuation.dart';
import '../domain/product.dart';
import '../domain/product_category.dart';
import '../domain/stock_adjustment.dart';
import '../domain/stock_ledger_entry.dart';
import '../domain/stock_movement.dart';
import '../domain/stock_record.dart';
import '../domain/stock_transfer.dart';
import '../domain/unit_of_measure.dart';
import '../domain/warehouse.dart';
import 'inventory_repository.dart';

/// Tenant-scoped Drift implementation of [InventoryRepository] for the product
/// catalogue. See [DriftCustomerRepository] for the resolver / fail-closed
/// contract.
///
/// NOTE: only the product-catalogue methods (fetch/create/update/delete
/// products) are persisted in Drift and therefore tenant-scoped here. The
/// remaining inventory methods still delegate to [MockInventoryRepository] and
/// are NOT yet tenant-aware — see [_mockDelegate].
class DriftProductRepository implements InventoryRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final ProductDao _dao;
  final InventoryRepository _mockDelegate = MockInventoryRepository();

  DriftProductRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = ProductDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<Product>>> fetchProducts() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllProducts(companyId);
      return AppResult.success(entries.map(_toDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Product>> createProduct(Product product) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertProduct(_toCompanion(product, companyId));
      return AppResult.success(product);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Product>> updateProduct(Product product) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateProduct(_toCompanion(product, companyId), companyId);
      return AppResult.success(product);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteProduct(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteProduct(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ProductCategory>>> fetchCategories() =>
      _mockDelegate.fetchCategories();

  @override
  Future<AppResult<List<UnitOfMeasure>>> fetchUnits() =>
      _mockDelegate.fetchUnits();

  @override
  Future<AppResult<List<Warehouse>>> fetchWarehouses() =>
      _mockDelegate.fetchWarehouses();

  @override
  Future<AppResult<List<StockRecord>>> fetchStockRecords(String productId) =>
      _mockDelegate.fetchStockRecords(productId);

  @override
  Future<AppResult<List<StockMovement>>> fetchStockMovements(
    String productId,
  ) => _mockDelegate.fetchStockMovements(productId);

  @override
  Future<AppResult<List<StockLedgerEntry>>> fetchLedger({
    required String productId,
    String? warehouseId,
  }) => _mockDelegate.fetchLedger(productId: productId, warehouseId: warehouseId);

  @override
  Future<AppResult<List<StockAdjustment>>> fetchAdjustments({
    String? productId,
    String? warehouseId,
  }) => _mockDelegate.fetchAdjustments(productId: productId, warehouseId: warehouseId);

  @override
  Future<AppResult<StockAdjustment>> createAdjustment(
    StockAdjustment adjustment,
  ) => _mockDelegate.createAdjustment(adjustment);

  @override
  Future<AppResult<List<StockTransfer>>> fetchTransfers({
    String? productId,
    String? warehouseId,
  }) => _mockDelegate.fetchTransfers(productId: productId, warehouseId: warehouseId);

  @override
  Future<AppResult<StockTransfer>> createTransfer(StockTransfer transfer) =>
      _mockDelegate.createTransfer(transfer);

  @override
  Future<AppResult<List<InventoryValuation>>> fetchValuation() =>
      _mockDelegate.fetchValuation();

  @override
  Future<AppResult<List<CostLayer>>> fetchCostLayers(String productId) =>
      _mockDelegate.fetchCostLayers(productId);

  Future<void> close() => _database.close();

  Product _toDomain(ProductsTableData entry) {
    return Product(
      id: entry.id,
      sku: entry.sku,
      name: entry.name,
      description: entry.description,
      categoryId: entry.categoryId,
      unitId: entry.unitId,
      price: entry.price,
      stockOnHand: entry.stockOnHand,
      active: entry.active,
    );
  }

  ProductsTableCompanion _toCompanion(Product product, String companyId) {
    return ProductsTableCompanion.insert(
      id: product.id,
      companyId: companyId,
      sku: product.sku,
      name: product.name,
      description: product.description,
      categoryId: product.categoryId,
      unitId: product.unitId,
      price: product.price,
      stockOnHand: product.stockOnHand,
      active: product.active,
    );
  }
}