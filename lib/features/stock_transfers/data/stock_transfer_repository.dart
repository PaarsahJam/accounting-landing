import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../../../features/inventory/data/inventory_repository.dart';
import '../../../features/inventory/domain/stock_transfer.dart';
import '../domain/create_transfer_request.dart';
import '../domain/stock_transfer_record.dart';
import '../domain/stock_transfer_status.dart';

abstract class StockTransferRepository {
  Future<AppResult<List<StockTransferRecord>>> fetchTransfers();

  Future<AppResult<StockTransferRecord>> createTransfer(
    CreateTransferRequest request,
  );

  Future<AppResult<StockTransferRecord>> completeTransfer(String id);

  Future<AppResult<StockTransferRecord>> cancelTransfer(String id);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockStockTransferRepository implements StockTransferRepository {
  MockStockTransferRepository({
    InventoryRepository? inventoryRepository,
    AuditTrailRepository? auditTrailRepository,
  }) : _inventory = inventoryRepository ?? MockInventoryRepository(),
       _audit = auditTrailRepository ?? MockAuditTrailRepository();

  final InventoryRepository _inventory;
  final AuditTrailRepository _audit;

  int _seq = 10;

  String _nextId() =>
      'TRF-${DateTime.now().year}-${(_seq++).toString().padLeft(3, '0')}';

  /// Seed: pull the two seeded transfers from the inventory mock.
  Future<List<StockTransferRecord>> _loadSeed() async {
    if (_seeded) return _records;
    _seeded = true;
    final result = await _inventory.fetchTransfers();
    if (!result.isSuccess) return _records;

    final products = (await _inventory.fetchProducts()).data ?? [];
    final warehouses = (await _inventory.fetchWarehouses()).data ?? [];

    for (final t in result.data ?? <StockTransfer>[]) {
      final product = products.where((p) => p.id == t.productId).firstOrNull;
      final fromWh = warehouses
          .where((w) => w.id == t.fromWarehouseId)
          .firstOrNull;
      final toWh = warehouses.where((w) => w.id == t.toWarehouseId).firstOrNull;
      if (product == null || fromWh == null || toWh == null) continue;

      _records.add(
        StockTransferRecord(
          id: t.id,
          reference: t.reference,
          productId: t.productId,
          productName: product.name,
          fromWarehouseId: t.fromWarehouseId,
          fromWarehouseName: fromWh.name,
          toWarehouseId: t.toWarehouseId,
          toWarehouseName: toWh.name,
          quantity: t.quantity,
          transferDate: t.transferDate,
          status: StockTransferStatus.completed,
          createdAt: t.createdAt,
          createdBy: t.createdBy,
          notes: t.notes,
        ),
      );
    }
    return _records;
  }

  bool _seeded = false;
  final List<StockTransferRecord> _records = [];

  @override
  Future<AppResult<List<StockTransferRecord>>> fetchTransfers() async {
    await _loadSeed();
    return AppResult.success(List.unmodifiable(_records));
  }

  @override
  Future<AppResult<StockTransferRecord>> createTransfer(
    CreateTransferRequest request,
  ) async {
    // Validate: source != destination
    if (request.fromWarehouseId == request.toWarehouseId) {
      return AppResult.failure(
        const ValidationFailure(
          message: 'Source and destination warehouse must be different',
        ),
      );
    }

    // Validate: quantity > 0
    if (request.quantity <= 0) {
      return AppResult.failure(
        const ValidationFailure(message: 'Quantity must be greater than zero'),
      );
    }

    // Look up names
    final products = (await _inventory.fetchProducts()).data ?? [];
    final warehouses = (await _inventory.fetchWarehouses()).data ?? [];
    final product = products
        .where((p) => p.id == request.productId)
        .firstOrNull;
    final fromWh = warehouses
        .where((w) => w.id == request.fromWarehouseId)
        .firstOrNull;
    final toWh = warehouses
        .where((w) => w.id == request.toWarehouseId)
        .firstOrNull;

    if (product == null) {
      return AppResult.failure(
        const ValidationFailure(message: 'Product not found'),
      );
    }
    if (fromWh == null || toWh == null) {
      return AppResult.failure(
        const ValidationFailure(message: 'Warehouse not found'),
      );
    }

    // Check available stock via stock records
    final stockRecords =
        (await _inventory.fetchStockRecords(request.productId)).data ?? [];
    final fromRecord = stockRecords
        .where((r) => r.warehouseId == request.fromWarehouseId)
        .firstOrNull;
    final availableQty = fromRecord?.quantity ?? 0;
    if (request.quantity > availableQty) {
      return AppResult.failure(
        ValidationFailure(
          message:
              'Quantity ${request.quantity} exceeds available stock $availableQty',
        ),
      );
    }

    final id = _nextId();
    final ref = id;
    final now = DateTime.now();

    // Delegate stock mutation to inventory repository
    final coreTransfer = StockTransfer(
      id: id,
      productId: request.productId,
      fromWarehouseId: request.fromWarehouseId,
      toWarehouseId: request.toWarehouseId,
      quantity: request.quantity,
      transferDate: request.transferDate,
      reference: ref,
      notes: request.notes,
      createdAt: now,
      createdBy: request.createdBy,
    );
    final transferResult = await _inventory.createTransfer(coreTransfer);
    if (!transferResult.isSuccess) {
      return AppResult.failure(
        transferResult.error ??
            const UnknownFailure(message: 'Transfer failed'),
      );
    }

    final record = StockTransferRecord(
      id: id,
      reference: ref,
      productId: request.productId,
      productName: product.name,
      fromWarehouseId: request.fromWarehouseId,
      fromWarehouseName: fromWh.name,
      toWarehouseId: request.toWarehouseId,
      toWarehouseName: toWh.name,
      quantity: request.quantity,
      transferDate: request.transferDate,
      status: StockTransferStatus.completed,
      createdAt: now,
      createdBy: request.createdBy,
      notes: request.notes,
    );

    await _loadSeed();
    _records.insert(0, record);

    // Audit trail
    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TRF-$id',
        entityType: AuditEntityType.inventory,
        entityId: id,
        entityLabel: 'Stock Transfer $ref',
        action: AuditAction.stockTransferred,
        performedAt: now,
        performedBy: request.createdBy,
        note:
            'Transferred ${request.quantity} × ${product.name} from ${fromWh.name} to ${toWh.name}',
      ),
    );

    return AppResult.success(record);
  }

  @override
  Future<AppResult<StockTransferRecord>> completeTransfer(String id) async {
    await _loadSeed();
    final idx = _records.indexWhere((r) => r.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Transfer not found'),
      );
    }
    final existing = _records[idx];
    if (existing.status == StockTransferStatus.completed) {
      return AppResult.failure(
        const ValidationFailure(message: 'Transfer is already completed'),
      );
    }
    if (existing.status == StockTransferStatus.cancelled) {
      return AppResult.failure(
        const ValidationFailure(
          message: 'Cannot complete a cancelled transfer',
        ),
      );
    }
    final updated = existing.copyWith(status: StockTransferStatus.completed);
    _records[idx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<StockTransferRecord>> cancelTransfer(String id) async {
    await _loadSeed();
    final idx = _records.indexWhere((r) => r.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Transfer not found'),
      );
    }
    final existing = _records[idx];
    if (existing.status == StockTransferStatus.completed) {
      return AppResult.failure(
        const ValidationFailure(message: 'Cannot cancel a completed transfer'),
      );
    }
    final updated = existing.copyWith(status: StockTransferStatus.cancelled);
    _records[idx] = updated;
    return AppResult.success(updated);
  }
}
