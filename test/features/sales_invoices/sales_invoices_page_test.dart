import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository_provider.dart';
import 'package:accounting_app/features/sales_invoices/presentation/sales_invoices_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:accounting_app/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SalesInvoicesPage renders invoices', (tester) async {
    final container = ProviderContainer(
      overrides: [
        salesInvoicesRepositoryProvider.overrideWithValue(
          MockSalesInvoicesRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SalesInvoicesPage()),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('INV'), findsWidgets);
    container.dispose();
  });

  testWidgets('help button opens the invoice concept dialog',
      (tester) async {
    final container = ProviderContainer(
      overrides: [
        salesInvoicesRepositoryProvider.overrideWithValue(
          MockSalesInvoicesRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: SalesInvoicesPage(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    final helpButton = find.byIcon(Icons.help_outline);
    expect(helpButton, findsOneWidget);

    await tester.tap(helpButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.text(AppLocalizationsEn('en').conceptInvoiceTitle),
      findsWidgets,
    );

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);

    container.dispose();
  });
}
