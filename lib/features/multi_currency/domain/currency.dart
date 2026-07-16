/// An ISO 4217 currency supported by the application.
class Currency {
  const Currency({
    required this.isoCode,
    required this.name,
    required this.symbol,
    required this.decimalPlaces,
    this.isBase = false,
    this.isActive = true,
  });

  /// Three-letter ISO 4217 code (e.g. `'USD'`).
  final String isoCode;

  /// Full English name (e.g. `'US Dollar'`).
  final String name;

  /// Display symbol (e.g. `'\$'`, `'€'`, `'﷼'`).
  final String symbol;

  /// Number of decimal places (e.g. 2 for USD, 0 for IRR).
  final int decimalPlaces;

  /// Whether this is the system base currency.
  final bool isBase;

  /// Whether this currency is enabled for selection.
  final bool isActive;

  Currency copyWith({
    String? isoCode,
    String? name,
    String? symbol,
    int? decimalPlaces,
    bool? isBase,
    bool? isActive,
  }) {
    return Currency(
      isoCode: isoCode ?? this.isoCode,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isBase: isBase ?? this.isBase,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          isoCode == other.isoCode;

  @override
  int get hashCode => isoCode.hashCode;

  @override
  String toString() => 'Currency($isoCode, base: $isBase)';
}

/// The exchange rate from [fromCurrency] to [toCurrency] on [effectiveDate].
class ExchangeRate {
  const ExchangeRate({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.effectiveDate,
  });

  final String id;

  /// Source currency ISO code (typically the base currency).
  final String fromCurrency;

  /// Target currency ISO code.
  final String toCurrency;

  /// How many units of [toCurrency] equal one unit of [fromCurrency].
  final double rate;

  /// The date from which this rate is effective.
  final DateTime effectiveDate;

  ExchangeRate copyWith({
    String? id,
    String? fromCurrency,
    String? toCurrency,
    double? rate,
    DateTime? effectiveDate,
  }) {
    return ExchangeRate(
      id: id ?? this.id,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      rate: rate ?? this.rate,
      effectiveDate: effectiveDate ?? this.effectiveDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRate &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ExchangeRate($fromCurrency→$toCurrency @ $rate on $effectiveDate)';
}
