import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/purchase_order_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/goods_receipt.dart';
import '../domain/purchase_order.dart';
import '../domain/purchase_order_line.dart';
import '../domain/purchase_order_status.dart';
import 'purchase_orders_repository.dart';

/// Tenant-scoped Drift implementation of [PurchaseOrdersRepository].
class DriftPurchaseOrdersRepository implements PurchaseOrdersRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final PurchaseOrderDao _dao;

  DriftPurchaseOrdersRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = PurchaseOrderDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<PurchaseOrder>>> fetchPurchaseOrders() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllOrders(companyId);
      final result = <PurchaseOrder>[];
      for (final entry in entries) {
        final lines = await _dao.getLinesByOrderId(entry.id, companyId);
        result.add(_toDomain(entry, lines));
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder order,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertOrder(_toCompanion(order, companyId));
      for (final line in order.lines) {
        await _dao.insertLine(_toLineCompanion(line, order.id, companyId));
      }
      return AppResult.success(order);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<PurchaseOrder>> updatePurchaseOrder(
    PurchaseOrder order,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateOrder(_toCompanion(order, companyId), companyId);
      await _dao.deleteLinesByOrderId(order.id, companyId);
      for (final line in order.lines) {
        await _dao.insertLine(_toLineCompanion(line, order.id, companyId));
      }
      return AppResult.success(order);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deletePurchaseOrder(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteLinesByOrderId(id, companyId);
      await _dao.deleteOrder(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts() async {
    return AppResult.success(const []);
  }

  @override
  Future<AppResult<GoodsReceipt>> createGoodsReceipt(
    GoodsReceipt receipt,
  ) async {
    return AppResult.success(receipt);
  }

  @override
  Future<AppResult<GoodsReceipt>> updateGoodsReceipt(
    GoodsReceipt receipt,
  ) async {
    return AppResult.success(receipt);
  }

  Future<void> close() => _database.close();

  PurchaseOrder _toDomain(
    PurchaseOrderTableData entry,
    List<PurchaseOrderLineTableData> lineEntries,
  ) {
    return PurchaseOrder(
      id: entry.id,
      vendorId: entry.vendorId,
      reference: entry.reference,
      title: entry.title,
      notes: entry.notes,
      orderDate: entry.orderDate,
      expectedDate: entry.expectedDate,
      status: PurchaseOrderStatus(
        id: entry.statusId,
        label: entry.statusLabel,
        color: entry.statusColor,
      ),
      lines: lineEntries
          .map((l) => PurchaseOrderLine(
                id: l.id,
                description: l.description,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ))
          .toList(),
    );
  }

  PurchaseOrderTableCompanion _toCompanion(
    PurchaseOrder order,
    String companyId,
  ) {
    return PurchaseOrderTableCompanion.insert(
      id: order.id,
      companyId: companyId,
      vendorId: order.vendorId,
      reference: order.reference,
      title: order.title,
      notes: order.notes,
      orderDate: order.orderDate,
      expectedDate: order.expectedDate,
      statusId: order.status.id,
      statusLabel: order.status.label,
      statusColor: order.status.color,
    );
  }

  PurchaseOrderLineTableCompanion _toLineCompanion(
    PurchaseOrderLine line,
    String orderId,
    String companyId,
  ) {
    return PurchaseOrderLineTableCompanion.insert(
      id: line.id,
      companyId: companyId,
      purchaseOrderId: orderId,
      description: line.description,
      quantity: line.quantity,
      unitPrice: line.unitPrice,
    );
  }
}
