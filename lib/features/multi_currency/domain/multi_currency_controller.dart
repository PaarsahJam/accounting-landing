import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/multi_currency_repository_provider.dart';
import '../domain/currency.dart';

part 'multi_currency_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Currencies controller
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class CurrenciesController extends _$CurrenciesController {
  @override
  FutureOr<List<Currency>> build() async {
    final repo = ref.watch(multiCurrencyRepositoryProvider);
    final result = await repo.fetchCurrencies();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load currencies', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<bool> setBase(String isoCode) async {
    try {
      final repo = ref.read(multiCurrencyRepositoryProvider);
      final result = await repo.setBaseCurrency(isoCode);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to set base currency', error: result.error);
        return false;
      }
      // Reload to reflect updated isBase flags
      ref.invalidateSelf();
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error setting base currency', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Exchange rates controller
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class ExchangeRatesController extends _$ExchangeRatesController {
  @override
  FutureOr<List<ExchangeRate>> build() async {
    final repo = ref.watch(multiCurrencyRepositoryProvider);
    final result = await repo.fetchExchangeRates();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load exchange rates', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<ExchangeRate>?> updateRate(
    String rateId,
    double newRate,
  ) async {
    try {
      final repo = ref.read(multiCurrencyRepositoryProvider);
      final result = await repo.updateExchangeRate(rateId, newRate);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to update exchange rate',
          error: result.error,
        );
        return result;
      }
      _replaceInState(result.data!);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error updating exchange rate', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  void _replaceInState(ExchangeRate updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((r) => r.id == updated.id ? updated : r).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Convenience: base currency derived provider
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
Currency? baseCurrency(Ref ref) {
  final currencies = ref.watch(currenciesControllerProvider).value;
  if (currencies == null) return null;
  try {
    return currencies.firstWhere((c) => c.isBase);
  } catch (_) {
    return null;
  }
}
