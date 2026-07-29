import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/vendor_bill_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../purchase_orders/domain/goods_receipt.dart';
import '../domain/vendor_bill.dart';
import '../domain/vendor_bill_line.dart';
import '../domain/vendor_bill_status.dart';
import 'vendor_bills_repository.dart';

/// Tenant-scoped Drift implementation of [VendorBillsRepository].
class DriftVendorBillsRepository implements VendorBillsRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final VendorBillDao _dao;

  DriftVendorBillsRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = VendorBillDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<VendorBill>>> fetchVendorBills() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllBills(companyId);
      final result = <VendorBill>[];
      for (final entry in entries) {
        final lines = await _dao.getLinesByBillId(entry.id, companyId);
        result.add(_toDomain(entry, lines));
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<VendorBill>> createVendorBill(VendorBill bill) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertBill(_toCompanion(bill, companyId));
      for (final line in bill.lines) {
        await _dao.insertLine(_toLineCompanion(line, bill.id, companyId));
      }
      return AppResult.success(bill);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<VendorBill>> updateVendorBill(VendorBill bill) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateBill(_toCompanion(bill, companyId), companyId);
      await _dao.deleteLinesByBillId(bill.id, companyId);
      for (final line in bill.lines) {
        await _dao.insertLine(_toLineCompanion(line, bill.id, companyId));
      }
      return AppResult.success(bill);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteVendorBill(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteLinesByBillId(id, companyId);
      await _dao.deleteBill(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts() async {
    return AppResult.success(const []);
  }

  Future<void> close() => _database.close();

  VendorBill _toDomain(
    VendorBillTableData entry,
    List<VendorBillLineTableData> lineEntries,
  ) {
    return VendorBill(
      id: entry.id,
      vendorId: entry.vendorId,
      purchaseOrderId: entry.purchaseOrderId,
      goodsReceiptId: entry.goodsReceiptId,
      reference: entry.reference,
      title: entry.title,
      notes: entry.notes,
      billDate: entry.billDate,
      dueDate: entry.dueDate,
      status: VendorBillStatus(
        id: entry.statusId,
        label: entry.statusLabel,
        color: entry.statusColor,
      ),
      lines: lineEntries
          .map((l) => VendorBillLine(
                id: l.id,
                description: l.description,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ))
          .toList(),
    );
  }

  VendorBillTableCompanion _toCompanion(
    VendorBill bill,
    String companyId,
  ) {
    return VendorBillTableCompanion.insert(
      id: bill.id,
      companyId: companyId,
      vendorId: bill.vendorId,
      purchaseOrderId: bill.purchaseOrderId,
      goodsReceiptId: bill.goodsReceiptId,
      reference: bill.reference,
      title: bill.title,
      notes: bill.notes,
      billDate: bill.billDate,
      dueDate: bill.dueDate,
      statusId: bill.status.id,
      statusLabel: bill.status.label,
      statusColor: bill.status.color,
    );
  }

  VendorBillLineTableCompanion _toLineCompanion(
    VendorBillLine line,
    String billId,
    String companyId,
  ) {
    return VendorBillLineTableCompanion.insert(
      id: line.id,
      companyId: companyId,
      billId: billId,
      description: line.description,
      quantity: line.quantity,
      unitPrice: line.unitPrice,
    );
  }
}
