import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customer_payments/data/customer_payments_repository.dart';
import '../../customer_statements/data/customer_statements_repository.dart';
import '../../inventory/data/inventory_repository.dart';
import '../../journal_explorer/data/journal_explorer_repository.dart';
import '../../purchase_orders/data/purchase_orders_repository.dart';
import '../../sales_invoices/data/sales_invoices_repository.dart';
import '../../sales_invoices/domain/sales_invoice.dart';
import '../../vendor_bills/data/vendor_bills_repository.dart';
import '../../vendor_bills/domain/vendor_bill.dart';
import '../../vendor_payments/data/vendor_payments_repository.dart';
import '../../vendor_statements/data/vendor_statements_repository.dart';
import '../domain/financial_dashboard.dart';

const _lowStockThreshold = 15;
const _netProfitFactor = 0.82;

abstract class FinancialDashboardRepository {
  Future<AppResult<FinancialDashboard>> fetchDashboard();
}

class MockFinancialDashboardRepository implements FinancialDashboardRepository {
  MockFinancialDashboardRepository({
    SalesInvoicesRepository? salesInvoicesRepository,
    CustomerPaymentsRepository? customerPaymentsRepository,
    CustomerStatementsRepository? customerStatementsRepository,
    VendorBillsRepository? vendorBillsRepository,
    VendorPaymentsRepository? vendorPaymentsRepository,
    VendorStatementsRepository? vendorStatementsRepository,
    InventoryRepository? inventoryRepository,
    PurchaseOrdersRepository? purchaseOrdersRepository,
    JournalExplorerRepository? journalExplorerRepository,
  }) : _salesInvoicesRepository =
           salesInvoicesRepository ?? MockSalesInvoicesRepository(),
       _customerPaymentsRepository =
           customerPaymentsRepository ?? MockCustomerPaymentsRepository(),
       _customerStatementsRepository =
           customerStatementsRepository ?? MockCustomerStatementsRepository(),
       _vendorBillsRepository =
           vendorBillsRepository ?? MockVendorBillsRepository(),
       _vendorPaymentsRepository =
           vendorPaymentsRepository ?? MockVendorPaymentsRepository(),
       _vendorStatementsRepository =
           vendorStatementsRepository ?? MockVendorStatementsRepository(),
       _inventoryRepository = inventoryRepository ?? MockInventoryRepository(),
       _purchaseOrdersRepository =
           purchaseOrdersRepository ?? MockPurchaseOrdersRepository(),
       _journalExplorerRepository =
           journalExplorerRepository ?? MockJournalExplorerRepository();

  final SalesInvoicesRepository _salesInvoicesRepository;
  final CustomerPaymentsRepository _customerPaymentsRepository;
  final CustomerStatementsRepository _customerStatementsRepository;
  final VendorBillsRepository _vendorBillsRepository;
  final VendorPaymentsRepository _vendorPaymentsRepository;
  final VendorStatementsRepository _vendorStatementsRepository;
  final InventoryRepository _inventoryRepository;
  final PurchaseOrdersRepository _purchaseOrdersRepository;
  final JournalExplorerRepository _journalExplorerRepository;

  @override
  Future<AppResult<FinancialDashboard>> fetchDashboard() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));

      final invoicesResult = await _salesInvoicesRepository
          .fetchSalesInvoices();
      final customerPaymentsResult = await _customerPaymentsRepository
          .fetchCustomerPayments();
      final vendorBillsResult = await _vendorBillsRepository.fetchVendorBills();
      final vendorPaymentsResult = await _vendorPaymentsRepository
          .fetchVendorPayments();
      final productsResult = await _inventoryRepository.fetchProducts();
      final warehousesResult = await _inventoryRepository.fetchWarehouses();
      final purchaseOrdersResult = await _purchaseOrdersRepository
          .fetchPurchaseOrders();
      final goodsReceiptsResult = await _purchaseOrdersRepository
          .fetchGoodsReceipts();
      final journalEntriesResult = await _journalExplorerRepository
          .fetchJournalEntries();

      if (!invoicesResult.isSuccess) {
        return AppResult.failure(
          invoicesResult.error ??
              const UnknownFailure(message: 'Unable to load sales invoices'),
        );
      }
      if (!customerPaymentsResult.isSuccess) {
        return AppResult.failure(
          customerPaymentsResult.error ??
              const UnknownFailure(message: 'Unable to load customer payments'),
        );
      }
      if (!vendorBillsResult.isSuccess) {
        return AppResult.failure(
          vendorBillsResult.error ??
              const UnknownFailure(message: 'Unable to load vendor bills'),
        );
      }
      if (!vendorPaymentsResult.isSuccess) {
        return AppResult.failure(
          vendorPaymentsResult.error ??
              const UnknownFailure(message: 'Unable to load vendor payments'),
        );
      }
      if (!productsResult.isSuccess) {
        return AppResult.failure(
          productsResult.error ??
              const UnknownFailure(message: 'Unable to load products'),
        );
      }
      if (!warehousesResult.isSuccess) {
        return AppResult.failure(
          warehousesResult.error ??
              const UnknownFailure(message: 'Unable to load warehouses'),
        );
      }
      if (!purchaseOrdersResult.isSuccess) {
        return AppResult.failure(
          purchaseOrdersResult.error ??
              const UnknownFailure(message: 'Unable to load purchase orders'),
        );
      }
      if (!goodsReceiptsResult.isSuccess) {
        return AppResult.failure(
          goodsReceiptsResult.error ??
              const UnknownFailure(message: 'Unable to load goods receipts'),
        );
      }
      if (!journalEntriesResult.isSuccess) {
        return AppResult.failure(
          journalEntriesResult.error ??
              const UnknownFailure(message: 'Unable to load journal entries'),
        );
      }

      final invoices = invoicesResult.data ?? const <SalesInvoice>[];
      final customerPayments = customerPaymentsResult.data ?? const [];
      final vendorBills = vendorBillsResult.data ?? const <VendorBill>[];
      final vendorPayments = vendorPaymentsResult.data ?? const [];
      final products = productsResult.data ?? const [];
      final warehouses = warehousesResult.data ?? const [];
      final purchaseOrders = purchaseOrdersResult.data ?? const [];
      final goodsReceipts = goodsReceiptsResult.data ?? const [];
      final journalEntries = journalEntriesResult.data ?? const [];

      final now = DateTime.now();
      final accountsReceivable = _buildAccountsReceivable(
        invoices,
        customerPayments,
        now,
      );
      final accountsPayable = _buildAccountsPayable(
        vendorBills,
        vendorPayments,
        now,
      );
      final inventory = _buildInventoryMetrics(products, warehouses);
      final cashPosition = _buildCashPosition(customerPayments, vendorPayments);
      final monthlyRevenue = _buildMonthlyRevenue(invoices, now);
      final monthlyExpenses = _buildMonthlyExpenses(vendorBills, now);
      final profitOverview = _buildProfitOverview(
        monthlyRevenue,
        monthlyExpenses,
      );
      final recentActivity = _buildRecentActivity(
        purchaseOrders: purchaseOrders,
        goodsReceipts: goodsReceipts,
        vendorBills: vendorBills,
        vendorPayments: vendorPayments,
        salesInvoices: invoices,
        customerPayments: customerPayments,
        journalEntries: journalEntries,
      );

      // Touch statement repositories so aggregation stays wired to them.
      await _customerStatementsRepository.fetchCustomerStatements();
      await _vendorStatementsRepository.fetchVendorStatements();

      return AppResult.success(
        FinancialDashboard(
          accountsReceivable: accountsReceivable,
          accountsPayable: accountsPayable,
          inventory: inventory,
          cashPosition: cashPosition,
          monthlyRevenue: monthlyRevenue,
          monthlyExpenses: monthlyExpenses,
          profitOverview: profitOverview,
          recentActivity: recentActivity,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  AccountsReceivableMetrics _buildAccountsReceivable(
    List<SalesInvoice> invoices,
    List<dynamic> payments,
    DateTime now,
  ) {
    final outstanding = invoices.where((invoice) => !_isPaid(invoice)).toList();
    final overdue = outstanding.where((invoice) => _isOverdue(invoice)).length;
    final receivedThisMonth = payments
        .where(
          (payment) =>
              payment.paymentDate.year == now.year &&
              payment.paymentDate.month == now.month,
        )
        .fold<double>(0, (sum, payment) => sum + (payment.amount as double));

    return AccountsReceivableMetrics(
      totalOutstandingInvoices: outstanding.length,
      overdueInvoices: overdue,
      amountReceivedThisMonth: receivedThisMonth,
    );
  }

  AccountsPayableMetrics _buildAccountsPayable(
    List<VendorBill> bills,
    List<dynamic> payments,
    DateTime now,
  ) {
    final outstanding = bills.where((bill) => !_isBillPaid(bill)).toList();
    final overdue = outstanding.where((bill) => _isBillOverdue(bill)).length;
    final paidThisMonth = payments
        .where(
          (payment) =>
              payment.paymentDate.year == now.year &&
              payment.paymentDate.month == now.month,
        )
        .fold<double>(0, (sum, payment) => sum + (payment.amount as double));

    return AccountsPayableMetrics(
      outstandingVendorBills: outstanding.length,
      overdueBills: overdue,
      paymentsMadeThisMonth: paidThisMonth,
    );
  }

  InventoryMetrics _buildInventoryMetrics(
    List<dynamic> products,
    List<dynamic> warehouses,
  ) {
    final lowStock = products
        .where((product) => product.stockOnHand <= _lowStockThreshold)
        .length;
    final totalStock = products.fold<double>(
      0,
      (sum, product) => sum + (product.stockOnHand as double),
    );

    return InventoryMetrics(
      productCount: products.length,
      lowStockProducts: lowStock,
      totalStockQuantity: totalStock,
      warehouseCount: warehouses.length,
    );
  }

  CashPosition _buildCashPosition(
    List<dynamic> customerPayments,
    List<dynamic> vendorPayments,
  ) {
    double cashIn = 0;
    double bankIn = 0;
    double cashOut = 0;
    double bankOut = 0;

    for (final payment in customerPayments) {
      if (payment.method.id == 'cash') {
        cashIn += payment.amount as double;
      } else if (payment.method.id == 'bank_transfer') {
        bankIn += payment.amount as double;
      }
    }

    for (final payment in vendorPayments) {
      if (payment.method.id == 'cash') {
        cashOut += payment.amount as double;
      } else if (payment.method.id == 'bank_transfer') {
        bankOut += payment.amount as double;
      }
    }

    const mockCashBase = 1250000;
    const mockBankBase = 8750000;
    final cash = mockCashBase + cashIn - cashOut;
    final bank = mockBankBase + bankIn - bankOut;

    return CashPosition(cash: cash, bank: bank, totalLiquidAssets: cash + bank);
  }

  List<MonthlyDataPoint> _buildMonthlyRevenue(
    List<SalesInvoice> invoices,
    DateTime now,
  ) {
    return _buildMonthlySeries(
      now,
      invoices.map(
        (invoice) => (date: invoice.invoiceDate, amount: invoice.total),
      ),
    );
  }

  List<MonthlyDataPoint> _buildMonthlyExpenses(
    List<VendorBill> bills,
    DateTime now,
  ) {
    return _buildMonthlySeries(
      now,
      bills.map((bill) => (date: bill.billDate, amount: _billTotal(bill))),
    );
  }

  List<MonthlyDataPoint> _buildMonthlySeries(
    DateTime now,
    Iterable<({DateTime date, double amount})> entries,
  ) {
    final months = _lastTwelveMonths(now);
    return months.map((monthStart) {
      final total = entries
          .where(
            (entry) =>
                entry.date.year == monthStart.year &&
                entry.date.month == monthStart.month,
          )
          .fold<double>(0, (sum, entry) => sum + entry.amount);
      return MonthlyDataPoint(
        year: monthStart.year,
        month: monthStart.month,
        amount: total,
      );
    }).toList();
  }

  ProfitOverview _buildProfitOverview(
    List<MonthlyDataPoint> revenue,
    List<MonthlyDataPoint> expenses,
  ) {
    final totalRevenue = revenue.fold<double>(
      0,
      (sum, point) => sum + point.amount,
    );
    final totalExpenses = expenses.fold<double>(
      0,
      (sum, point) => sum + point.amount,
    );
    final grossProfit = totalRevenue - totalExpenses;
    final netProfit = grossProfit * _netProfitFactor;

    return ProfitOverview(
      revenue: totalRevenue,
      expenses: totalExpenses,
      grossProfit: grossProfit,
      netProfit: netProfit,
    );
  }

  List<DashboardActivityItem> _buildRecentActivity({
    required List<dynamic> purchaseOrders,
    required List<dynamic> goodsReceipts,
    required List<dynamic> vendorBills,
    required List<dynamic> vendorPayments,
    required List<SalesInvoice> salesInvoices,
    required List<dynamic> customerPayments,
    required List<dynamic> journalEntries,
  }) {
    final items = <DashboardActivityItem>[];

    for (final order in purchaseOrders) {
      items.add(
        DashboardActivityItem(
          id: 'po-${order.id}',
          type: 'purchase_order',
          title: order.title as String,
          reference: order.reference as String,
          occurredAt: order.orderDate as DateTime,
        ),
      );
    }

    for (final receipt in goodsReceipts) {
      items.add(
        DashboardActivityItem(
          id: 'gr-${receipt.id}',
          type: 'goods_receipt',
          title: receipt.title as String,
          reference: receipt.reference as String,
          occurredAt: receipt.receivedAt as DateTime,
        ),
      );
    }

    for (final bill in vendorBills) {
      items.add(
        DashboardActivityItem(
          id: 'vb-${bill.id}',
          type: 'vendor_bill',
          title: bill.title,
          reference: bill.reference,
          occurredAt: bill.billDate,
          amount: _billTotal(bill),
        ),
      );
    }

    for (final payment in vendorPayments) {
      items.add(
        DashboardActivityItem(
          id: 'vp-${payment.id}',
          type: 'vendor_payment',
          title: payment.vendorName as String,
          reference: payment.reference as String,
          occurredAt: payment.paymentDate as DateTime,
          amount: payment.amount as double,
        ),
      );
    }

    for (final invoice in salesInvoices) {
      items.add(
        DashboardActivityItem(
          id: 'si-${invoice.id}',
          type: 'sales_invoice',
          title: invoice.title,
          reference: invoice.reference,
          occurredAt: invoice.invoiceDate,
          amount: invoice.total,
        ),
      );
    }

    for (final payment in customerPayments) {
      items.add(
        DashboardActivityItem(
          id: 'cp-${payment.id}',
          type: 'customer_payment',
          title: payment.customerName as String,
          reference: payment.reference as String,
          occurredAt: payment.paymentDate as DateTime,
          amount: payment.amount as double,
        ),
      );
    }

    for (final entry in journalEntries) {
      items.add(
        DashboardActivityItem(
          id: 'je-${entry.journalNumber}',
          type: 'journal_entry',
          title: entry.narration as String,
          reference: entry.journalNumber as String,
          occurredAt: entry.postingDate as DateTime,
          amount: entry.totalDebit as double,
        ),
      );
    }

    items.sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return List.unmodifiable(items);
  }

  bool _isPaid(SalesInvoice invoice) => invoice.status.id == 'paid';

  bool _isOverdue(SalesInvoice invoice) {
    if (_isPaid(invoice)) {
      return false;
    }
    return invoice.status.id == 'overdue' ||
        invoice.dueDate.isBefore(DateTime.now());
  }

  bool _isBillPaid(VendorBill bill) => bill.status.id == 'paid';

  bool _isBillOverdue(VendorBill bill) {
    if (_isBillPaid(bill)) {
      return false;
    }
    return bill.dueDate.isBefore(DateTime.now());
  }

  double _billTotal(VendorBill bill) {
    return bill.lines.fold<double>(
      0,
      (sum, line) => sum + (line.unitPrice * line.quantity),
    );
  }

  List<DateTime> _lastTwelveMonths(DateTime now) {
    return List.generate(12, (index) {
      final monthOffset = 11 - index;
      return DateTime(now.year, now.month - monthOffset);
    });
  }
}
