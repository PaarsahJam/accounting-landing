// test/features/recurring_transactions/recurring_transactions_widget_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/recurring_transactions/data/recurring_transactions_repository.dart';
import 'package:accounting_app/features/recurring_transactions/data/recurring_transactions_repository_provider.dart';
import 'package:accounting_app/features/recurring_transactions/presentation/recurring_transactions_page.dart';
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
        recurringTransactionsRepositoryProvider.overrideWithValue(
          MockRecurringTransactionsRepository(
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
      home: const RecurringTransactionsPage(),
    ),
  );
}

void main() {
  testWidgets('RecurringTransactionsPage shows page title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Recurring'), findsWidgets);
  });

  testWidgets('RecurringTransactionsPage shows seeded transaction names', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Monthly Office Rent'), findsWidgets);
    expect(find.textContaining('Internet Subscription'), findsWidgets);
  });

  testWidgets('RecurringTransactionsPage shows ACTIVE badge', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('ACTIVE'), findsWidgets);
  });

  testWidgets('RecurringTransactionsPage shows INACTIVE badge for RT-004', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('INACTIVE'), findsWidgets);
  });

  testWidgets('RecurringTransactionsPage shows add button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsWidgets);
  });

  testWidgets('RecurringTransactionsPage shows execute-now button', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.play_circle_outline), findsWidgets);
  });
}
