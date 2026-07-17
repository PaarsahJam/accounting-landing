import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/currency.dart';

abstract class MultiCurrencyRepository {
  Future<AppResult<List<Currency>>> fetchCurrencies();
  Future<AppResult<List<ExchangeRate>>> fetchExchangeRates();
  Future<AppResult<ExchangeRate>> updateExchangeRate(
    String rateId,
    double newRate,
  );
  Future<AppResult<Currency>> setBaseCurrency(String isoCode);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock
// ─────────────────────────────────────────────────────────────────────────────

class MockMultiCurrencyRepository implements MultiCurrencyRepository {
  MockMultiCurrencyRepository({AuditTrailRepository? auditRepository})
    : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<Currency> _currencies = [];
  final List<ExchangeRate> _rates = [];
  void _seed() {
    _currencies.addAll([
      const Currency(
        isoCode: 'USD',
        name: 'US Dollar',
        symbol: '\$',
        decimalPlaces: 2,
        isBase: true,
      ),
      const Currency(
        isoCode: 'EUR',
        name: 'Euro',
        symbol: '€',
        decimalPlaces: 2,
      ),
      const Currency(
        isoCode: 'GBP',
        name: 'British Pound',
        symbol: '£',
        decimalPlaces: 2,
      ),
      const Currency(
        isoCode: 'AED',
        name: 'UAE Dirham',
        symbol: 'د.إ',
        decimalPlaces: 2,
      ),
      const Currency(
        isoCode: 'IRR',
        name: 'Iranian Rial',
        symbol: '﷼',
        decimalPlaces: 0,
      ),
    ]);

    final today = DateTime(2026, 1, 1);
    _rates.addAll([
      ExchangeRate(
        id: 'FX-2026-0001',
        fromCurrency: 'USD',
        toCurrency: 'EUR',
        rate: 0.92,
        effectiveDate: today,
      ),
      ExchangeRate(
        id: 'FX-2026-0002',
        fromCurrency: 'USD',
        toCurrency: 'GBP',
        rate: 0.79,
        effectiveDate: today,
      ),
      ExchangeRate(
        id: 'FX-2026-0003',
        fromCurrency: 'USD',
        toCurrency: 'AED',
        rate: 3.67,
        effectiveDate: today,
      ),
      ExchangeRate(
        id: 'FX-2026-0004',
        fromCurrency: 'USD',
        toCurrency: 'IRR',
        rate: 42000.0,
        effectiveDate: today,
      ),
    ]);
  }

  @override
  Future<AppResult<List<Currency>>> fetchCurrencies() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_currencies));
  }

  @override
  Future<AppResult<List<ExchangeRate>>> fetchExchangeRates() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_rates));
  }

  @override
  Future<AppResult<ExchangeRate>> updateExchangeRate(
    String rateId,
    double newRate,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _rates.indexWhere((r) => r.id == rateId);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Exchange rate not found'),
      );
    }
    final old = _rates[idx];
    final updated = old.copyWith(rate: newRate, effectiveDate: DateTime.now());
    _rates[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-FX-$rateId',
        entityType: AuditEntityType.financialReport,
        entityId: rateId,
        entityLabel: '${old.fromCurrency}→${old.toCurrency}',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Exchange rate updated',
        previousValue: old.rate.toString(),
        newValue: newRate.toString(),
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<Currency>> setBaseCurrency(String isoCode) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _currencies.indexWhere((c) => c.isoCode == isoCode);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Currency not found'),
      );
    }
    final old = _currencies.firstWhere(
      (c) => c.isBase,
      orElse: () => _currencies[0],
    );

    for (var i = 0; i < _currencies.length; i++) {
      _currencies[i] = _currencies[i].copyWith(
        isBase: _currencies[i].isoCode == isoCode,
      );
    }

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-FX-BASE-$isoCode',
        entityType: AuditEntityType.financialReport,
        entityId: isoCode,
        entityLabel: 'Base Currency',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Base currency changed from ${old.isoCode} to $isoCode',
        previousValue: old.isoCode,
        newValue: isoCode,
      ),
    );

    return AppResult.success(_currencies[idx]);
  }
}
