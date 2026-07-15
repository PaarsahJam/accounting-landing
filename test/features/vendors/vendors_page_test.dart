import 'package:accounting_app/features/vendors/presentation/vendors_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('vendors page renders vendor entries', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const VendorsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Vendors'), findsOneWidget);
    expect(find.text('Northwind Supplies'), findsOneWidget);
  });
}
