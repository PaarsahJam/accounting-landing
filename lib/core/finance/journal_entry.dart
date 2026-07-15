import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction_line.dart';

part 'journal_entry.freezed.dart';

@freezed
abstract class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    required String id,
    required DateTime date,
    required String reference,
    required List<TransactionLine> lines,
    String? memo,
  }) = _JournalEntry;

  const JournalEntry._();

  double get total => lines.fold<double>(0, (sum, l) => sum + l.amount);

  bool get isBalanced {
    if (lines.isEmpty) {
      return false;
    }

    final roundedTotal = (total * 100).roundToDouble() / 100;
    return roundedTotal.abs() < 0.005;
  }

  void validate() {
    if (!isBalanced) {
      throw ArgumentError('JournalEntry is not balanced. Total: $total');
    }
  }
}
