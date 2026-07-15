import 'package:accounting_app/features/invoicing/presentation/invoices_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('invoices page shows add action', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const InvoicesPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Invoices'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
