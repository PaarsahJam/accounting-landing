import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository.dart';
import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository_provider.dart';
import 'package:accounting_app/features/bank_reconciliation/presentation/bank_statements_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp(MockBankStatementRepository repo) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [bankStatementRepositoryProvider.overrideWithValue(repo)],
    ),
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: BankStatementsPage(),
    ),
  );
}

void main() {
  group('BankStatementsPage', () {
    testWidgets('renders statements after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // At least one card visible
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('shows account name on card', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pumpAndSettle();
      expect(find.text('Main Checking Account'), findsWidgets);
    });

    testWidgets('shows progress indicator on card', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pumpAndSettle();
      expect(find.byType(LinearProgressIndicator), findsWidgets);
    });

    testWidgets('shows status labels', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pumpAndSettle();
      // One of the status labels is visible
      expect(
        find.textContaining('Progress').evaluate().isNotEmpty ||
            find.textContaining('Reconciled').evaluate().isNotEmpty ||
            find.textContaining('Draft').evaluate().isNotEmpty,
        isTrue,
      );
    });
  });
}
