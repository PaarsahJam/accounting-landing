import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/multi_currency/data/multi_currency_repository.dart';
import 'package:accounting_app/features/multi_currency/domain/currency.dart';
import 'package:flutter_test/flutter_test.dart';

MockMultiCurrencyRepository _makeRepo() =>
    MockMultiCurrencyRepository(auditRepository: MockAuditTrailRepository());

void main() {
  group('MockMultiCurrencyRepository', () {
    test('fetchCurrencies returns 5 seeded currencies', () async {
      final repo = _makeRepo();
      final result = await repo.fetchCurrencies();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(5));
    });

    test('USD is the base currency', () async {
      final repo = _makeRepo();
      final result = await repo.fetchCurrencies();
      final base = result.data!.firstWhere((c) => c.isBase);
      expect(base.isoCode, equals('USD'));
    });

    test('fetchExchangeRates returns 4 seeded rates', () async {
      final repo = _makeRepo();
      final result = await repo.fetchExchangeRates();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(4));
    });

    test('all rates are from USD', () async {
      final repo = _makeRepo();
      final result = await repo.fetchExchangeRates();
      expect(result.data!.every((r) => r.fromCurrency == 'USD'), isTrue);
    });

    test('updateExchangeRate updates rate value', () async {
      final repo = _makeRepo();
      final rates = (await repo.fetchExchangeRates()).data!;
      final target = rates.firstWhere((r) => r.toCurrency == 'EUR');

      final result = await repo.updateExchangeRate(target.id, 0.95);
      expect(result.isSuccess, isTrue);
      expect(result.data!.rate, equals(0.95));

      // Verify persisted
      final after = (await repo.fetchExchangeRates()).data!;
      expect(after.firstWhere((r) => r.id == target.id).rate, equals(0.95));
    });

    test('updateExchangeRate fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.updateExchangeRate('NO-SUCH', 1.0);
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('setBaseCurrency changes the base flag', () async {
      final repo = _makeRepo();
      final result = await repo.setBaseCurrency('EUR');
      expect(result.isSuccess, isTrue);
      expect(result.data!.isoCode, equals('EUR'));
      expect(result.data!.isBase, isTrue);

      final currencies = (await repo.fetchCurrencies()).data!;
      expect(currencies.firstWhere((c) => c.isoCode == 'EUR').isBase, isTrue);
      expect(currencies.firstWhere((c) => c.isoCode == 'USD').isBase, isFalse);
    });

    test('setBaseCurrency fails for unknown isoCode', () async {
      final repo = _makeRepo();
      final result = await repo.setBaseCurrency('XYZ');
      expect(result.isSuccess, isFalse);
    });
  });

  group('Currency model', () {
    test('equality is by isoCode', () {
      const a = Currency(isoCode: 'USD', name: 'A', symbol: '\$', decimalPlaces: 2);
      const b = Currency(isoCode: 'USD', name: 'B', symbol: '€', decimalPlaces: 0);
      const c = Currency(isoCode: 'EUR', name: 'A', symbol: '\$', decimalPlaces: 2);
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('copyWith preserves unchanged fields', () {
      const orig = Currency(
        isoCode: 'USD',
        name: 'US Dollar',
        symbol: '\$',
        decimalPlaces: 2,
        isBase: true,
      );
      final copy = orig.copyWith(isBase: false);
      expect(copy.isoCode, equals('USD'));
      expect(copy.isBase, isFalse);
      expect(copy.decimalPlaces, equals(2));
    });

    test('isActive defaults to true', () {
      const c = Currency(isoCode: 'USD', name: 'X', symbol: '\$', decimalPlaces: 2);
      expect(c.isActive, isTrue);
    });
  });

  group('ExchangeRate model', () {
    test('equality is by id', () {
      final r1 = ExchangeRate(
        id: 'FX-1',
        fromCurrency: 'USD',
        toCurrency: 'EUR',
        rate: 0.9,
        effectiveDate: _epoch,
      );
      final r2 = ExchangeRate(
        id: 'FX-1',
        fromCurrency: 'USD',
        toCurrency: 'GBP',
        rate: 0.8,
        effectiveDate: _epoch,
      );
      expect(r1, equals(r2));
    });

    test('copyWith changes rate', () {
      final r = ExchangeRate(
        id: 'FX-1',
        fromCurrency: 'USD',
        toCurrency: 'EUR',
        rate: 0.9,
        effectiveDate: _epoch,
      );
      final copy = r.copyWith(rate: 0.95);
      expect(copy.rate, equals(0.95));
      expect(copy.toCurrency, equals('EUR'));
    });
  });
}

final _epoch = DateTime.utc(2026);
