class Money {
  final double amount;
  final String currency;

  const Money(this.amount, {this.currency = 'USD'});

  Money operator +(Money other) {
    assert(currency == other.currency, 'Currency mismatch');
    return Money(amount + other.amount, currency: currency);
  }

  Money operator -(Money other) {
    assert(currency == other.currency, 'Currency mismatch');
    return Money(amount - other.amount, currency: currency);
  }

  Money operator *(double factor) => Money(amount * factor, currency: currency);

  Money operator /(double divisor) =>
      Money(amount / divisor, currency: currency);

  bool get isNegative => amount < 0;

  bool get isZero => amount == 0;

  @override
  String toString() => '${amount.toStringAsFixed(2)} $currency';

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Money &&
            runtimeType == other.runtimeType &&
            amount == other.amount &&
            currency == other.currency;
  }

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}
