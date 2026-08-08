import 'package:accounting_app/features/guidance/domain/concept.dart';
import 'package:accounting_app/features/guidance/presentation/contextual_tip_trigger.dart';
import 'package:accounting_app/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn('en');

  List<String> ids(String route, Set<String> dismissed) =>
      buildContextualTipsForRoute(route, dismissed, l10n).map((t) => t.id).toList();

  test('dashboard offers receivable then profit tips', () {
    expect(ids('/dashboard', {}), ['receivable', 'profit']);
  });

  test('dismissed concepts are filtered out of the tips', () {
    expect(ids('/dashboard', {'receivable'}), ['profit']);
    expect(ids('/dashboard', {'receivable', 'profit'}), isEmpty);
  });

  test('sales routes map to the invoice concept', () {
    expect(ids('/sales-invoices', {}), ['invoice']);
    expect(ids('/invoices', {}), ['invoice']);
  });

  test('payment routes map to the payment concept', () {
    expect(ids('/customer-payments', {}), ['payment']);
    expect(ids('/vendor-payments', {}), ['payment']);
  });

  test('bank reconciliation route maps to its concept', () {
    expect(ids('/bank-reconciliation', {}), [ConceptIds.bankReconciliation]);
  });

  test('untargeted routes produce no tips', () {
    expect(ids('/settings', {}), isEmpty);
    expect(ids('/unknown', {}), isEmpty);
  });
}
