import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_impact.freezed.dart';

@freezed
abstract class FinancialImpact with _$FinancialImpact {
  const factory FinancialImpact({
    required String accountId,
    required String accountCode,
    required String accountName,
    required double debitAmount,
    required double creditAmount,
    required String currency,
    required String description,
  }) = _FinancialImpact;

  const FinancialImpact._();

  double get netAmount => debitAmount - creditAmount;

  bool get isZero => (debitAmount.abs() < 0.005) && (creditAmount.abs() < 0.005);
}