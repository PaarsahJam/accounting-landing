import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/banking/presentation/bank_accounts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

Widget _buildApp(MockBankingRepository repo) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [bankingRepositoryProvider.overrideWithValue(repo)],
    ),
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: BankAccountsPage(),
    ),
  );
}

void main() {
  group('BankAccountsPage', () {
    testWidgets('renders bank accounts after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.textContaining('Account'), findsWidgets);
    });

    testWidgets('shows search field after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('shows bank account names', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pumpAndSettle();

      expect(find.text('Main Checking Account'), findsOneWidget);
    });

    testWidgets('shows balance values', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pumpAndSettle();

      // balance displayed on first account
      expect(find.textContaining('125450'), findsWidgets);
    });
  });
}
