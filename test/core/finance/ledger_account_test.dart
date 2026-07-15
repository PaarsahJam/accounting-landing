import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/finance/ledger_account.dart';
import 'package:accounting_app/core/finance/ledger_account_type.dart';

void main() {
  test('create ledger account', () {
    final a = LedgerAccount(
      id: 'a1',
      code: '1000',
      name: 'Cash',
      type: LedgerAccountType.asset,
      currency: 'USD',
      openingBalance: 100.0,
      active: true,
    );
    expect(a.code, '1000');
    expect(a.type, LedgerAccountType.asset);
  });
}
