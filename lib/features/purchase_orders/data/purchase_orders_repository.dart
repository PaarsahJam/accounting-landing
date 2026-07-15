import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/goods_receipt.dart';
import '../domain/goods_receipt_line.dart';
import '../domain/goods_receipt_status.dart';
import '../domain/purchase_order.dart';
import '../domain/purchase_order_line.dart';
import '../domain/purchase_order_status.dart';

abstract class PurchaseOrdersRepository {
  Future<AppResult<List<PurchaseOrder>>> fetchPurchaseOrders();
  Future<AppResult<PurchaseOrder>> createPurchaseOrder(PurchaseOrder order);
  Future<AppResult<PurchaseOrder>> updatePurchaseOrder(PurchaseOrder order);
  Future<AppResult<void>> deletePurchaseOrder(String id);
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts();
  Future<AppResult<GoodsReceipt>> createGoodsReceipt(GoodsReceipt receipt);
  Future<AppResult<GoodsReceipt>> updateGoodsReceipt(GoodsReceipt receipt);
}

class MockPurchaseOrdersRepository implements PurchaseOrdersRepository {
  MockPurchaseOrdersRepository();

  final List<PurchaseOrderStatus> _statuses = const [
    PurchaseOrderStatus(id: 'draft', label: 'Draft', color: 'grey'),
    PurchaseOrderStatus(id: 'approved', label: 'Approved', color: 'green'),
    PurchaseOrderStatus(id: 'ordered', label: 'Ordered', color: 'blue'),
  ];

  final List<PurchaseOrder> _orders = [
    PurchaseOrder(
      id: 'PO-1001',
      vendorId: 'V-1001',
      reference: 'PO-1001',
      title: 'Office Supplies',
      notes: 'Quarterly supplies',
      orderDate: DateTime(2024, 1, 5),
      expectedDate: DateTime(2024, 1, 15),
      status: const PurchaseOrderStatus(
        id: 'approved',
        label: 'Approved',
        color: 'green',
      ),
      lines: const [
        PurchaseOrderLine(
          id: 'POL-1',
          description: 'Printer paper',
          quantity: 10,
          unitPrice: 24,
        ),
      ],
    ),
  ];

  final List<GoodsReceiptStatus> _receiptStatuses = const [
    GoodsReceiptStatus(id: 'draft', label: 'Draft', color: 'grey'),
    GoodsReceiptStatus(id: 'partial', label: 'Partial', color: 'amber'),
    GoodsReceiptStatus(id: 'completed', label: 'Completed', color: 'green'),
  ];

  final List<GoodsReceipt> _receipts = [
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
  Future<AppResult<List<PurchaseOrder>>> fetchPurchaseOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_orders));
  }

  @override
  Future<AppResult<PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder order,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _orders.add(order);
    return AppResult.success(order);
  }

  @override
  Future<AppResult<PurchaseOrder>> updatePurchaseOrder(
    PurchaseOrder order,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _orders.indexWhere((item) => item.id == order.id);
    if (index >= 0) {
      _orders[index] = order;
      return AppResult.success(order);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Purchase order not found'),
    );
  }

  @override
  Future<AppResult<void>> deletePurchaseOrder(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _orders.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _orders.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Purchase order not found'),
    );
  }

  @override
  Future<AppResult<List<GoodsReceipt>>> fetchGoodsReceipts() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_receipts));
  }

  @override
  Future<AppResult<GoodsReceipt>> createGoodsReceipt(
    GoodsReceipt receipt,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _receipts.add(receipt);
    return AppResult.success(receipt);
  }

  @override
  Future<AppResult<GoodsReceipt>> updateGoodsReceipt(
    GoodsReceipt receipt,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _receipts.indexWhere((item) => item.id == receipt.id);
    if (index >= 0) {
      _receipts[index] = receipt;
      return AppResult.success(receipt);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Goods receipt not found'),
    );
  }

  List<PurchaseOrderStatus> get statuses => List.unmodifiable(_statuses);
  List<GoodsReceiptStatus> get receiptStatuses =>
      List.unmodifiable(_receiptStatuses);
}
