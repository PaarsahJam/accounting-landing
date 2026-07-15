import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customers/domain/customer.dart';
import '../domain/sales_invoice.dart';
import '../domain/sales_invoice_line.dart';
import '../domain/sales_invoice_status.dart';

abstract class SalesInvoicesRepository {
  Future<AppResult<List<SalesInvoice>>> fetchSalesInvoices();
  Future<AppResult<SalesInvoice>> createSalesInvoice(SalesInvoice invoice);
  Future<AppResult<SalesInvoice>> updateSalesInvoice(SalesInvoice invoice);
  Future<AppResult<void>> deleteSalesInvoice(String id);
  Future<AppResult<List<Customer>>> fetchCustomers();
}

class MockSalesInvoicesRepository implements SalesInvoicesRepository {
  MockSalesInvoicesRepository();

  final List<SalesInvoiceStatus> _statuses = const [
    SalesInvoiceStatus(id: 'draft', label: 'Draft', color: 'grey'),
    SalesInvoiceStatus(id: 'sent', label: 'Sent', color: 'blue'),
    SalesInvoiceStatus(id: 'partial', label: 'Partially Paid', color: 'amber'),
    SalesInvoiceStatus(id: 'paid', label: 'Paid', color: 'green'),
    SalesInvoiceStatus(id: 'overdue', label: 'Overdue', color: 'red'),
  ];

  final List<SalesInvoice> _invoices = [
    SalesInvoice(
      id: 'INV-1001',
      customerId: 'CUST-1001',
      customerName: 'Ava Rahimi',
      reference: 'INV-1001',
      title: 'Website project retainer',
      notes: 'Quarterly retainer',
      invoiceDate: DateTime(2024, 1, 5),
      dueDate: DateTime(2024, 1, 20),
      status: const SalesInvoiceStatus(
        id: 'sent',
        label: 'Sent',
        color: 'blue',
      ),
      lines: const [
        SalesInvoiceLine(
          id: 'SIL-1',
          description: 'Retainer services',
          quantity: 1,
          unitPrice: 2500000,
        ),
      ],
      subtotal: 2500000,
      tax: 250000,
      total: 2750000,
    ),
  ];

  final List<Customer> _customers = const [
    Customer(
      id: 'CUST-1001',
      name: 'Ava Rahimi',
      company: 'Northstar Co.',
      email: 'ava@northstar.co',
      phone: '+98 912 000 0001',
      outstandingBalance: 2450000,
      status: 'Active',
      notes: 'Preferred for monthly invoicing',
    ),
    Customer(
      id: 'CUST-1002',
      name: 'Sina Nouri',
      company: 'Bright Labs',
      email: 'sina@brightlabs.ir',
      phone: '+98 913 000 0002',
      outstandingBalance: 860000,
      status: 'Pending',
      notes: 'Settlement expected next week',
    ),
  ];

  @override
  Future<AppResult<List<SalesInvoice>>> fetchSalesInvoices() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_invoices));
  }

  @override
  Future<AppResult<SalesInvoice>> createSalesInvoice(
    SalesInvoice invoice,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _invoices.add(invoice);
    return AppResult.success(invoice);
  }

  @override
  Future<AppResult<SalesInvoice>> updateSalesInvoice(
    SalesInvoice invoice,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _invoices.indexWhere((item) => item.id == invoice.id);
    if (index >= 0) {
      _invoices[index] = invoice;
      return AppResult.success(invoice);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Sales invoice not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteSalesInvoice(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _invoices.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _invoices.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Sales invoice not found'),
    );
  }

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return AppResult.success(List.unmodifiable(_customers));
  }

  List<SalesInvoiceStatus> get statuses => List.unmodifiable(_statuses);
}
