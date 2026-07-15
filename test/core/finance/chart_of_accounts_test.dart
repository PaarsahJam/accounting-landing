import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/finance/chart_of_accounts.dart';

void main() {
  test('mock default chart has accounts', () {
    final chart = ChartOfAccounts.mockDefault();
    expect(chart.accounts, isNotEmpty);
  });
}
