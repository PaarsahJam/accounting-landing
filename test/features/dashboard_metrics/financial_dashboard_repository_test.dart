import 'package:accounting_app/features/customer_payments/data/customer_payments_repository.dart';
import 'package:accounting_app/features/customer_statements/data/customer_statements_repository.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository.dart';
import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockFinancialDashboardRepository', () {
    late MockFinancialDashboardRepository repository;

    setUp(() {
      repository = MockFinancialDashboardRepository(
        salesInvoicesRepository: MockSalesInvoicesRepository(),
        customerPaymentsRepository: MockCustomerPaymentsRepository(),
        customerStatementsRepository: MockCustomerStatementsRepository(),
        vendorBillsRepository: MockVendorBillsRepository(),
        vendorPaymentsRepository: MockVendorPaymentsRepository(),
        vendorStatementsRepository: MockVendorStatementsRepository(),
        inventoryRepository: MockInventoryRepository(),
        purchaseOrdersRepository: MockPurchaseOrdersRepository(),
        journalExplorerRepository: MockJournalExplorerRepository(),
      );
    });

    test('fetches financial dashboard metrics', () async {
      final result = await repository.fetchDashboard();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
    });

    test('aggregates accounts receivable from sales invoices', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.accountsReceivable.totalOutstandingInvoices, 1);
      expect(result.data!.accountsReceivable.amountReceivedThisMonth, 0);
    });

    test('aggregates inventory metrics from inventory repository', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.inventory.productCount, 2);
      expect(result.data!.inventory.warehouseCount, 2);
      expect(result.data!.inventory.totalStockQuantity, 37);
    });

    test('builds monthly revenue for last 12 months', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.monthlyRevenue, hasLength(12));
    });

    test('builds monthly expenses for last 12 months', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.monthlyExpenses, hasLength(12));
    });

    test('combines recent activity from all sources', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.recentActivity, isNotEmpty);
      final dates = result.data!.recentActivity
          .map((item) => item.occurredAt)
          .toList();
      for (var i = 0; i < dates.length - 1; i++) {
        expect(
          dates[i].isAfter(dates[i + 1]) ||
              dates[i].isAtSameMomentAs(dates[i + 1]),
          isTrue,
        );
      }
    });

    test('calculates cash position from payment repositories', () async {
      final result = await repository.fetchDashboard();

      expect(result.data!.cashPosition.cash, greaterThanOrEqualTo(0));
      expect(result.data!.cashPosition.bank, greaterThanOrEqualTo(0));
      expect(
        result.data!.cashPosition.totalLiquidAssets,
        result.data!.cashPosition.cash + result.data!.cashPosition.bank,
      );
    });

    test('computes profit overview from revenue and expenses', () async {
      final result = await repository.fetchDashboard();
      final profit = result.data!.profitOverview;

      expect(profit.grossProfit, profit.revenue - profit.expenses);
      expect(profit.netProfit, lessThanOrEqualTo(profit.grossProfit));
    });
  });
}
