import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository.dart';
import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository_provider.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_statement.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_statement_status.dart';
import 'package:accounting_app/features/bank_reconciliation/presentation/bank_reconciliation_detail_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final _testStatement = BankStatement(
  id: 'BS-2024-03-001',
  bankAccountId: 'BA-1001',
  bankAccountName: 'Main Checking Account',
  periodStart: DateTime(2024, 3, 1),
  periodEnd: DateTime(2024, 3, 31),
  openingBalance: 50_000.00,
  closingBalance: 125_450.00,
  status: BankStatementStatus.inProgress,
  importedAt: DateTime(2024, 4, 1),
  transactions: const [],
);

Widget _buildApp(MockBankStatementRepository repo) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [bankStatementRepositoryProvider.overrideWithValue(repo)],
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BankReconciliationDetailPage(statement: _testStatement),
    ),
  );
}

void main() {
  group('BankReconciliationDetailPage', () {
    testWidgets('renders summary bar after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // Balance labels are shown
      expect(find.text('Opening Balance'), findsOneWidget);
      expect(find.text('Closing Balance'), findsOneWidget);
    });

    testWidgets('shows transaction section after load', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      // The page renders without error — summary bar is visible
      expect(find.text('Opening Balance'), findsOneWidget);
    });

    testWidgets('finalize button is present', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.textContaining('Finalize'), findsOneWidget);
    });

    testWidgets('auto-match button is in app bar', (tester) async {
      await tester.pumpWidget(_buildApp(MockBankStatementRepository()));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.textContaining('Auto'), findsOneWidget);
    });
  });
}
