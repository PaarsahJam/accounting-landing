/// A single transaction line imported from a bank statement.
class BankStatementTransaction {
  const BankStatementTransaction({
    required this.id,
    required this.statementId,
    required this.date,
    required this.amount,
    required this.description,
    required this.reference,
    required this.isMatched,
    this.matchedErpEntryId,
    this.notes,
  });

  final String id;
  final String statementId;
  final DateTime date;

  /// Positive = credit to account, negative = debit.
  final double amount;
  final String description;
  final String reference;
  final bool isMatched;

  /// ERP ledger / transaction id this has been matched to.
  final String? matchedErpEntryId;
  final String? notes;

  bool get isCredit => amount >= 0;

  BankStatementTransaction copyWith({
    String? id,
    String? statementId,
    DateTime? date,
    double? amount,
    String? description,
    String? reference,
    bool? isMatched,
    Object? matchedErpEntryId = _sentinel,
    Object? notes = _sentinel,
  }) {
    return BankStatementTransaction(
      id: id ?? this.id,
      statementId: statementId ?? this.statementId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      isMatched: isMatched ?? this.isMatched,
      matchedErpEntryId: matchedErpEntryId == _sentinel
          ? this.matchedErpEntryId
          : matchedErpEntryId as String?,
      notes: notes == _sentinel ? this.notes : notes as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankStatementTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'BankStatementTransaction(id: $id, amount: $amount, matched: $isMatched)';
}

const _sentinel = Object();
