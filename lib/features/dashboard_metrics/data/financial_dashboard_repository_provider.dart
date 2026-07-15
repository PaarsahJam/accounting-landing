import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../customer_payments/data/customer_payments_repository_provider.dart';
import '../../customer_statements/data/customer_statements_repository_provider.dart';
import '../../inventory/data/inventory_repository_provider.dart';
import '../../journal_explorer/data/journal_explorer_repository_provider.dart';
import '../../purchase_orders/data/purchase_orders_repository_provider.dart';
import '../../sales_invoices/data/sales_invoices_repository_provider.dart';
import '../../vendor_bills/data/vendor_bills_repository_provider.dart';
import '../../vendor_payments/data/vendor_payments_repository_provider.dart';
import '../../vendor_statements/data/vendor_statements_repository_provider.dart';
import 'financial_dashboard_repository.dart';

part 'financial_dashboard_repository_provider.g.dart';

@riverpod
FinancialDashboardRepository financialDashboardRepository(Ref ref) {
  return MockFinancialDashboardRepository(
    salesInvoicesRepository: ref.watch(salesInvoicesRepositoryProvider),
    customerPaymentsRepository: ref.watch(customerPaymentsRepositoryProvider),
    customerStatementsRepository: ref.watch(
      customerStatementsRepositoryProvider,
    ),
    vendorBillsRepository: ref.watch(vendorBillsRepositoryProvider),
    vendorPaymentsRepository: ref.watch(vendorPaymentsRepositoryProvider),
    vendorStatementsRepository: ref.watch(vendorStatementsRepositoryProvider),
    inventoryRepository: ref.watch(inventoryRepositoryProvider),
    purchaseOrdersRepository: ref.watch(purchaseOrdersRepositoryProvider),
    journalExplorerRepository: ref.watch(journalExplorerRepositoryProvider),
  );
}
