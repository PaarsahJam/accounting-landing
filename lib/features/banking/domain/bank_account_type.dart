/// Account type for a bank / cash account.
enum BankAccountType {
  checking,
  savings,
  cash,
  creditCard;

  String get label {
    switch (this) {
      case BankAccountType.checking:
        return 'Checking';
      case BankAccountType.savings:
        return 'Savings';
      case BankAccountType.cash:
        return 'Cash';
      case BankAccountType.creditCard:
        return 'Credit Card';
    }
  }
}
