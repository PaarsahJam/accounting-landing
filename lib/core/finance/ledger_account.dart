import 'package:freezed_annotation/freezed_annotation.dart';

import 'ledger_account_type.dart';

part 'ledger_account.freezed.dart';

@freezed
abstract class LedgerAccount with _$LedgerAccount {
  const factory LedgerAccount({
    required String id,
    required String code,
    required String name,
    required LedgerAccountType type,
    required String currency,
    required double openingBalance,
    @Default(true) bool active,
  }) = _LedgerAccount;
}
