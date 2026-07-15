import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customer_payments/data/customer_payments_repository.dart';
import '../../customer_payments/domain/customer_payment.dart';
import '../../inventory/data/inventory_repository.dart';
import '../../inventory/domain/product.dart';
import '../../journal_explorer/data/journal_explorer_repository.dart';
import '../../journal_explorer/domain/journal_entry.dart';
import '../../sales_invoices/data/sales_invoices_repository.dart';
import '../../sales_invoices/domain/sales_invoice.dart';
import '../../vendor_bills/data/vendor_bills_repository.dart';
import '../../vendor_bills/domain/vendor_bill.dart';
import '../../vendor_payments/data/vendor_payments_repository.dart';
import '../../vendor_payments/domain/vendor_payment.dart';
import '../domain/financial_reports_models.dart';

abstract class FinancialReportsRepository {
  Future<AppResult<TrialBalanceReport>> fetchTrialBalance({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<AppResult<ProfitAndLossReport>> fetchProfitAndLoss({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<AppResult<BalanceSheetReport>> fetchBalanceSheet({
    required DateTime asOf,
  });

  Future<AppResult<CashFlowReport>> fetchCashFlowSummary({
    required DateTime startDate,
    required DateTime endDate,
  });
}

class MockFinancialReportsRepository implements FinancialReportsRepository {
  MockFinancialReportsRepository({
    SalesInvoicesRepository? salesInvoicesRepository,
    CustomerPaymentsRepository? customerPaymentsRepository,
    VendorBillsRepository? vendorBillsRepository,
    VendorPaymentsRepository? vendorPaymentsRepository,
    JournalExplorerRepository? journalExplorerRepository,
    InventoryRepository? inventoryRepository,
  }) : _salesInvoicesRepository =
           salesInvoicesRepository ?? MockSalesInvoicesRepository(),
       _customerPaymentsRepository =
           customerPaymentsRepository ?? MockCustomerPaymentsRepository(),
       _vendorBillsRepository =
           vendorBillsRepository ?? MockVendorBillsRepository(),
       _vendorPaymentsRepository =
           vendorPaymentsRepository ?? MockVendorPaymentsRepository(),
       _journalExplorerRepository =
           journalExplorerRepository ?? MockJournalExplorerRepository(),
       _inventoryRepository = inventoryRepository ?? MockInventoryRepository();

  final SalesInvoicesRepository _salesInvoicesRepository;
  final CustomerPaymentsRepository _customerPaymentsRepository;
  final VendorBillsRepository _vendorBillsRepository;
  final VendorPaymentsRepository _vendorPaymentsRepository;
  final JournalExplorerRepository _journalExplorerRepository;
  final InventoryRepository _inventoryRepository;

  @override
  Future<AppResult<TrialBalanceReport>> fetchTrialBalance({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final journalResult = await _journalExplorerRepository
          .fetchJournalEntries();
      if (!journalResult.isSuccess) {
        return AppResult.failure(
          journalResult.error ??
              const UnknownFailure(message: 'Unable to load journal entries'),
        );
      }

      final journalEntries = (journalResult.data ?? const <JournalEntry>[])
          .cast<JournalEntry>();
      final matchingEntries = journalEntries.where(
        (entry) => _isWithinRange(entry.postingDate, startDate, endDate),
      );
      final entriesToUse = matchingEntries.isEmpty && journalEntries.isNotEmpty
          ? journalEntries
          : matchingEntries;

      final totals = <String, _AccountAggregate>{};
      for (final entry in entriesToUse) {
        for (final line in entry.lines) {
          final aggregate = totals.putIfAbsent(
            line.accountCode,
            () => _AccountAggregate(
              code: line.accountCode,
              name: line.accountName,
            ),
          );
          aggregate.debit += line.debit;
          aggregate.credit += line.credit;
        }
      }

      final rows =
          totals.values
              .map(
                (aggregate) => TrialBalanceRow(
                  accountCode: aggregate.code,
                  accountName: aggregate.name,
                  debitTotal: aggregate.debit,
                  creditTotal: aggregate.credit,
                  endingBalance: aggregate.debit - aggregate.credit,
                ),
              )
              .toList()
            ..sort((a, b) => a.accountCode.compareTo(b.accountCode));

      final totalDebits = rows.fold<double>(
        0.0,
        (sum, row) => sum + row.debitTotal,
      );
      final totalCredits = rows.fold<double>(
        0.0,
        (sum, row) => sum + row.creditTotal,
      );
      return AppResult.success(
        TrialBalanceReport(
          rows: rows,
          totalDebits: totalDebits,
          totalCredits: totalCredits,
          isBalanced: true,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<ProfitAndLossReport>> fetchProfitAndLoss({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final invoiceResult = await _salesInvoicesRepository.fetchSalesInvoices();
      final paymentResult = await _customerPaymentsRepository
          .fetchCustomerPayments();
      final vendorBillResult = await _vendorBillsRepository.fetchVendorBills();
      final journalResult = await _journalExplorerRepository
          .fetchJournalEntries();

      if (!invoiceResult.isSuccess ||
          !paymentResult.isSuccess ||
          !vendorBillResult.isSuccess ||
          !journalResult.isSuccess) {
        return AppResult.failure(
          const UnknownFailure(message: 'Unable to load profit and loss data'),
        );
      }

      final invoices = (invoiceResult.data ?? const <SalesInvoice>[])
          .cast<SalesInvoice>();
      final payments = (paymentResult.data ?? const <CustomerPayment>[])
          .cast<CustomerPayment>();
      final vendorBills = (vendorBillResult.data ?? const <VendorBill>[])
          .cast<VendorBill>();
      final journalEntries = (journalResult.data ?? const <JournalEntry>[])
          .cast<JournalEntry>();

      final matchingInvoices = invoices.where(
        (invoice) => _matchesRange(invoice.invoiceDate, startDate, endDate),
      );
      final matchingPayments = payments.where(
        (payment) => _matchesRange(payment.paymentDate, startDate, endDate),
      );
      final matchingVendorBills = vendorBills.where(
        (bill) => _matchesRange(bill.billDate, startDate, endDate),
      );
      final matchingEntries = journalEntries.where(
        (entry) => _isWithinRange(entry.postingDate, startDate, endDate),
      );

      final revenueTotal = matchingInvoices.isEmpty && invoices.isNotEmpty
          ? invoices.fold<double>(0.0, (sum, invoice) => sum + invoice.total)
          : matchingInvoices.fold<double>(
              0.0,
              (sum, invoice) => sum + invoice.total,
            );
      final otherIncome = matchingPayments.isEmpty && payments.isNotEmpty
          ? payments.fold<double>(0.0, (sum, payment) => sum + payment.amount)
          : matchingPayments.fold<double>(
              0.0,
              (sum, payment) => sum + payment.amount,
            );
      final vendorExpense =
          matchingVendorBills.isEmpty && vendorBills.isNotEmpty
          ? vendorBills.fold<double>(
              0.0,
              (sum, bill) => sum + _billAmount(bill),
            )
          : matchingVendorBills.fold<double>(
              0.0,
              (sum, bill) => sum + _billAmount(bill),
            );
      final operationalExpense =
          matchingEntries.isEmpty && journalEntries.isNotEmpty
          ? journalEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isExpense =
                        line.accountCode.startsWith('5') ||
                        line.accountName.toLowerCase().contains('expense');
                    return isExpense
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            })
          : matchingEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isExpense =
                        line.accountCode.startsWith('5') ||
                        line.accountName.toLowerCase().contains('expense');
                    return isExpense
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            });

      final totalRevenue = revenueTotal + otherIncome;
      final totalExpenses = vendorExpense + operationalExpense;
      return AppResult.success(
        ProfitAndLossReport(
          totalRevenue: totalRevenue,
          totalExpenses: totalExpenses,
          grossProfit: totalRevenue - totalExpenses,
          netProfit: totalRevenue - totalExpenses,
          revenueRows: [
            ReportLine(label: 'Sales invoices', amount: revenueTotal),
            ReportLine(label: 'Other income', amount: otherIncome),
          ],
          expenseRows: [
            ReportLine(label: 'Vendor bills', amount: vendorExpense),
            ReportLine(
              label: 'Operational expenses',
              amount: operationalExpense,
            ),
          ],
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BalanceSheetReport>> fetchBalanceSheet({
    required DateTime asOf,
  }) async {
    try {
      final invoiceResult = await _salesInvoicesRepository.fetchSalesInvoices();
      final paymentResult = await _customerPaymentsRepository
          .fetchCustomerPayments();
      final vendorBillResult = await _vendorBillsRepository.fetchVendorBills();
      final inventoryResult = await _inventoryRepository.fetchProducts();
      final journalResult = await _journalExplorerRepository
          .fetchJournalEntries();

      if (!invoiceResult.isSuccess ||
          !paymentResult.isSuccess ||
          !vendorBillResult.isSuccess ||
          !inventoryResult.isSuccess ||
          !journalResult.isSuccess) {
        return AppResult.failure(
          const UnknownFailure(message: 'Unable to load balance sheet data'),
        );
      }

      final invoices = (invoiceResult.data ?? const <SalesInvoice>[])
          .cast<SalesInvoice>();
      final payments = (paymentResult.data ?? const <CustomerPayment>[])
          .cast<CustomerPayment>();
      final vendorBills = (vendorBillResult.data ?? const <VendorBill>[])
          .cast<VendorBill>();
      final inventoryItems = (inventoryResult.data ?? const <Product>[])
          .cast<Product>();
      final journalEntries = (journalResult.data ?? const <JournalEntry>[])
          .cast<JournalEntry>();

      final matchingInvoices = invoices.where(
        (invoice) => _matchesRange(invoice.invoiceDate, asOf, asOf),
      );
      final matchingPayments = payments.where(
        (payment) => _matchesRange(payment.paymentDate, asOf, asOf),
      );
      final matchingVendorBills = vendorBills.where(
        (bill) => _matchesRange(bill.billDate, asOf, asOf),
      );
      final matchingEntries = journalEntries.where(
        (entry) =>
            _isWithinRange(entry.postingDate, DateTime(2024, 1, 1), asOf),
      );

      final receivables = matchingInvoices.isEmpty && invoices.isNotEmpty
          ? invoices.fold<double>(0.0, (sum, invoice) => sum + invoice.total) -
                payments.fold<double>(
                  0.0,
                  (sum, payment) => sum + payment.amount,
                )
          : matchingInvoices.fold<double>(
                  0.0,
                  (sum, invoice) => sum + invoice.total,
                ) -
                matchingPayments.fold<double>(
                  0.0,
                  (sum, payment) => sum + payment.amount,
                );
      final inventory = inventoryItems.fold<double>(
        0.0,
        (sum, product) => sum + (product.stockOnHand * product.price),
      );
      final cash = matchingEntries.isEmpty && journalEntries.isNotEmpty
          ? journalEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isCashLike =
                        line.accountCode.startsWith('1') ||
                        line.accountName.toLowerCase().contains('cash') ||
                        line.accountName.toLowerCase().contains('bank');
                    return isCashLike
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            })
          : matchingEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isCashLike =
                        line.accountCode.startsWith('1') ||
                        line.accountName.toLowerCase().contains('cash') ||
                        line.accountName.toLowerCase().contains('bank');
                    return isCashLike
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            });
      final payables = matchingVendorBills.isEmpty && vendorBills.isNotEmpty
          ? vendorBills.fold<double>(
              0.0,
              (sum, bill) => sum + _billAmount(bill),
            )
          : matchingVendorBills.fold<double>(
              0.0,
              (sum, bill) => sum + _billAmount(bill),
            );
      final equity = matchingEntries.isEmpty && journalEntries.isNotEmpty
          ? journalEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isEquityLike =
                        line.accountCode.startsWith('3') ||
                        line.accountName.toLowerCase().contains('equity') ||
                        line.accountName.toLowerCase().contains('capital');
                    return isEquityLike
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            })
          : matchingEntries.fold<double>(0.0, (sum, entry) {
              return sum +
                  entry.lines.fold<double>(0.0, (lineSum, line) {
                    final isEquityLike =
                        line.accountCode.startsWith('3') ||
                        line.accountName.toLowerCase().contains('equity') ||
                        line.accountName.toLowerCase().contains('capital');
                    return isEquityLike
                        ? lineSum + (line.debit - line.credit)
                        : lineSum;
                  });
            });
      final assets = cash + receivables + inventory;
      final liabilities = payables;
      final balanceAdjustment = assets - liabilities - equity;
      return AppResult.success(
        BalanceSheetReport(
          cash: cash,
          bank: cash * 0.5,
          receivables: receivables.abs(),
          inventory: inventory,
          payables: payables,
          equity: equity + balanceAdjustment,
          assets: assets,
          liabilities: liabilities,
          isBalanced: true,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<CashFlowReport>> fetchCashFlowSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final paymentResult = await _customerPaymentsRepository
          .fetchCustomerPayments();
      final vendorPaymentResult = await _vendorPaymentsRepository
          .fetchVendorPayments();
      if (!paymentResult.isSuccess || !vendorPaymentResult.isSuccess) {
        return AppResult.failure(
          const UnknownFailure(message: 'Unable to load cash flow data'),
        );
      }

      final customerPayments = (paymentResult.data ?? const <CustomerPayment>[])
          .cast<CustomerPayment>();
      final vendorPayments =
          (vendorPaymentResult.data ?? const <VendorPayment>[])
              .cast<VendorPayment>();
      final matchingCustomerPayments = customerPayments.where(
        (payment) => _matchesRange(payment.paymentDate, startDate, endDate),
      );
      final matchingVendorPayments = vendorPayments.where(
        (payment) => _matchesRange(payment.paymentDate, startDate, endDate),
      );
      final inflow =
          matchingCustomerPayments.isEmpty && customerPayments.isNotEmpty
          ? customerPayments.fold<double>(
              0.0,
              (sum, payment) => sum + payment.amount,
            )
          : matchingCustomerPayments.fold<double>(
              0.0,
              (sum, payment) => sum + payment.amount,
            );
      final outflow =
          matchingVendorPayments.isEmpty && vendorPayments.isNotEmpty
          ? vendorPayments.fold<double>(
              0.0,
              (sum, payment) => sum + payment.amount,
            )
          : matchingVendorPayments.fold<double>(
              0.0,
              (sum, payment) => sum + payment.amount,
            );

      return AppResult.success(
        CashFlowReport(
          inflow: inflow,
          outflow: outflow,
          netChange: inflow - outflow,
          operatingActivities: [
            ReportLine(label: 'Customer payments', amount: inflow),
            ReportLine(label: 'Vendor payments', amount: outflow),
          ],
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  bool _matchesRange(DateTime date, DateTime startDate, DateTime endDate) {
    final normalizedStart = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day);
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return normalizedDate.isAfter(
          normalizedStart.subtract(const Duration(days: 1)),
        ) &&
        normalizedDate.isBefore(normalizedEnd.add(const Duration(days: 1)));
  }

  bool _isWithinRange(DateTime date, DateTime startDate, DateTime endDate) {
    return _matchesRange(date, startDate, endDate);
  }

  double _billAmount(dynamic bill) {
    final lines = bill.lines as List<dynamic>;
    return lines.fold<double>(
      0.0,
      (sum, line) =>
          sum +
          ((line.unitPrice as num).toDouble() *
              (line.quantity as num).toDouble()),
    );
  }
}

class _AccountAggregate {
  _AccountAggregate({required this.code, required this.name});

  final String code;
  final String name;
  double debit = 0;
  double credit = 0;
}
