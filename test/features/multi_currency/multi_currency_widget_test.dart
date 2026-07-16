import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/multi_currency/data/multi_currency_repository.dart';
import 'package:accounting_app/features/multi_currency/data/multi_currency_repository_provider.dart';
import 'package:accounting_app/features/multi_currency/presentation/currencies_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        multiCurrencyRepositoryProvider.overrideWithValue(
          MockMultiCurrencyRepository(
            auditRepository: MockAuditTrailRepository(),
          ),
        ),
      ],
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const CurrenciesPage(),
    ),
  );
}

void main() {
  testWidgets('CurrenciesPage renders page title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.textContaining('Currencies'), findsWidgets);
  });

  testWidgets('CurrenciesPage shows two tabs', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('Exchange Rates'), findsWidgets);
  });

  testWidgets('Currencies tab shows seeded currency codes', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('USD'), findsWidgets);
    expect(find.text('EUR'), findsWidgets);
  });

  testWidgets('Currencies tab shows BASE badge for USD', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('BASE'), findsWidgets);
  });

  testWidgets('Exchange Rates tab shows rates after switching', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Exchange Rates').last);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.currency_exchange), findsWidgets);
  });

  testWidgets('Exchange Rates tab shows edit icon', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Exchange Rates').last);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit_outlined), findsWidgets);
  });
}
