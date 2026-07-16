import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/multi_currency/data/multi_currency_repository.dart';
import 'package:accounting_app/features/multi_currency/data/multi_currency_repository_provider.dart';
import 'package:accounting_app/features/multi_currency/domain/multi_currency_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    multiCurrencyRepositoryProvider.overrideWithValue(
      MockMultiCurrencyRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

void main() {
  group('CurrenciesController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads 5 seeded currencies', () async {
      container.listen(currenciesControllerProvider, (_, _) {});
      final currencies = await container.read(currenciesControllerProvider.future);
      expect(currencies.length, equals(5));
    });

    test('setBase changes base currency and invalidates', () async {
      container.listen(currenciesControllerProvider, (_, _) {});
      final notifier = container.read(currenciesControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.setBase('EUR');
      expect(success, isTrue);

      // After invalidateSelf, reload
      final after = await container.read(currenciesControllerProvider.future);
      expect(after.firstWhere((c) => c.isoCode == 'EUR').isBase, isTrue);
    });

    test('setBase returns false for unknown isoCode', () async {
      container.listen(currenciesControllerProvider, (_, _) {});
      final notifier = container.read(currenciesControllerProvider.notifier);
      await notifier.future;
      final success = await notifier.setBase('XYZ');
      expect(success, isFalse);
    });
  });

  group('ExchangeRatesController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads 4 seeded rates', () async {
      container.listen(exchangeRatesControllerProvider, (_, _) {});
      final rates = await container.read(exchangeRatesControllerProvider.future);
      expect(rates.length, equals(4));
    });

    test('updateRate updates rate in state', () async {
      container.listen(exchangeRatesControllerProvider, (_, _) {});
      final notifier = container.read(exchangeRatesControllerProvider.notifier);
      final initial = await notifier.future;
      final target = initial.firstWhere((r) => r.toCurrency == 'GBP');

      final result = await notifier.updateRate(target.id, 0.80);
      expect(result!.isSuccess, isTrue);

      final state = container.read(exchangeRatesControllerProvider).value!;
      expect(state.firstWhere((r) => r.id == target.id).rate, equals(0.80));
    });

    test('updateRate returns failure for unknown id', () async {
      container.listen(exchangeRatesControllerProvider, (_, _) {});
      final notifier = container.read(exchangeRatesControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.updateRate('NO-SUCH', 1.0);
      expect(result!.isSuccess, isFalse);
    });
  });

  group('baseCurrencyProvider', () {
    test('returns USD as base currency', () async {
      final container = _makeContainer();
      container.listen(currenciesControllerProvider, (_, _) {});
      await container.read(currenciesControllerProvider.future);

      final base = container.read(baseCurrencyProvider);
      expect(base?.isoCode, equals('USD'));
      container.dispose();
    });
  });
}
