import 'package:accounting_app/core/ai/ai_providers.dart';
import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/customers/data/customer_repository_provider.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository_provider.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository_provider.dart';
import 'package:accounting_app/features/invoicing/data/invoice_repository.dart';
import 'package:accounting_app/features/invoicing/data/invoice_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        invoiceRepositoryProvider.overrideWithValue(MockInvoiceRepository()),
        customerRepositoryProvider.overrideWithValue(MockCustomerRepository()),
        generalLedgerRepositoryProvider.overrideWithValue(
          MockGeneralLedgerRepository(),
        ),
        financialDashboardRepositoryProvider.overrideWithValue(
          MockFinancialDashboardRepository(),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('dashboard query builds an overview context', () async {
    final liveContext = container.read(aiLiveContextProvider);
    final context = await liveContext.contextForQuery(
      'How is my business doing this month?',
    );

    expect(context, contains('Business Overview'));
    expect(context, contains('Revenue'));
    expect(context, contains('Net Profit'));
    expect(context, contains('Accounts Receivable'));
  });

  test('invoice query builds an invoice context', () async {
    final liveContext = container.read(aiLiveContextProvider);
    final context = await liveContext.contextForQuery(
      'Summarize my sales invoices',
    );

    expect(context, contains('Sales Invoices'));
    expect(context, contains('INV-1001'));
    expect(context, contains('Total Amount'));
  });

  test('customer query builds a customer context', () async {
    final liveContext = container.read(aiLiveContextProvider);
    final context = await liveContext.contextForQuery(
      'Which customers still owe money?',
    );

    expect(context, contains('Customers'));
    expect(context, contains('Ava Rahimi'));
    expect(context, contains('Total Outstanding Balance'));
  });

  test('ledger query builds a ledger context', () async {
    final liveContext = container.read(aiLiveContextProvider);
    final context = await liveContext.contextForQuery(
      'Show me the general ledger and trial balance',
    );

    expect(context, contains('General Ledger'));
    expect(context, contains('Accounts'));
    expect(context, contains('Recent Journal Entries'));
  });
}
