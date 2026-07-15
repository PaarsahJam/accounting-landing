import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../sales_invoices/domain/sales_invoice.dart';
import '../../sales_invoices/domain/sales_invoice_status.dart';
import '../domain/customer_payment.dart';
import '../domain/customer_payment_allocation.dart';
import '../domain/customer_payment_method.dart';
import '../domain/customer_payment_status.dart';

abstract class CustomerPaymentsRepository {
  Future<AppResult<List<CustomerPayment>>> fetchCustomerPayments();
  Future<AppResult<CustomerPayment>> createCustomerPayment(
    CustomerPayment payment,
  );
  Future<AppResult<CustomerPayment>> updateCustomerPayment(
    CustomerPayment payment,
  );
  Future<AppResult<void>> deleteCustomerPayment(String id);
  Future<AppResult<List<SalesInvoice>>> fetchSalesInvoices();
}

class MockCustomerPaymentsRepository implements CustomerPaymentsRepository {
  MockCustomerPaymentsRepository();

  final List<CustomerPaymentMethod> _methods = const [
    CustomerPaymentMethod(id: 'cash', label: 'Cash', icon: 'cash'),
    CustomerPaymentMethod(
      id: 'bank_transfer',
      label: 'Bank Transfer',
      icon: 'account_balance',
    ),
    CustomerPaymentMethod(id: 'check', label: 'Check', icon: 'receipt_long'),
    CustomerPaymentMethod(
      id: 'credit_card',
      label: 'Credit Card',
      icon: 'credit_card',
    ),
  ];

  final List<CustomerPaymentStatus> _statuses = const [
    CustomerPaymentStatus(id: 'received', label: 'Received', color: 'green'),
    CustomerPaymentStatus(id: 'pending', label: 'Pending', color: 'amber'),
    CustomerPaymentStatus(
      id: 'partial',
      label: 'Partially Applied',
      color: 'blue',
    ),
  ];

  final List<CustomerPayment> _payments = [
    CustomerPayment(
      id: 'CP-1001',
      customerId: 'CUST-1001',
      customerName: 'Ava Rahimi',
      reference: 'CP-1001',
      notes: 'Initial payment for retainer',
      paymentDate: DateTime(2024, 1, 10),
      receivedAt: DateTime(2024, 1, 10),
      amount: 2750000,
      method: const CustomerPaymentMethod(
        id: 'bank_transfer',
        label: 'Bank Transfer',
        icon: 'account_balance',
      ),
      status: const CustomerPaymentStatus(
        id: 'received',
        label: 'Received',
        color: 'green',
      ),
      allocations: const [
        CustomerPaymentAllocation(
          invoiceId: 'INV-1001',
          invoiceReference: 'INV-1001',
          amount: 2750000,
        ),
      ],
    ),
  ];

  final List<SalesInvoice> _salesInvoices = [
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
      lines: const [],
      subtotal: 2500000,
      tax: 250000,
      total: 2750000,
    ),
  ];

  CustomerPayment samplePayment() {
    return CustomerPayment(
      id: 'CP-${DateTime.now().millisecondsSinceEpoch}',
      customerId: 'CUST-1001',
      customerName: 'Ava Rahimi',
      reference: 'CP-${DateTime.now().millisecondsSinceEpoch}',
      notes: 'Sample payment',
      paymentDate: DateTime.now(),
      receivedAt: DateTime.now(),
      amount: 1000000,
      method: const CustomerPaymentMethod(
        id: 'cash',
        label: 'Cash',
        icon: 'cash',
      ),
      status: const CustomerPaymentStatus(
        id: 'pending',
        label: 'Pending',
        color: 'amber',
      ),
      allocations: const [],
    );
  }

  @override
  Future<AppResult<List<CustomerPayment>>> fetchCustomerPayments() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_payments));
  }

  @override
  Future<AppResult<CustomerPayment>> createCustomerPayment(
    CustomerPayment payment,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _payments.add(payment);
    return AppResult.success(payment);
  }

  @override
  Future<AppResult<CustomerPayment>> updateCustomerPayment(
    CustomerPayment payment,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _payments.indexWhere((item) => item.id == payment.id);
    if (index >= 0) {
      _payments[index] = payment;
      return AppResult.success(payment);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Customer payment not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteCustomerPayment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _payments.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _payments.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Customer payment not found'),
    );
  }

  @override
  Future<AppResult<List<SalesInvoice>>> fetchSalesInvoices() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_salesInvoices));
  }

  List<CustomerPaymentMethod> get methods => List.unmodifiable(_methods);
  List<CustomerPaymentStatus> get statuses => List.unmodifiable(_statuses);
}
