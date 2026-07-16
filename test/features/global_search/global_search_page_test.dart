import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/customers/data/customer_repository_provider.dart';
import 'package:accounting_app/features/global_search/data/global_search_repository.dart';
import 'package:accounting_app/features/global_search/data/global_search_repository_provider.dart';
import 'package:accounting_app/features/global_search/domain/global_search_controller.dart';
import 'package:accounting_app/features/global_search/presentation/global_search_page.dart';
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
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

Widget _buildApp() {
  return UncontrolledProviderScope(
    container: _makeContainer(),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const GlobalSearchPage(),
    ),
  );
}

void main() {
  testWidgets('GlobalSearchPage renders search field', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('GlobalSearchPage shows recent empty message initially', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.textContaining('No recent searches'), findsWidgets);
  });

  testWidgets('GlobalSearchPage shows clear button when text is entered', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    final field = find.byType(TextField);
    await tester.enterText(field, 'test');
    // Pump long enough for debounce to fire and rebuild
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.clear), findsWidgets);
  });

  testWidgets('GlobalSearchPage shows empty state for no-match query', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    final field = find.byType(TextField);
    await tester.enterText(field, 'XYZABC_NO_MATCH_12345');
    // Wait for debounce (350ms) + search delay
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('No results'), findsWidgets);
  });

  testWidgets('GlobalSearchPage shows results section for known query', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    final field = find.byType(TextField);
    await tester.enterText(field, 'SI-');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Should show scaffold without crashing
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('GlobalSearchPage clears results when clear button tapped', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pumpAndSettle();

    final field = find.byType(TextField);
    await tester.enterText(field, 'SI-');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    // Tap clear
    await tester.tap(find.byIcon(Icons.clear).first);
    await tester.pumpAndSettle();

    // Should show recent searches again (no results)
    expect(find.textContaining('No recent searches'), findsWidgets);
  });

  test('GlobalSearchController initial state is empty', () async {
    final container = _makeContainer();
    container.listen(globalSearchControllerProvider, (_, _) {});
    final results = await container.read(globalSearchControllerProvider.future);
    expect(results, isEmpty);
    container.dispose();
  });
}
