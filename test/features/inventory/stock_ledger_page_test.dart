import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:accounting_app/features/inventory/presentation/stock_ledger_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const testProduct = Product(
  id: 'P-1001',
  sku: 'SKU-1001',
  name: 'Laptop Stand',
  description: 'Ergonomic aluminum stand',
  categoryId: 'CAT-001',
  unitId: 'UOM-001',
  price: 89,
  stockOnHand: 12,
  active: true,
);

Widget _buildApp(MockInventoryRepository repo) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [inventoryRepositoryProvider.overrideWithValue(repo)],
    ),
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: StockLedgerPage(product: testProduct),
    ),
  );
}

void main() {
  testWidgets('StockLedgerPage renders with ledger data', (tester) async {
    await tester.pumpWidget(_buildApp(MockInventoryRepository()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // AppBar title contains product name
    expect(find.textContaining('Laptop'), findsWidgets);
  });

  testWidgets('StockLedgerPage shows summary bar', (tester) async {
    await tester.pumpWidget(_buildApp(MockInventoryRepository()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Balance'), findsWidgets);
  });
}
