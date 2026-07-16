/// Statement-level reconciliation status.
enum BankStatementStatus {
  draft,
  inProgress,
  reconciled,
  needsAttention;

  String get label {
    switch (this) {
      case BankStatementStatus.draft:
        return 'Draft';
      case BankStatementStatus.inProgress:
        return 'In Progress';
      case BankStatementStatus.reconciled:
        return 'Reconciled';
      case BankStatementStatus.needsAttention:
        return 'Needs Attention';
    }
  }
}
