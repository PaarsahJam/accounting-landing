import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customer_payments/data/customer_payments_repository.dart';
import '../../journal_preview/data/journal_preview_repository.dart';
import '../../purchase_orders/data/purchase_orders_repository.dart';
import '../../sales_invoices/data/sales_invoices_repository.dart';
import '../../vendor_bills/data/vendor_bills_repository.dart';
import '../../vendor_payments/data/vendor_payments_repository.dart';
import '../domain/journal_entry.dart';
import 'journal_preview_mapper.dart';

abstract class JournalExplorerRepository {
  Future<AppResult<List<JournalEntry>>> fetchJournalEntries();
}

class MockJournalExplorerRepository implements JournalExplorerRepository {
  MockJournalExplorerRepository({
    PurchaseOrdersRepository? purchaseOrdersRepository,
    VendorBillsRepository? vendorBillsRepository,
    VendorPaymentsRepository? vendorPaymentsRepository,
    SalesInvoicesRepository? salesInvoicesRepository,
    CustomerPaymentsRepository? customerPaymentsRepository,
    JournalPreviewRepository? journalPreviewRepository,
  }) : _purchaseOrdersRepository =
           purchaseOrdersRepository ?? MockPurchaseOrdersRepository(),
       _vendorBillsRepository =
           vendorBillsRepository ?? MockVendorBillsRepository(),
       _vendorPaymentsRepository =
           vendorPaymentsRepository ?? MockVendorPaymentsRepository(),
       _salesInvoicesRepository =
           salesInvoicesRepository ?? MockSalesInvoicesRepository(),
       _customerPaymentsRepository =
           customerPaymentsRepository ?? MockCustomerPaymentsRepository(),
       _journalPreviewRepository =
           journalPreviewRepository ?? MockJournalPreviewRepository();

  final PurchaseOrdersRepository _purchaseOrdersRepository;
  final VendorBillsRepository _vendorBillsRepository;
  final VendorPaymentsRepository _vendorPaymentsRepository;
  final SalesInvoicesRepository _salesInvoicesRepository;
  final CustomerPaymentsRepository _customerPaymentsRepository;
  final JournalPreviewRepository _journalPreviewRepository;

  @override
  Future<AppResult<List<JournalEntry>>> fetchJournalEntries() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final entries = <JournalEntry>[];
      entries.addAll(await _buildEntriesForType('purchase_order'));
      entries.addAll(await _buildEntriesForType('goods_receipt'));
      entries.addAll(await _buildEntriesForType('vendor_bill'));
      entries.addAll(await _buildEntriesForType('vendor_payment'));
      entries.addAll(await _buildEntriesForType('sales_invoice'));
      entries.addAll(await _buildEntriesForType('customer_payment'));

      entries.sort((a, b) => b.postingDate.compareTo(a.postingDate));
      return AppResult.success(List.unmodifiable(entries));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<List<JournalEntry>> _buildEntriesForType(String documentType) async {
    final documentIds = await _documentIdsForType(documentType);
    final entries = <JournalEntry>[];

    for (final documentId in documentIds) {
      final result = await _journalPreviewRepository.fetchJournalPreview(
        documentType,
        documentId,
      );
      if (result.isSuccess && result.data != null) {
        entries.add(journalEntryFromPreview(result.data!));
      }
    }

    return entries;
  }

  Future<List<String>> _documentIdsForType(String documentType) async {
    switch (documentType) {
      case 'purchase_order':
        final result = await _purchaseOrdersRepository.fetchPurchaseOrders();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((order) => order.id).toList();
      case 'goods_receipt':
        final result = await _purchaseOrdersRepository.fetchGoodsReceipts();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((receipt) => receipt.id).toList();
      case 'vendor_bill':
        final result = await _vendorBillsRepository.fetchVendorBills();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((bill) => bill.id).toList();
      case 'vendor_payment':
        final result = await _vendorPaymentsRepository.fetchVendorPayments();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((payment) => payment.id).toList();
      case 'sales_invoice':
        final result = await _salesInvoicesRepository.fetchSalesInvoices();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((invoice) => invoice.id).toList();
      case 'customer_payment':
        final result = await _customerPaymentsRepository
            .fetchCustomerPayments();
        if (!result.isSuccess) {
          return const [];
        }
        return (result.data ?? const []).map((payment) => payment.id).toList();
      default:
        return const [];
    }
  }
}
