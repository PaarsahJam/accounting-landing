import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/cost_layer.dart';
import '../domain/inventory_valuation.dart';
import '../domain/product.dart';
import '../domain/product_category.dart';
import '../domain/stock_adjustment.dart';
import '../domain/stock_ledger_entry.dart';
import '../domain/stock_movement.dart';
import '../domain/stock_movement_type.dart';
import '../domain/stock_record.dart';
import '../domain/stock_transfer.dart';
import '../domain/unit_of_measure.dart';
import '../domain/warehouse.dart';

abstract class InventoryRepository {
  // ---- Products ----
  Future<AppResult<List<Product>>> fetchProducts();
  Future<AppResult<Product>> createProduct(Product product);
  Future<AppResult<Product>> updateProduct(Product product);
  Future<AppResult<void>> deleteProduct(String id);

  // ---- Reference data ----
  Future<AppResult<List<ProductCategory>>> fetchCategories();
  Future<AppResult<List<UnitOfMeasure>>> fetchUnits();
  Future<AppResult<List<Warehouse>>> fetchWarehouses();

  // ---- Stock ----
  Future<AppResult<List<StockRecord>>> fetchStockRecords(String productId);
  Future<AppResult<List<StockMovement>>> fetchStockMovements(String productId);

  // ---- Stock Ledger ----
  Future<AppResult<List<StockLedgerEntry>>> fetchLedger({
    required String productId,
    String? warehouseId,
  });

  // ---- Adjustments ----
  Future<AppResult<List<StockAdjustment>>> fetchAdjustments({
    String? productId,
    String? warehouseId,
  });
  Future<AppResult<StockAdjustment>> createAdjustment(
    StockAdjustment adjustment,
  );

  // ---- Transfers ----
  Future<AppResult<List<StockTransfer>>> fetchTransfers({
    String? productId,
    String? warehouseId,
  });
  Future<AppResult<StockTransfer>> createTransfer(StockTransfer transfer);

  // ---- Valuation ----
  Future<AppResult<List<InventoryValuation>>> fetchValuation();
  Future<AppResult<List<CostLayer>>> fetchCostLayers(String productId);
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
    const Product(
      id: 'P-1003',
      sku: 'SKU-1003',
      name: 'USB-C Hub',
      description: '7-port USB-C hub',
      categoryId: 'CAT-002',
      unitId: 'UOM-001',
      price: 69,
      stockOnHand: 18,
      active: true,
    ),
    const Product(
      id: 'P-1004',
      sku: 'SKU-1004',
      name: 'Printer Paper A4',
      description: 'Box of 500 sheets',
      categoryId: 'CAT-001',
      unitId: 'UOM-002',
      price: 12,
      stockOnHand: 40,
      active: true,
    ),
    const Product(
      id: 'P-1005',
      sku: 'SKU-1005',
      name: 'Desk Lamp',
      description: 'LED adjustable desk lamp',
      categoryId: 'CAT-001',
      unitId: 'UOM-001',
      price: 35,
      stockOnHand: 0,
      active: false,
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
    ProductCategory(
      id: 'CAT-003',
      name: 'Furniture',
      description: 'Office furniture',
    ),
  ];

  final List<UnitOfMeasure> _units = const [
    UnitOfMeasure(id: 'UOM-001', code: 'EA', name: 'Each'),
    UnitOfMeasure(id: 'UOM-002', code: 'PK', name: 'Pack'),
    UnitOfMeasure(id: 'UOM-003', code: 'KG', name: 'Kilogram'),
    UnitOfMeasure(id: 'UOM-004', code: 'M', name: 'Metre'),
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
    Warehouse(
      id: 'WH-003',
      code: 'STORE',
      name: 'Retail Storeroom',
      location: 'Ground Floor',
      active: true,
    ),
  ];

  final List<StockMovement> _movements = [
    StockMovement(
      id: 'SM-001',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Receipt',
      quantity: 15,
      description: 'Initial purchase receipt',
      occurredAt: DateTime(2024, 1, 4),
    ),
    StockMovement(
      id: 'SM-002',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Issue',
      quantity: 3,
      description: 'Issued to sales order SO-001',
      occurredAt: DateTime(2024, 1, 10),
    ),
    StockMovement(
      id: 'SM-003',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Adjustment',
      quantity: -2,
      description: 'Damaged items write-off',
      occurredAt: DateTime(2024, 2, 5),
    ),
    StockMovement(
      id: 'SM-004',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      type: 'Transfer',
      quantity: -2,
      description: 'Transfer to Retail Storeroom',
      occurredAt: DateTime(2024, 3, 1),
    ),
    StockMovement(
      id: 'SM-005',
      productId: 'P-1002',
      warehouseId: 'WH-001',
      type: 'Receipt',
      quantity: 25,
      description: 'Purchase order PO-1002',
      occurredAt: DateTime(2024, 1, 15),
    ),
    StockMovement(
      id: 'SM-006',
      productId: 'P-1002',
      warehouseId: 'WH-001',
      type: 'Issue',
      quantity: 5,
      description: 'Issued to customer order',
      occurredAt: DateTime(2024, 2, 10),
    ),
    StockMovement(
      id: 'SM-007',
      productId: 'P-1003',
      warehouseId: 'WH-001',
      type: 'Receipt',
      quantity: 20,
      description: 'Purchase receipt GR-1003',
      occurredAt: DateTime(2024, 2, 1),
    ),
    StockMovement(
      id: 'SM-008',
      productId: 'P-1003',
      warehouseId: 'WH-001',
      type: 'Issue',
      quantity: 2,
      description: 'Issued to project',
      occurredAt: DateTime(2024, 2, 20),
    ),
    StockMovement(
      id: 'SM-009',
      productId: 'P-1004',
      warehouseId: 'WH-001',
      type: 'Receipt',
      quantity: 50,
      description: 'Bulk stationery order',
      occurredAt: DateTime(2024, 1, 8),
    ),
    StockMovement(
      id: 'SM-010',
      productId: 'P-1004',
      warehouseId: 'WH-001',
      type: 'Issue',
      quantity: 10,
      description: 'Office consumption',
      occurredAt: DateTime(2024, 3, 15),
    ),
  ];

  // ---- Ledger entries (derived from movements with running balance) ----
  late final List<StockLedgerEntry> _ledgerEntries = _buildLedger();

  List<StockLedgerEntry> _buildLedger() {
    final entries = <StockLedgerEntry>[];
    final runningBalances = <String, double>{};

    final sortedMovements = [..._movements]
      ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));

    for (final m in sortedMovements) {
      final key = '${m.productId}-${m.warehouseId}';
      final isInbound = m.type == 'Receipt' || m.type == 'Opening';
      final signed = isInbound ? m.quantity : -m.quantity.abs();
      final before = runningBalances[key] ?? 0;
      final after = before + signed;
      runningBalances[key] = after;

      entries.add(
        StockLedgerEntry(
          id: 'LE-${m.id}',
          productId: m.productId,
          warehouseId: m.warehouseId,
          date: m.occurredAt,
          movementType: _mapType(m.type),
          quantity: signed,
          runningBalance: after,
          unitCost: _unitCost(m.productId),
          reference: m.id,
          description: m.description,
          createdAt: m.occurredAt,
        ),
      );
    }
    return entries;
  }

  StockMovementType _mapType(String type) {
    switch (type.toLowerCase()) {
      case 'receipt':
        return StockMovementType.receipt;
      case 'issue':
        return StockMovementType.issue;
      case 'adjustment':
        return StockMovementType.adjustment;
      case 'transfer':
        return StockMovementType.transfer;
      case 'opening':
        return StockMovementType.opening;
      default:
        return StockMovementType.receipt;
    }
  }

  double _unitCost(String productId) {
    final p = _products.where((p) => p.id == productId).firstOrNull;
    return p?.price ?? 0;
  }

  // ---- Adjustments ----
  final List<StockAdjustment> _adjustments = [
    StockAdjustment(
      id: 'ADJ-001',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      adjustmentDate: DateTime(2024, 2, 5),
      quantityBefore: 15,
      quantityAdjusted: -2,
      reason: 'Damaged during storage',
      reference: 'ADJ-2024-001',
      createdAt: DateTime(2024, 2, 5),
      createdBy: 'admin',
    ),
    StockAdjustment(
      id: 'ADJ-002',
      productId: 'P-1002',
      warehouseId: 'WH-001',
      adjustmentDate: DateTime(2024, 3, 10),
      quantityBefore: 20,
      quantityAdjusted: 3,
      reason: 'Found extra units during stocktake',
      reference: 'ADJ-2024-002',
      createdAt: DateTime(2024, 3, 10),
      createdBy: 'warehouse_manager',
    ),
    StockAdjustment(
      id: 'ADJ-003',
      productId: 'P-1004',
      warehouseId: 'WH-001',
      adjustmentDate: DateTime(2024, 3, 20),
      quantityBefore: 40,
      quantityAdjusted: -5,
      reason: 'Annual stocktake variance',
      reference: 'ADJ-2024-003',
      createdAt: DateTime(2024, 3, 20),
      createdBy: 'admin',
    ),
  ];

  // ---- Transfers ----
  final List<StockTransfer> _transfers = [
    StockTransfer(
      id: 'TRF-001',
      productId: 'P-1001',
      fromWarehouseId: 'WH-001',
      toWarehouseId: 'WH-003',
      quantity: 2,
      transferDate: DateTime(2024, 3, 1),
      reference: 'TRF-2024-001',
      notes: 'Transfer to Retail Storeroom for display',
      createdAt: DateTime(2024, 3, 1),
      createdBy: 'warehouse_manager',
    ),
    StockTransfer(
      id: 'TRF-002',
      productId: 'P-1002',
      fromWarehouseId: 'WH-001',
      toWarehouseId: 'WH-002',
      quantity: 5,
      transferDate: DateTime(2024, 2, 15),
      reference: 'TRF-2024-002',
      notes: 'Customer return processing',
      createdAt: DateTime(2024, 2, 15),
      createdBy: 'admin',
    ),
  ];

  // ---- Cost layers ----
  late final List<CostLayer> _costLayers = [
    CostLayer(
      id: 'CL-001',
      productId: 'P-1001',
      warehouseId: 'WH-001',
      receivedAt: DateTime(2024, 1, 4),
      quantity: 15,
      unitCost: 82.00,
      remainingQuantity: 10,
      reference: 'PO-1001',
    ),
    CostLayer(
      id: 'CL-002',
      productId: 'P-1002',
      warehouseId: 'WH-001',
      receivedAt: DateTime(2024, 1, 15),
      quantity: 25,
      unitCost: 44.00,
      remainingQuantity: 20,
      reference: 'PO-1002',
    ),
    CostLayer(
      id: 'CL-003',
      productId: 'P-1003',
      warehouseId: 'WH-001',
      receivedAt: DateTime(2024, 2, 1),
      quantity: 20,
      unitCost: 65.00,
      remainingQuantity: 18,
      reference: 'PO-1003',
    ),
    CostLayer(
      id: 'CL-004',
      productId: 'P-1004',
      warehouseId: 'WH-001',
      receivedAt: DateTime(2024, 1, 8),
      quantity: 50,
      unitCost: 11.50,
      remainingQuantity: 40,
      reference: 'PO-1004',
    ),
  ];

  // ============================== PRODUCTS ==============================
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

  // ============================== REFERENCE DATA ==============================
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

  // ============================== STOCK ==============================
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

  // ============================== LEDGER ==============================
  @override
  Future<AppResult<List<StockLedgerEntry>>> fetchLedger({
    required String productId,
    String? warehouseId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    var entries = _ledgerEntries.where((e) => e.productId == productId);
    if (warehouseId != null) {
      entries = entries.where((e) => e.warehouseId == warehouseId);
    }
    final sorted = entries.toList()..sort((a, b) => a.date.compareTo(b.date));
    return AppResult.success(List.unmodifiable(sorted));
  }

  // ============================== ADJUSTMENTS ==============================
  @override
  Future<AppResult<List<StockAdjustment>>> fetchAdjustments({
    String? productId,
    String? warehouseId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    var items = _adjustments.where((_) => true);
    if (productId != null) {
      items = items.where((a) => a.productId == productId);
    }
    if (warehouseId != null) {
      items = items.where((a) => a.warehouseId == warehouseId);
    }
    return AppResult.success(List.unmodifiable(items.toList()));
  }

  @override
  Future<AppResult<StockAdjustment>> createAdjustment(
    StockAdjustment adjustment,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _adjustments.add(adjustment);
    // Update StockRecord
    final recIdx = _stockRecords.indexWhere(
      (r) =>
          r.productId == adjustment.productId &&
          r.warehouseId == adjustment.warehouseId,
    );
    if (recIdx >= 0) {
      final rec = _stockRecords[recIdx];
      _stockRecords[recIdx] = StockRecord(
        productId: rec.productId,
        warehouseId: rec.warehouseId,
        quantity: rec.quantity + adjustment.quantityAdjusted,
        location: rec.location,
      );
    }
    return AppResult.success(adjustment);
  }

  // ============================== TRANSFERS ==============================
  @override
  Future<AppResult<List<StockTransfer>>> fetchTransfers({
    String? productId,
    String? warehouseId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    var items = _transfers.where((_) => true);
    if (productId != null) {
      items = items.where((t) => t.productId == productId);
    }
    if (warehouseId != null) {
      items = items.where(
        (t) =>
            t.fromWarehouseId == warehouseId || t.toWarehouseId == warehouseId,
      );
    }
    return AppResult.success(List.unmodifiable(items.toList()));
  }

  @override
  Future<AppResult<StockTransfer>> createTransfer(
    StockTransfer transfer,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    // Validate source stock
    final fromRec = _stockRecords
        .where(
          (r) =>
              r.productId == transfer.productId &&
              r.warehouseId == transfer.fromWarehouseId,
        )
        .firstOrNull;
    if (fromRec == null || fromRec.quantity < transfer.quantity) {
      return AppResult.failure(
        const UnknownFailure(message: 'Insufficient stock in source warehouse'),
      );
    }
    _transfers.add(transfer);
    // Deduct from source
    final fromIdx = _stockRecords.indexOf(fromRec);
    _stockRecords[fromIdx] = StockRecord(
      productId: fromRec.productId,
      warehouseId: fromRec.warehouseId,
      quantity: fromRec.quantity - transfer.quantity,
      location: fromRec.location,
    );
    // Add to destination
    final toIdx = _stockRecords.indexWhere(
      (r) =>
          r.productId == transfer.productId &&
          r.warehouseId == transfer.toWarehouseId,
    );
    if (toIdx >= 0) {
      final toRec = _stockRecords[toIdx];
      _stockRecords[toIdx] = StockRecord(
        productId: toRec.productId,
        warehouseId: toRec.warehouseId,
        quantity: toRec.quantity + transfer.quantity,
        location: toRec.location,
      );
    } else {
      _stockRecords.add(
        StockRecord(
          productId: transfer.productId,
          warehouseId: transfer.toWarehouseId,
          quantity: transfer.quantity,
          location: '',
        ),
      );
    }
    return AppResult.success(transfer);
  }

  // ============================== VALUATION ==============================
  @override
  Future<AppResult<List<InventoryValuation>>> fetchValuation() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final valuations = <InventoryValuation>[];
    final now = DateTime.now();

    for (final layer in _costLayers) {
      final product = _products
          .where((p) => p.id == layer.productId)
          .firstOrNull;
      final warehouse = _warehouses
          .where((w) => w.id == layer.warehouseId)
          .firstOrNull;
      if (product == null || warehouse == null) continue;

      valuations.add(
        InventoryValuation(
          productId: layer.productId,
          productName: product.name,
          sku: product.sku,
          warehouseId: layer.warehouseId,
          warehouseName: warehouse.name,
          quantityOnHand: layer.remainingQuantity,
          averageUnitCost: layer.unitCost,
          totalValue: layer.totalCost,
          valuationDate: now,
        ),
      );
    }
    return AppResult.success(valuations);
  }

  @override
  Future<AppResult<List<CostLayer>>> fetchCostLayers(String productId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final layers = _costLayers
        .where((cl) => cl.productId == productId)
        .toList();
    return AppResult.success(List.unmodifiable(layers));
  }

  // ---- mutable stock records list for mutation ops above ----
  final List<StockRecord> _stockRecords = [
    const StockRecord(
      productId: 'P-1001',
      warehouseId: 'WH-001',
      quantity: 10,
      location: 'A1-01',
    ),
    const StockRecord(
      productId: 'P-1001',
      warehouseId: 'WH-003',
      quantity: 2,
      location: 'S1-01',
    ),
    const StockRecord(
      productId: 'P-1002',
      warehouseId: 'WH-001',
      quantity: 20,
      location: 'A1-02',
    ),
    const StockRecord(
      productId: 'P-1002',
      warehouseId: 'WH-002',
      quantity: 5,
      location: 'B2-01',
    ),
    const StockRecord(
      productId: 'P-1003',
      warehouseId: 'WH-001',
      quantity: 18,
      location: 'A2-01',
    ),
    const StockRecord(
      productId: 'P-1004',
      warehouseId: 'WH-001',
      quantity: 40,
      location: 'C1-01',
    ),
  ];
}
