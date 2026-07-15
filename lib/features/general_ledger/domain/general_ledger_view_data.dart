import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/finance/balance_snapshot.dart';
import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/ledger_account.dart';

part 'general_ledger_view_data.freezed.dart';

@freezed
abstract class GeneralLedgerViewData with _$GeneralLedgerViewData {
  const factory GeneralLedgerViewData({
    required List<LedgerAccount> accounts,
    required List<JournalEntry> entries,
    required BalanceSnapshot snapshot,
    required List<TrialBalanceLine> trialBalance,
  }) = _GeneralLedgerViewData;
}

@freezed
abstract class TrialBalanceLine with _$TrialBalanceLine {
  const factory TrialBalanceLine({
    required LedgerAccount account,
    required double debit,
    required double credit,
  }) = _TrialBalanceLine;
}
