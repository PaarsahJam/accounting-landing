import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customers/data/customer_repository.dart';
import '../../customer_payments/data/customer_payments_repository.dart';
import '../../sales_invoices/data/sales_invoices_repository.dart';
import '../domain/customer_statement.dart';

abstract class CustomerStatementsRepository {
  Future<AppResult<List<CustomerStatement>>> fetchCustomerStatements();
}

class MockCustomerStatementsRepository implements CustomerStatementsRepository {
  MockCustomerStatementsRepository({
    CustomerRepository? customerRepository,
    SalesInvoicesRepository? salesInvoicesRepository,
    CustomerPaymentsRepository? customerPaymentsRepository,
  }) : _customerRepository = customerRepository ?? MockCustomerRepository(),
       _salesInvoicesRepository =
           salesInvoicesRepository ?? MockSalesInvoicesRepository(),
       _customerPaymentsRepository =
           customerPaymentsRepository ?? MockCustomerPaymentsRepository();

  final CustomerRepository _customerRepository;
  final SalesInvoicesRepository _salesInvoicesRepository;
  final CustomerPaymentsRepository _customerPaymentsRepository;

  @override
  Future<AppResult<List<CustomerStatement>>> fetchCustomerStatements() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final customersResult = await _customerRepository.fetchCustomers();
      final invoicesResult = await _salesInvoicesRepository
          .fetchSalesInvoices();
      final paymentsResult = await _customerPaymentsRepository
          .fetchCustomerPayments();

      if (!customersResult.isSuccess) {
        return AppResult.failure(
          customersResult.error ??
              const UnknownFailure(message: 'Unable to load customers'),
        );
      }
      if (!invoicesResult.isSuccess) {
        return AppResult.failure(
          invoicesResult.error ??
              const UnknownFailure(message: 'Unable to load invoices'),
        );
      }
      if (!paymentsResult.isSuccess) {
        return AppResult.failure(
          paymentsResult.error ??
              const UnknownFailure(message: 'Unable to load payments'),
        );
      }

      final customers = customersResult.data ?? const <dynamic>[];
      final invoices = invoicesResult.data ?? const <dynamic>[];
      final payments = paymentsResult.data ?? const <dynamic>[];

      final statements = <CustomerStatement>[];
      for (final customer in customers) {
        final customerInvoices = invoices
            .where((invoice) => invoice.customerId == customer.id)
            .toList();
        final customerPayments = payments
            .where((payment) => payment.customerId == customer.id)
            .toList();

        final entries = <CustomerStatementEntry>[];
        double runningBalance = customer.outstandingBalance;
        final invoiceHistory = <CustomerStatementInvoice>[];
        final paymentHistory = <CustomerStatementPayment>[];

        for (final invoice in customerInvoices) {
          invoiceHistory.add(
            CustomerStatementInvoice(
              id: invoice.id,
              reference: invoice.reference,
              invoiceDate: invoice.invoiceDate,
              dueDate: invoice.dueDate,
              amount: invoice.total,
              status: invoice.status.label,
            ),
          );
          entries.add(
            CustomerStatementEntry(
              id: 'inv-${invoice.id}',
              date: invoice.invoiceDate,
              description: '${invoice.reference} • ${invoice.title}',
              amount: invoice.total,
              type: 'invoice',
              runningBalance: runningBalance + invoice.total,
            ),
          );
          runningBalance += invoice.total;
        }

        for (final payment in customerPayments) {
          paymentHistory.add(
            CustomerStatementPayment(
              id: payment.id,
              reference: payment.reference,
              paymentDate: payment.paymentDate,
              amount: payment.amount,
              method: payment.method.label,
            ),
          );
          entries.add(
            CustomerStatementEntry(
              id: 'pay-${payment.id}',
              date: payment.paymentDate,
              description: '${payment.reference} • ${payment.method.label}',
              amount: payment.amount,
              type: 'payment',
              runningBalance: runningBalance - payment.amount,
            ),
          );
          runningBalance -= payment.amount;
        }

        entries.sort((a, b) => a.date.compareTo(b.date));
        invoiceHistory.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
        paymentHistory.sort((a, b) => a.paymentDate.compareTo(b.paymentDate));

        final agingBuckets = <CustomerAgingBucket>[
          CustomerAgingBucket(id: 'current', label: 'Current', amount: 0),
          CustomerAgingBucket(id: '1-30', label: '1–30 days', amount: 0),
          CustomerAgingBucket(id: '31-60', label: '31–60 days', amount: 0),
          CustomerAgingBucket(id: '61-90', label: '61–90 days', amount: 0),
          CustomerAgingBucket(id: '90+', label: '90+ days', amount: 0),
        ];

        final today = DateTime.now();
        for (final invoice in invoiceHistory) {
          final daysOverdue = today.difference(invoice.dueDate).inDays;
          final bucket = daysOverdue <= 0
              ? agingBuckets[0]
              : daysOverdue <= 30
              ? agingBuckets[1]
              : daysOverdue <= 60
              ? agingBuckets[2]
              : daysOverdue <= 90
              ? agingBuckets[3]
              : agingBuckets[4];

          final updatedAmount = bucket.amount + invoice.amount;
          agingBuckets[agingBuckets.indexOf(bucket)] = CustomerAgingBucket(
            id: bucket.id,
            label: bucket.label,
            amount: updatedAmount,
          );
        }

        statements.add(
          CustomerStatement(
            id: customer.id,
            customerId: customer.id,
            customerName: customer.name,
            openingBalance: customer.outstandingBalance,
            runningBalance: runningBalance,
            outstandingBalance: runningBalance,
            entries: entries,
            invoiceHistory: invoiceHistory,
            paymentHistory: paymentHistory,
            agingBuckets: agingBuckets,
          ),
        );
      }

      return AppResult.success(List.unmodifiable(statements));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
