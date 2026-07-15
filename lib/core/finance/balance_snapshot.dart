import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_snapshot.freezed.dart';

@freezed
abstract class BalanceSnapshot with _$BalanceSnapshot {
  const factory BalanceSnapshot({
    required String periodId,
    required Map<String, double> balances,
  }) = _BalanceSnapshot;
}
