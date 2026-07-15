class TrialBalanceEntry {
  final int accountId;
  final String accountName;
  final double debit;
  final double credit;

  TrialBalanceEntry({
    required this.accountId,
    required this.accountName,
    required this.debit,
    required this.credit,
  });
}
