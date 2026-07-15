import 'package:accounting_app/features/financial_reports/presentation/financial_reports_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('financial reports page renders report sections', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const FinancialReportsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Financial Reports'), findsAtLeastNWidgets(1));
    expect(find.text('Trial Balance'), findsAtLeastNWidgets(1));
  });
}
