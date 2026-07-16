/// Type of a bank transaction entry.
enum BankTransactionType {
  deposit,
  withdrawal,
  transfer,
  interest,
  bankFee,
  adjustment;

  String get label {
    switch (this) {
      case BankTransactionType.deposit:
        return 'Deposit';
      case BankTransactionType.withdrawal:
        return 'Withdrawal';
      case BankTransactionType.transfer:
        return 'Transfer';
      case BankTransactionType.interest:
        return 'Interest';
      case BankTransactionType.bankFee:
        return 'Bank Fee';
      case BankTransactionType.adjustment:
        return 'Adjustment';
    }
  }
}
