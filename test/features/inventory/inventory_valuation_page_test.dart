import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/presentation/inventory_valuation_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
      home: InventoryValuationPage(),
    ),
  );
}

void main() {
  testWidgets('InventoryValuationPage renders valuation data', (tester) async {
    await tester.pumpWidget(_buildApp(MockInventoryRepository()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Summary bar values rendered
    expect(find.textContaining('Total Value'), findsWidgets);
  });

  testWidgets('InventoryValuationPage shows product cards', (tester) async {
    await tester.pumpWidget(_buildApp(MockInventoryRepository()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // At least one product name visible (e.g. Laptop Stand)
    expect(find.textContaining('Laptop'), findsWidgets);
  });
}
