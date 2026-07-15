import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customer_payments/data/customer_payments_repository.dart';
import '../../customer_payments/domain/customer_payment.dart';
import '../../purchase_orders/data/purchase_orders_repository.dart';
import '../../purchase_orders/domain/goods_receipt.dart';
import '../../purchase_orders/domain/purchase_order.dart';
import '../../purchase_orders/domain/purchase_order_line.dart';
import '../../sales_invoices/data/sales_invoices_repository.dart';
import '../../sales_invoices/domain/sales_invoice.dart';
import '../../vendor_bills/data/vendor_bills_repository.dart';
import '../../vendor_bills/domain/vendor_bill.dart';
import '../../vendor_payments/data/vendor_payments_repository.dart';
import '../../vendor_payments/domain/vendor_payment.dart';
import '../domain/journal_preview.dart';

abstract class JournalPreviewRepository {
  Future<AppResult<JournalPreview>> fetchJournalPreview(
    String documentType,
    String documentId,
  );
}

class MockJournalPreviewRepository implements JournalPreviewRepository {
  MockJournalPreviewRepository({
    PurchaseOrdersRepository? purchaseOrdersRepository,
    VendorBillsRepository? vendorBillsRepository,
    VendorPaymentsRepository? vendorPaymentsRepository,
    SalesInvoicesRepository? salesInvoicesRepository,
    CustomerPaymentsRepository? customerPaymentsRepository,
  }) : _purchaseOrdersRepository =
           purchaseOrdersRepository ?? MockPurchaseOrdersRepository(),
       _vendorBillsRepository =
           vendorBillsRepository ?? MockVendorBillsRepository(),
       _vendorPaymentsRepository =
           vendorPaymentsRepository ?? MockVendorPaymentsRepository(),
       _salesInvoicesRepository =
           salesInvoicesRepository ?? MockSalesInvoicesRepository(),
       _customerPaymentsRepository =
           customerPaymentsRepository ?? MockCustomerPaymentsRepository();

  final PurchaseOrdersRepository _purchaseOrdersRepository;
  final VendorBillsRepository _vendorBillsRepository;
  final VendorPaymentsRepository _vendorPaymentsRepository;
  final SalesInvoicesRepository _salesInvoicesRepository;
  final CustomerPaymentsRepository _customerPaymentsRepository;

  @override
  Future<AppResult<JournalPreview>> fetchJournalPreview(
    String documentType,
    String documentId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      switch (documentType) {
        case 'purchase_order':
          return _previewForPurchaseOrder(documentId);
        case 'goods_receipt':
          return _previewForGoodsReceipt(documentId);
        case 'vendor_bill':
          return _previewForVendorBill(documentId);
        case 'vendor_payment':
          return _previewForVendorPayment(documentId);
        case 'sales_invoice':
          return _previewForSalesInvoice(documentId);
        case 'customer_payment':
          return _previewForCustomerPayment(documentId);
        default:
          return AppResult.failure(
            const UnknownFailure(message: 'Unsupported document type'),
          );
      }
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<AppResult<JournalPreview>> _previewForPurchaseOrder(
    String documentId,
  ) async {
    final result = await _purchaseOrdersRepository.fetchPurchaseOrders();
    if (!result.isSuccess) {
      return AppResult.failure(
        result.error ??
            const UnknownFailure(message: 'Unable to load purchase orders'),
      );
    }

    final order = _findPurchaseOrder(
      result.data ?? const <PurchaseOrder>[],
      documentId,
    );
    if (order == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Purchase order not found'),
      );
    }

    final amount = order.lines.fold<double>(0.0, (sum, line) {
      return sum + (line.quantity * line.unitPrice);
    });

    return AppResult.success(
      JournalPreview(
        documentType: 'purchase_order',
        documentId: order.id,
        documentReference: order.reference,
        postingDate: order.orderDate,
        narration: 'Preview posting for purchase order ${order.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Inventory',
            accountCode: '1200',
            amount: amount,
            side: 'debit',
            description: 'Receipt of goods for ${order.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Accounts Payable',
            accountCode: '2000',
            amount: amount,
            side: 'credit',
            description: 'Liability from ${order.reference}',
          ),
        ],
      ),
    );
  }

  Future<AppResult<JournalPreview>> _previewForGoodsReceipt(
    String documentId,
  ) async {
    final receiptResult = await _purchaseOrdersRepository.fetchGoodsReceipts();
    final purchaseOrderResult = await _purchaseOrdersRepository
        .fetchPurchaseOrders();

    if (!receiptResult.isSuccess) {
      return AppResult.failure(
        receiptResult.error ??
            const UnknownFailure(message: 'Unable to load goods receipts'),
      );
    }
    if (!purchaseOrderResult.isSuccess) {
      return AppResult.failure(
        purchaseOrderResult.error ??
            const UnknownFailure(message: 'Unable to load purchase orders'),
      );
    }

    final receipt = _findGoodsReceipt(
      receiptResult.data ?? const <GoodsReceipt>[],
      documentId,
    );
    if (receipt == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Goods receipt not found'),
      );
    }

    final purchaseOrder = _findPurchaseOrder(
      purchaseOrderResult.data ?? const <PurchaseOrder>[],
      receipt.purchaseOrderId,
    );

    double amount = 0;
    for (final line in receipt.lines) {
      final orderLine = purchaseOrder?.lines.firstWhere(
        (item) => item.id == line.purchaseOrderLineId,
        orElse: () => const PurchaseOrderLine(
          id: '',
          description: '',
          quantity: 0,
          unitPrice: 0,
        ),
      );
      amount += line.receivedQuantity * orderLine!.unitPrice;
    }

    return AppResult.success(
      JournalPreview(
        documentType: 'goods_receipt',
        documentId: receipt.id,
        documentReference: receipt.reference,
        postingDate: receipt.receivedAt,
        narration: 'Preview posting for goods receipt ${receipt.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Inventory',
            accountCode: '1200',
            amount: amount,
            side: 'debit',
            description: 'Goods received for ${receipt.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Goods Received Clearing',
            accountCode: '2100',
            amount: amount,
            side: 'credit',
            description: 'Clearing for ${receipt.reference}',
          ),
        ],
      ),
    );
  }

  Future<AppResult<JournalPreview>> _previewForVendorBill(
    String documentId,
  ) async {
    final result = await _vendorBillsRepository.fetchVendorBills();
    if (!result.isSuccess) {
      return AppResult.failure(
        result.error ??
            const UnknownFailure(message: 'Unable to load vendor bills'),
      );
    }

    final bill = _findVendorBill(
      result.data ?? const <VendorBill>[],
      documentId,
    );
    if (bill == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Vendor bill not found'),
      );
    }

    final amount = bill.lines.fold<double>(0.0, (sum, line) {
      return sum + (line.quantity * line.unitPrice);
    });

    return AppResult.success(
      JournalPreview(
        documentType: 'vendor_bill',
        documentId: bill.id,
        documentReference: bill.reference,
        postingDate: bill.billDate,
        narration: 'Preview posting for vendor bill ${bill.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Expenses',
            accountCode: '5100',
            amount: amount,
            side: 'debit',
            description: 'Expense posting for ${bill.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Accounts Payable',
            accountCode: '2000',
            amount: amount,
            side: 'credit',
            description: 'Payable from ${bill.reference}',
          ),
        ],
      ),
    );
  }

  Future<AppResult<JournalPreview>> _previewForVendorPayment(
    String documentId,
  ) async {
    final result = await _vendorPaymentsRepository.fetchVendorPayments();
    if (!result.isSuccess) {
      return AppResult.failure(
        result.error ??
            const UnknownFailure(message: 'Unable to load vendor payments'),
      );
    }

    final payment = _findVendorPayment(
      result.data ?? const <VendorPayment>[],
      documentId,
    );
    if (payment == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Vendor payment not found'),
      );
    }

    return AppResult.success(
      JournalPreview(
        documentType: 'vendor_payment',
        documentId: payment.id,
        documentReference: payment.reference,
        postingDate: payment.paymentDate,
        narration: 'Preview posting for vendor payment ${payment.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Accounts Payable',
            accountCode: '2000',
            amount: payment.amount,
            side: 'debit',
            description: 'Settlement for ${payment.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Cash / Bank',
            accountCode: '1000',
            amount: payment.amount,
            side: 'credit',
            description: 'Payment from ${payment.reference}',
          ),
        ],
      ),
    );
  }

  Future<AppResult<JournalPreview>> _previewForSalesInvoice(
    String documentId,
  ) async {
    final result = await _salesInvoicesRepository.fetchSalesInvoices();
    if (!result.isSuccess) {
      return AppResult.failure(
        result.error ??
            const UnknownFailure(message: 'Unable to load sales invoices'),
      );
    }

    final invoice = _findSalesInvoice(
      result.data ?? const <SalesInvoice>[],
      documentId,
    );
    if (invoice == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Sales invoice not found'),
      );
    }

    return AppResult.success(
      JournalPreview(
        documentType: 'sales_invoice',
        documentId: invoice.id,
        documentReference: invoice.reference,
        postingDate: invoice.invoiceDate,
        narration: 'Preview posting for sales invoice ${invoice.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Accounts Receivable',
            accountCode: '1100',
            amount: invoice.total,
            side: 'debit',
            description: 'Invoice receivable for ${invoice.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Revenue',
            accountCode: '4000',
            amount: invoice.total,
            side: 'credit',
            description: 'Revenue recognition for ${invoice.reference}',
          ),
        ],
      ),
    );
  }

  Future<AppResult<JournalPreview>> _previewForCustomerPayment(
    String documentId,
  ) async {
    final result = await _customerPaymentsRepository.fetchCustomerPayments();
    if (!result.isSuccess) {
      return AppResult.failure(
        result.error ??
            const UnknownFailure(message: 'Unable to load customer payments'),
      );
    }

    final payment = _findCustomerPayment(
      result.data ?? const <CustomerPayment>[],
      documentId,
    );
    if (payment == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Customer payment not found'),
      );
    }

    return AppResult.success(
      JournalPreview(
        documentType: 'customer_payment',
        documentId: payment.id,
        documentReference: payment.reference,
        postingDate: payment.paymentDate,
        narration: 'Preview posting for customer payment ${payment.reference}',
        lines: [
          JournalPreviewLine(
            accountName: 'Cash / Bank',
            accountCode: '1000',
            amount: payment.amount,
            side: 'debit',
            description: 'Receipt for ${payment.reference}',
          ),
          JournalPreviewLine(
            accountName: 'Accounts Receivable',
            accountCode: '1100',
            amount: payment.amount,
            side: 'credit',
            description: 'Settlement for ${payment.reference}',
          ),
        ],
      ),
    );
  }

  PurchaseOrder? _findPurchaseOrder(List<PurchaseOrder> orders, String id) {
    for (final order in orders) {
      if (order.id == id) {
        return order;
      }
    }
    return null;
  }

  GoodsReceipt? _findGoodsReceipt(List<GoodsReceipt> receipts, String id) {
    for (final receipt in receipts) {
      if (receipt.id == id) {
        return receipt;
      }
    }
    return null;
  }

  VendorBill? _findVendorBill(List<VendorBill> bills, String id) {
    for (final bill in bills) {
      if (bill.id == id) {
        return bill;
      }
    }
    return null;
  }

  VendorPayment? _findVendorPayment(List<VendorPayment> payments, String id) {
    for (final payment in payments) {
      if (payment.id == id) {
        return payment;
      }
    }
    return null;
  }

  SalesInvoice? _findSalesInvoice(List<SalesInvoice> invoices, String id) {
    for (final invoice in invoices) {
      if (invoice.id == id) {
        return invoice;
      }
    }
    return null;
  }

  CustomerPayment? _findCustomerPayment(
    List<CustomerPayment> payments,
    String id,
  ) {
    for (final payment in payments) {
      if (payment.id == id) {
        return payment;
      }
    }
    return null;
  }
}
