import 'package:freezed_annotation/freezed_annotation.dart';

import 'ledger_account.dart';
import 'ledger_account_type.dart';

part 'chart_of_accounts.freezed.dart';

@freezed
abstract class ChartOfAccounts with _$ChartOfAccounts {
  const factory ChartOfAccounts({required List<LedgerAccount> accounts}) =
      _ChartOfAccounts;

  const ChartOfAccounts._();

  static ChartOfAccounts mockDefault() {
    return ChartOfAccounts(
      accounts: const [
        LedgerAccount(
          id: '1',
          code: '1000',
          name: 'Cash',
          type: LedgerAccountType.asset,
          currency: 'USD',
          openingBalance: 0,
        ),
        LedgerAccount(
          id: '2',
          code: '2000',
          name: 'Accounts Payable',
          type: LedgerAccountType.liability,
          currency: 'USD',
          openingBalance: 0,
        ),
        LedgerAccount(
          id: '3',
          code: '3000',
          name: 'Equity',
          type: LedgerAccountType.equity,
          currency: 'USD',
          openingBalance: 0,
        ),
        LedgerAccount(
          id: '4',
          code: '4000',
          name: 'Revenue',
          type: LedgerAccountType.revenue,
          currency: 'USD',
          openingBalance: 0,
        ),
        LedgerAccount(
          id: '5',
          code: '5000',
          name: 'Expenses',
          type: LedgerAccountType.expense,
          currency: 'USD',
          openingBalance: 0,
        ),
      ],
    );
  }
}
