import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../purchase_orders/domain/goods_receipt.dart';
import '../../purchase_orders/domain/goods_receipt_line.dart';
import '../../purchase_orders/domain/goods_receipt_status.dart';
import '../domain/vendor_bill.dart';
import '../domain/vendor_bill_line.dart';
import '../domain/vendor_bill_status.dart';

abstract class VendorBillsRepository {
  Future<AppResult<List<VendorBill>>> fetchVendorBills();
  Future<AppResult<VendorBill>> createVendorBill(VendorBill bill);
  Future<AppResult<VendorBill>> updateVendorBill(VendorBill bill);
  Future<AppResult<void>> deleteVendorBill(String id);
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts();
}

class MockVendorBillsRepository implements VendorBillsRepository {
  MockVendorBillsRepository();

  final List<VendorBillStatus> _statuses = const [
    VendorBillStatus(id: 'draft', label: 'Draft', color: 'grey'),
    VendorBillStatus(id: 'pending', label: 'Pending', color: 'amber'),
    VendorBillStatus(id: 'paid', label: 'Paid', color: 'green'),
  ];

  final List<VendorBill> _bills = [
    VendorBill(
      id: 'VB-1001',
      vendorId: 'V-1001',
      purchaseOrderId: 'PO-1001',
      goodsReceiptId: 'GR-1001',
      reference: 'VB-1001',
      title: 'Office Supplies Bill',
      notes: 'Linked to initial delivery',
      billDate: DateTime(2024, 1, 10),
      dueDate: DateTime(2024, 1, 25),
      status: const VendorBillStatus(
        id: 'pending',
        label: 'Pending',
        color: 'amber',
      ),
      lines: const [
        VendorBillLine(
          id: 'VBL-1',
          description: 'Printer paper',
          quantity: 10,
          unitPrice: 24,
        ),
      ],
    ),
  ];

  final List<GoodsReceipt> _goodsReceipts = [
    GoodsReceipt(
      id: 'GR-1001',
      purchaseOrderId: 'PO-1001',
      reference: 'GR-1001',
      title: 'Initial delivery',
      receivedAt: DateTime(2024, 1, 10),
      status: const GoodsReceiptStatus(
        id: 'completed',
        label: 'Completed',
        color: 'green',
      ),
      lines: const [
        GoodsReceiptLine(
          purchaseOrderLineId: 'POL-1',
          description: 'Printer paper',
          orderedQuantity: 10,
          receivedQuantity: 10,
        ),
      ],
    ),
  ];

  @override
  Future<AppResult<List<VendorBill>>> fetchVendorBills() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_bills));
  }

  @override
  Future<AppResult<VendorBill>> createVendorBill(VendorBill bill) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _bills.add(bill);
    return AppResult.success(bill);
  }

  @override
  Future<AppResult<VendorBill>> updateVendorBill(VendorBill bill) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _bills.indexWhere((item) => item.id == bill.id);
    if (index >= 0) {
      _bills[index] = bill;
      return AppResult.success(bill);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Vendor bill not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteVendorBill(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _bills.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _bills.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Vendor bill not found'),
    );
  }

  @override
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_goodsReceipts));
  }

  List<VendorBillStatus> get statuses => List.unmodifiable(_statuses);
}
