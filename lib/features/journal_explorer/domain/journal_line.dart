import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_line.freezed.dart';

@freezed
abstract class JournalLine with _$JournalLine {
  const factory JournalLine({
    required String accountCode,
    required String accountName,
    required double debit,
    required double credit,
    @Default('IRR') String currency,
    @Default('') String costCenter,
    @Default('') String notes,
  }) = _JournalLine;
}
