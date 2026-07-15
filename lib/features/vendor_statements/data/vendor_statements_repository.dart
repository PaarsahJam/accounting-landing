import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../vendor_bills/data/vendor_bills_repository.dart';
import '../../vendor_payments/data/vendor_payments_repository.dart';
import '../../vendors/data/vendor_repository.dart';
import '../domain/vendor_statement.dart';

abstract class VendorStatementsRepository {
  Future<AppResult<List<VendorStatement>>> fetchVendorStatements();
}

class MockVendorStatementsRepository implements VendorStatementsRepository {
  MockVendorStatementsRepository({
    VendorRepository? vendorRepository,
    VendorBillsRepository? vendorBillsRepository,
    VendorPaymentsRepository? vendorPaymentsRepository,
  }) : _vendorRepository = vendorRepository ?? MockVendorRepository(),
       _vendorBillsRepository =
           vendorBillsRepository ?? MockVendorBillsRepository(),
       _vendorPaymentsRepository =
           vendorPaymentsRepository ?? MockVendorPaymentsRepository();

  final VendorRepository _vendorRepository;
  final VendorBillsRepository _vendorBillsRepository;
  final VendorPaymentsRepository _vendorPaymentsRepository;

  @override
  Future<AppResult<List<VendorStatement>>> fetchVendorStatements() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final vendorsResult = await _vendorRepository.fetchVendors();
      final billsResult = await _vendorBillsRepository.fetchVendorBills();
      final paymentsResult = await _vendorPaymentsRepository
          .fetchVendorPayments();

      if (!vendorsResult.isSuccess) {
        return AppResult.failure(
          vendorsResult.error ??
              const UnknownFailure(message: 'Unable to load vendors'),
        );
      }
      if (!billsResult.isSuccess) {
        return AppResult.failure(
          billsResult.error ??
              const UnknownFailure(message: 'Unable to load vendor bills'),
        );
      }
      if (!paymentsResult.isSuccess) {
        return AppResult.failure(
          paymentsResult.error ??
              const UnknownFailure(message: 'Unable to load vendor payments'),
        );
      }

      final vendors = vendorsResult.data ?? const <dynamic>[];
      final bills = billsResult.data ?? const <dynamic>[];
      final payments = paymentsResult.data ?? const <dynamic>[];

      final statements = <VendorStatement>[];
      for (final vendor in vendors) {
        final vendorBills = bills
            .where((bill) => bill.vendorId == vendor.id)
            .toList();
        final vendorPayments = payments
            .where((payment) => payment.vendorId == vendor.id)
            .toList();

        final entries = <VendorStatementEntry>[];
        double runningBalance = 0;
        final billHistory = <VendorStatementBill>[];
        final paymentHistory = <VendorStatementPayment>[];

        for (final bill in vendorBills) {
          billHistory.add(
            VendorStatementBill(
              id: bill.id,
              reference: bill.reference,
              billDate: bill.billDate,
              dueDate: bill.dueDate,
              amount: bill.lines.fold<double>(
                0,
                (sum, line) => sum + (line.unitPrice * line.quantity),
              ),
              status: bill.status.label,
            ),
          );
          entries.add(
            VendorStatementEntry(
              id: 'bill-${bill.id}',
              date: bill.billDate,
              description: '${bill.reference} • ${bill.title}',
              amount: bill.lines.fold<double>(
                0,
                (sum, line) => sum + (line.unitPrice * line.quantity),
              ),
              type: 'bill',
              runningBalance:
                  runningBalance +
                  bill.lines.fold<double>(
                    0,
                    (sum, line) => sum + (line.unitPrice * line.quantity),
                  ),
            ),
          );
          runningBalance += bill.lines.fold<double>(
            0,
            (sum, line) => sum + (line.unitPrice * line.quantity),
          );
        }

        for (final payment in vendorPayments) {
          paymentHistory.add(
            VendorStatementPayment(
              id: payment.id,
              reference: payment.reference,
              paymentDate: payment.paymentDate,
              amount: payment.amount,
              method: payment.method.label,
            ),
          );
          entries.add(
            VendorStatementEntry(
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
        billHistory.sort((a, b) => a.billDate.compareTo(b.billDate));
        paymentHistory.sort((a, b) => a.paymentDate.compareTo(b.paymentDate));

        final agingBuckets = <VendorAgingBucket>[
          VendorAgingBucket(id: 'current', label: 'Current', amount: 0),
          VendorAgingBucket(id: '1-30', label: '1–30 days', amount: 0),
          VendorAgingBucket(id: '31-60', label: '31–60 days', amount: 0),
          VendorAgingBucket(id: '61-90', label: '61–90 days', amount: 0),
          VendorAgingBucket(id: '90+', label: '90+ days', amount: 0),
        ];

        final today = DateTime.now();
        for (final bill in billHistory) {
          final daysOverdue = today.difference(bill.dueDate).inDays;
          final bucket = daysOverdue <= 0
              ? agingBuckets[0]
              : daysOverdue <= 30
              ? agingBuckets[1]
              : daysOverdue <= 60
              ? agingBuckets[2]
              : daysOverdue <= 90
              ? agingBuckets[3]
              : agingBuckets[4];

          final updatedAmount = bucket.amount + bill.amount;
          agingBuckets[agingBuckets.indexOf(bucket)] = VendorAgingBucket(
            id: bucket.id,
            label: bucket.label,
            amount: updatedAmount,
          );
        }

        statements.add(
          VendorStatement(
            id: vendor.id,
            vendorId: vendor.id,
            vendorName: vendor.companyName,
            openingBalance: 0,
            runningBalance: runningBalance,
            outstandingBalance: runningBalance,
            entries: entries,
            billHistory: billHistory,
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
