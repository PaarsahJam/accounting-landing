import 'package:accounting_app/features/dashboard/presentation/dashboard_page.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository_provider.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('dashboard page renders financial overview sections', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          financialDashboardRepositoryProvider.overrideWithValue(
            MockFinancialDashboardRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const DashboardPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Accounting activity overview'), findsOneWidget);
    expect(find.text('Accounts Receivable'), findsOneWidget);
    expect(find.text('Accounts Payable'), findsOneWidget);
    expect(find.text('Inventory'), findsAtLeastNWidgets(1));
    expect(find.text('Cash Position'), findsOneWidget);
    expect(find.text('Monthly Revenue'), findsOneWidget);
    expect(find.text('Monthly Expenses'), findsOneWidget);
    expect(find.text('Profit Overview'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);
  });

  testWidgets('dashboard quick action navigates to sales invoices', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
        GoRoute(
          path: '/sales-invoices',
          builder: (context, state) =>
              const Scaffold(body: Text('Sales Invoices Page')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          financialDashboardRepositoryProvider.overrideWithValue(
            MockFinancialDashboardRepository(),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routerConfig: router,
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Create Sales Invoice'));
    await tester.pumpAndSettle();

    expect(find.text('Sales Invoices Page'), findsOneWidget);
  });

  testWidgets('dashboard quick action navigates to journal explorer', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
        GoRoute(
          path: '/journal-explorer',
          builder: (context, state) =>
              const Scaffold(body: Text('Journal Explorer Page')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          financialDashboardRepositoryProvider.overrideWithValue(
            MockFinancialDashboardRepository(),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routerConfig: router,
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('View Journal'));
    await tester.pumpAndSettle();

    expect(find.text('Journal Explorer Page'), findsOneWidget);
  });
}
