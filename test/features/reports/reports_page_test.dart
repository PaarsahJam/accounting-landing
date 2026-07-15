import 'package:accounting_app/features/reports/presentation/reports_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('reports page shows available reports and period selector', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const ReportsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Reports'), findsAtLeastNWidgets(1));
    expect(find.text('Profit & Loss'), findsAtLeastNWidgets(1));
    expect(find.text('Balance Sheet'), findsAtLeastNWidgets(1));
    expect(find.text('Period'), findsAtLeastNWidgets(1));
    expect(find.text('Supported filters'), findsOneWidget);
    expect(find.text('Export options'), findsOneWidget);
    expect(find.textContaining('PDF'), findsAtLeastNWidgets(1));
  });
}
