/// Lifecycle status of a bank account.
enum BankAccountStatus {
  active,
  inactive,
  frozen;

  String get label {
    switch (this) {
      case BankAccountStatus.active:
        return 'Active';
      case BankAccountStatus.inactive:
        return 'Inactive';
      case BankAccountStatus.frozen:
        return 'Frozen';
    }
  }
}
