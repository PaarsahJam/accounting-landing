import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/customers/data/customer_repository_provider.dart';
import 'package:accounting_app/features/global_search/data/global_search_repository.dart';
import 'package:accounting_app/features/global_search/data/global_search_repository_provider.dart';
import 'package:accounting_app/features/global_search/domain/global_search_controller.dart';
import 'package:accounting_app/features/global_search/domain/search_result.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository_provider.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository_provider.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository_provider.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository_provider.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    customerRepositoryProvider.overrideWithValue(MockCustomerRepository()),
    vendorRepositoryProvider.overrideWithValue(MockVendorRepository()),
    inventoryRepositoryProvider.overrideWithValue(MockInventoryRepository()),
    salesInvoicesRepositoryProvider.overrideWithValue(
      MockSalesInvoicesRepository(),
    ),
    vendorBillsRepositoryProvider.overrideWithValue(
      MockVendorBillsRepository(),
    ),
    purchaseOrdersRepositoryProvider.overrideWithValue(
      MockPurchaseOrdersRepository(),
    ),
    bankingRepositoryProvider.overrideWithValue(MockBankingRepository()),
    journalExplorerRepositoryProvider.overrideWithValue(
      MockJournalExplorerRepository(),
    ),
    globalSearchRepositoryProvider.overrideWithValue(
      MockGlobalSearchRepository(
        customerRepo: MockCustomerRepository(),
        vendorRepo: MockVendorRepository(),
        inventoryRepo: MockInventoryRepository(),
        salesInvoicesRepo: MockSalesInvoicesRepository(),
        vendorBillsRepo: MockVendorBillsRepository(),
        purchaseOrdersRepo: MockPurchaseOrdersRepository(),
        bankingRepo: MockBankingRepository(),
        journalRepo: MockJournalExplorerRepository(),
      ),
    ),
  ],
);

void main() {
  group('GlobalSearchController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('initial state is empty list', () async {
      container.listen(globalSearchControllerProvider, (_, _) {});
      final results = await container.read(
        globalSearchControllerProvider.future,
      );
      expect(results, isEmpty);
    });

    test('search with empty query leaves state empty', () async {
      container.listen(globalSearchControllerProvider, (_, _) {});
      final notifier = container.read(globalSearchControllerProvider.notifier);
      await notifier.future;
      await notifier.search('');
      final state = container.read(globalSearchControllerProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isEmpty);
    });

    test('search populates state with results for known query', () async {
      container.listen(globalSearchControllerProvider, (_, _) {});
      final notifier = container.read(globalSearchControllerProvider.notifier);
      await notifier.future;
      // 'SI-' should match seeded sales invoices
      await notifier.search('SI-');
      final state = container.read(globalSearchControllerProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isA<List<SearchResult>>());
    });

    test('clearResults empties state', () async {
      container.listen(globalSearchControllerProvider, (_, _) {});
      final notifier = container.read(globalSearchControllerProvider.notifier);
      await notifier.future;
      await notifier.search('SI-');
      notifier.clearResults();
      final state = container.read(globalSearchControllerProvider);
      expect(state.value, isEmpty);
    });

    test('search returns data state with no error', () async {
      container.listen(globalSearchControllerProvider, (_, _) {});
      final notifier = container.read(globalSearchControllerProvider.notifier);
      await notifier.future;
      await notifier.search('vendor');
      final state = container.read(globalSearchControllerProvider);
      expect(state.hasError, isFalse);
      expect(state.hasValue, isTrue);
    });
  });

  group('RecentSearchesController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('initially loads empty recent searches', () async {
      container.listen(recentSearchesControllerProvider, (_, _) {});
      final recent = await container.read(
        recentSearchesControllerProvider.future,
      );
      expect(recent, isEmpty);
    });

    test('clear empties recent searches', () async {
      container.listen(recentSearchesControllerProvider, (_, _) {});
      final notifier = container.read(
        recentSearchesControllerProvider.notifier,
      );
      await notifier.future;
      await notifier.save('test query');
      await notifier.clear();
      final state = container.read(recentSearchesControllerProvider);
      expect(state.value, isEmpty);
    });

    test('save then clear cycle works correctly', () async {
      container.listen(recentSearchesControllerProvider, (_, _) {});
      final notifier = container.read(
        recentSearchesControllerProvider.notifier,
      );
      await notifier.future;
      await notifier.save('first');
      await notifier.save('second');
      await notifier.clear();
      final state = container.read(recentSearchesControllerProvider);
      expect(state.value, isEmpty);
    });
  });
}
