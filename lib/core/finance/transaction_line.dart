import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_line.freezed.dart';

@freezed
abstract class TransactionLine with _$TransactionLine {
  const factory TransactionLine({
    required String accountId,
    required double amount,
    required String currency,
    String? description,
  }) = _TransactionLine;
}
