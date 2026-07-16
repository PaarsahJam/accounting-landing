import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/banking/data/banking_repository_provider.dart';
import '../../../features/customers/data/customer_repository_provider.dart';
import '../../../features/inventory/data/inventory_repository_provider.dart';
import '../../../features/journal_explorer/data/journal_explorer_repository_provider.dart';
import '../../../features/purchase_orders/data/purchase_orders_repository_provider.dart';
import '../../../features/sales_invoices/data/sales_invoices_repository_provider.dart';
import '../../../features/vendor_bills/data/vendor_bills_repository_provider.dart';
import '../../../features/vendors/data/vendor_repository_provider.dart';
import 'global_search_repository.dart';

part 'global_search_repository_provider.g.dart';

@riverpod
GlobalSearchRepository globalSearchRepository(Ref ref) {
  return MockGlobalSearchRepository(
    customerRepo: ref.watch(customerRepositoryProvider),
    vendorRepo: ref.watch(vendorRepositoryProvider),
    inventoryRepo: ref.watch(inventoryRepositoryProvider),
    salesInvoicesRepo: ref.watch(salesInvoicesRepositoryProvider),
    vendorBillsRepo: ref.watch(vendorBillsRepositoryProvider),
    purchaseOrdersRepo: ref.watch(purchaseOrdersRepositoryProvider),
    bankingRepo: ref.watch(bankingRepositoryProvider),
    journalRepo: ref.watch(journalExplorerRepositoryProvider),
  );
}
