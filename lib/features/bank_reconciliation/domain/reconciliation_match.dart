/// A match pairing between a bank statement transaction and an ERP entry.
class ReconciliationMatch {
  const ReconciliationMatch({
    required this.id,
    required this.statementTransactionId,
    required this.erpEntryId,
    required this.erpEntryLabel,
    required this.matchedAt,
    required this.isAutoMatched,
  });

  final String id;

  /// Id of the [BankStatementTransaction] being matched.
  final String statementTransactionId;

  /// Id of the ERP transaction / ledger entry.
  final String erpEntryId;

  /// Human-readable label for the ERP entry.
  final String erpEntryLabel;

  final DateTime matchedAt;

  /// Whether the match was created automatically.
  final bool isAutoMatched;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReconciliationMatch &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ReconciliationMatch(id: $id, txn: $statementTransactionId => erp: $erpEntryId)';
}
