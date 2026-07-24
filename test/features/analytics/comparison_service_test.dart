import 'package:accounting_app/features/analytics/domain/comparison_result.dart';
import 'package:accounting_app/features/analytics/domain/kpi_definition.dart';
import 'package:accounting_app/features/analytics/domain/kpi_value.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';
import 'package:accounting_app/features/analytics/services/comparison_service.dart';
import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;

void main() {
  late ComparisonService service;
  late TimePeriod currentPeriod;
  late TimePeriod previousPeriod;

  setUp(() {
    service = const ComparisonService();
    currentPeriod = const TimePeriod(year: 2026, month: 2);
    previousPeriod = const TimePeriod(year: 2026, month: 1);
  });

  group('periodOverPeriod', () {
    test('creates ComparisonResult with correct values', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 16500,
        currentPeriod: currentPeriod,
        previousValue: 5500,
        previousPeriod: previousPeriod,
      );
      expect(result.type, ComparisonType.periodOverPeriod);
      expect(result.definition.id, 'revenue');
      expect(result.current.value, 16500);
      expect(result.previous.value, 5500);
    });

    test('absoluteChange is current minus previous', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 16500,
        currentPeriod: currentPeriod,
        previousValue: 5500,
        previousPeriod: previousPeriod,
      );
      expect(result.absoluteChange, 11000);
    });

    test('percentChange is (change / previous) * 100', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 16500,
        currentPeriod: currentPeriod,
        previousValue: 5500,
        previousPeriod: previousPeriod,
      );
      expect(result.percentChange, 200); // 11000/5500*100 = 200
    });

    test('percentChange is null when previous is 0', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 100,
        currentPeriod: currentPeriod,
        previousValue: 0,
        previousPeriod: previousPeriod,
      );
      expect(result.percentChange, isNull);
    });

    test('isPositiveChange is true when change is positive for higher-better KPIs', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 200,
        currentPeriod: currentPeriod,
        previousValue: 100,
        previousPeriod: previousPeriod,
      );
      expect(result.isPositiveChange, isTrue);
    });

    test('isPositiveChange is false when change is negative for higher-better KPIs', () {
      final result = service.periodOverPeriod(
        definition: KpiDefinition.revenue,
        currentValue: 50,
        currentPeriod: currentPeriod,
        previousValue: 100,
        previousPeriod: previousPeriod,
      );
      expect(result.isPositiveChange, isFalse);
    });
  });

  group('compareAll', () {
    test('compares matching KPIs from current and previous lists', () {
      final currentKpis = [
        KpiValue(definition: KpiDefinition.revenue, value: 16500, period: currentPeriod),
        KpiValue(definition: KpiDefinition.expenses, value: 1700, period: currentPeriod),
      ];
      final previousKpis = [
        KpiValue(definition: KpiDefinition.revenue, value: 5500, period: previousPeriod),
        KpiValue(definition: KpiDefinition.expenses, value: 2650, period: previousPeriod),
      ];

      final results = service.compareAll(
        currentKpis: currentKpis,
        previousKpis: previousKpis,
        currentPeriod: currentPeriod,
        previousPeriod: previousPeriod,
      );

      expect(results.length, 2);
      expect(results['revenue']!.absoluteChange, 11000);
      expect(results['expenses']!.absoluteChange, -950);
    });

    test('uses 0 for previous value when match not found', () {
      final currentKpis = [
        KpiValue(definition: KpiDefinition.revenue, value: 16500, period: currentPeriod),
      ];
      final results = service.compareAll(
        currentKpis: currentKpis,
        previousKpis: [],
        currentPeriod: currentPeriod,
        previousPeriod: previousPeriod,
      );
      expect(results['revenue']!.previous.value, 0);
    });
  });
}
