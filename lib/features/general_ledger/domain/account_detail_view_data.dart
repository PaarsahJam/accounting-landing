import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/ledger_account.dart';

part 'account_detail_view_data.freezed.dart';

@freezed
abstract class AccountDetailViewData with _$AccountDetailViewData {
  const factory AccountDetailViewData({
    required LedgerAccount account,
    required List<AccountTransactionView> transactions,
    required double currentBalance,
  }) = _AccountDetailViewData;
}

@freezed
abstract class AccountTransactionView with _$AccountTransactionView {
  const factory AccountTransactionView({
    required JournalEntry entry,
    required double amount,
    required bool isDebit,
    required String description,
  }) = _AccountTransactionView;
}
