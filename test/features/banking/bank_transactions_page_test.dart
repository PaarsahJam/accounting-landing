import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/banking/domain/bank_account.dart';
import 'package:accounting_app/features/banking/domain/bank_account_status.dart';
import 'package:accounting_app/features/banking/domain/bank_account_type.dart';
import 'package:accounting_app/features/banking/domain/bank_transaction_type.dart';
import 'package:accounting_app/features/banking/presentation/bank_transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/l10n/app_localizations.dart';

final _testAccount = BankAccount(
  id: 'BA-1001',
  name: 'Main Checking Account',
  accountNumber: '1234-5678-9012',
  accountType: BankAccountType.checking,
  currency: 'USD',
  currentBalance: 125450.0,
  status: BankAccountStatus.active,
  createdAt: DateTime(2024, 1, 1),
);

Widget _buildApp(MockBankingRepository repo) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [bankingRepositoryProvider.overrideWithValue(repo)],
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BankTransactionsPage(account: _testAccount),
    ),
  );
}

void main() {
  group('BankTransactionsPage', () {
    testWidgets('renders transactions after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Account balance header is shown
      expect(find.text('USD 125450.00'), findsOneWidget);
    });

    testWidgets('shows account number in summary', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pumpAndSettle();

      expect(find.text('1234-5678-9012'), findsOneWidget);
    });

    testWidgets('shows transaction cards', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('shows search filter row', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankingRepository()));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButton<BankTransactionType?>), findsOneWidget);
    });
  });
}
