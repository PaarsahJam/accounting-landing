import 'package:accounting_app/features/analytics/domain/comparison_result.dart';
import 'package:accounting_app/features/analytics/domain/kpi_definition.dart';
import 'package:accounting_app/features/analytics/domain/kpi_value.dart';
import 'package:accounting_app/features/analytics/domain/metric_trend.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';
import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;

void main() {
  group('KpiValue', () {
    late KpiValue kpi;
    late TimePeriod period;

    setUp(() {
      period = const TimePeriod(year: 2026, month: 2);
      kpi = KpiValue(
        definition: KpiDefinition.revenue,
        value: 16500,
        period: period,
        previousValue: 5500,
        target: 20000,
      );
    });

    test('value accessors', () {
      expect(kpi.value, 16500);
      expect(kpi.definition.id, 'revenue');
      expect(kpi.period, period);
    });

    test('varianceFromTarget', () {
      expect(kpi.varianceFromTarget, -3500);
    });

    test('varianceFromTarget is null when no target', () {
      final k = KpiValue(definition: KpiDefinition.revenue, value: 100, period: period);
      expect(k.varianceFromTarget, isNull);
    });

    test('variancePercentFromTarget', () {
      expect(kpi.variancePercentFromTarget, closeTo(-17.5, 0.01));
    });

    test('variancePercentFromTarget is null when target is 0', () {
      final k = KpiValue(
        definition: KpiDefinition.revenue, value: 100, period: period, target: 0,
      );
      expect(k.variancePercentFromTarget, isNull);
    });

    test('periodOverPeriodChange', () {
      expect(kpi.periodOverPeriodChange, 11000);
    });

    test('periodOverPeriodChange is null without previousValue', () {
      final k = KpiValue(definition: KpiDefinition.revenue, value: 100, period: period);
      expect(k.periodOverPeriodChange, isNull);
    });

    test('periodOverPeriodPercentChange', () {
      expect(kpi.periodOverPeriodPercentChange, 200);
    });

    test('periodOverPeriodPercentChange is null when previousValue is 0', () {
      final k = KpiValue(
        definition: KpiDefinition.revenue, value: 100, period: period, previousValue: 0,
      );
      expect(k.periodOverPeriodPercentChange, isNull);
    });

    test('formattedValue for amount type', () {
      expect(kpi.formattedValue, '16500');
    });

    test('formattedValue for percentage type', () {
      final k = KpiValue(
        definition: KpiDefinition.grossMargin, value: 89.7, period: period,
      );
      expect(k.formattedValue, '89.7%');
    });

    test('formattedChange', () {
      expect(kpi.formattedChange, '+200.0%');
    });

    test('formattedChange is empty without previousValue', () {
      final k = KpiValue(definition: KpiDefinition.revenue, value: 100, period: period);
      expect(k.formattedChange, isEmpty);
    });

    test('toString includes name and value', () {
      final str = kpi.toString();
      expect(str, contains('Revenue'));
      expect(str, contains('16500'));
    });
  });

  group('ComparisonResult', () {
    test('periodOverPeriod factory creates correct result', () {
      final result = ComparisonResult.periodOverPeriod(
        definition: KpiDefinition.revenue,
        current: KpiValue(
          definition: KpiDefinition.revenue, value: 16500,
          period: const TimePeriod(year: 2026, month: 2),
        ),
        previousPeriod: const TimePeriod(year: 2026, month: 1),
        previousValue: 5500,
      );
      expect(result.type, ComparisonType.periodOverPeriod);
      expect(result.current.value, 16500);
      expect(result.previous.value, 5500);
    });

    test('absoluteChange', () {
      final result = ComparisonResult(
        definition: KpiDefinition.revenue,
        type: ComparisonType.periodOverPeriod,
        current: KpiValue(
          definition: KpiDefinition.revenue, value: 200,
          period: const TimePeriod(year: 2026, month: 2),
        ),
        previous: KpiValue(
          definition: KpiDefinition.revenue, value: 100,
          period: const TimePeriod(year: 2026, month: 1),
        ),
      );
      expect(result.absoluteChange, 100);
    });

    test('percentChange null when previous is 0', () {
      final result = ComparisonResult(
        definition: KpiDefinition.revenue,
        type: ComparisonType.periodOverPeriod,
        current: KpiValue(
          definition: KpiDefinition.revenue, value: 200,
          period: const TimePeriod(year: 2026, month: 2),
        ),
        previous: KpiValue(
          definition: KpiDefinition.revenue, value: 0,
          period: const TimePeriod(year: 2026, month: 1),
        ),
      );
      expect(result.percentChange, isNull);
    });

    test('isPositiveChange for higher-better when change positive', () {
      final result = ComparisonResult(
        definition: KpiDefinition.revenue,
        type: ComparisonType.periodOverPeriod,
        current: KpiValue(
          definition: KpiDefinition.revenue, value: 200,
          period: const TimePeriod(year: 2026, month: 2),
        ),
        previous: KpiValue(
          definition: KpiDefinition.revenue, value: 100,
          period: const TimePeriod(year: 2026, month: 1),
        ),
      );
      expect(result.isPositiveChange, isTrue);
    });

    test('isPositiveChange for lower-better when change negative', () {
      final result = ComparisonResult(
        definition: KpiDefinition.expenses,
        type: ComparisonType.periodOverPeriod,
        current: KpiValue(
          definition: KpiDefinition.expenses, value: 50,
          period: const TimePeriod(year: 2026, month: 2),
        ),
        previous: KpiValue(
          definition: KpiDefinition.expenses, value: 100,
          period: const TimePeriod(year: 2026, month: 1),
        ),
      );
      expect(result.isPositiveChange, isTrue);
    });
  });

  group('MetricTrend', () {
    test('direction is up when values increase', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue, value: 100,
            period: const TimePeriod(year: 2026, month: 1),
          ),
          KpiValue(
            definition: KpiDefinition.revenue, value: 200,
            period: const TimePeriod(year: 2026, month: 2),
          ),
        ],
      );
      expect(trend.direction, TrendDirection.up);
    });

    test('direction is down when values decrease', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue, value: 200,
            period: const TimePeriod(year: 2026, month: 1),
          ),
          KpiValue(
            definition: KpiDefinition.revenue, value: 100,
            period: const TimePeriod(year: 2026, month: 2),
          ),
        ],
      );
      expect(trend.direction, TrendDirection.down);
    });

    test('direction is stable with single point', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue, value: 100,
            period: const TimePeriod(year: 2026, month: 1),
          ),
        ],
      );
      expect(trend.direction, TrendDirection.stable);
    });

    test('points are sorted by period', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue, value: 100,
            period: const TimePeriod(year: 2026, month: 3),
          ),
          KpiValue(
            definition: KpiDefinition.revenue, value: 200,
            period: const TimePeriod(year: 2026, month: 1),
          ),
        ],
      );
      expect(trend.points[0].period.month, 1);
      expect(trend.points[1].period.month, 3);
    });

    test('min, max, avg', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue, value: 100,
            period: const TimePeriod(year: 2026, month: 1),
          ),
          KpiValue(
            definition: KpiDefinition.revenue, value: 300,
            period: const TimePeriod(year: 2026, month: 2),
          ),
          KpiValue(
            definition: KpiDefinition.revenue, value: 200,
            period: const TimePeriod(year: 2026, month: 3),
          ),
        ],
      );
      expect(trend.min, 100);
      expect(trend.max, 300);
      expect(trend.avg, 200);
    });

    test('min, max, avg are null for empty list', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue, dataPoints: [],
      );
      expect(trend.min, isNull);
      expect(trend.max, isNull);
      expect(trend.avg, isNull);
    });
  });

  group('TimePeriod', () {
    test('contains returns true for dates in same month/year', () {
      final period = const TimePeriod(year: 2026, month: 2);
      expect(period.contains(DateTime(2026, 2, 15)), isTrue);
      expect(period.contains(DateTime(2026, 2, 1)), isTrue);
    });

    test('contains returns false for dates outside month', () {
      final period = const TimePeriod(year: 2026, month: 2);
      expect(period.contains(DateTime(2026, 1, 31)), isFalse);
      expect(period.contains(DateTime(2026, 3, 1)), isFalse);
    });

    test('previous wraps year correctly', () {
      final jan = const TimePeriod(year: 2026, month: 1);
      expect(jan.previous, const TimePeriod(year: 2025, month: 12));
    });

    test('next wraps year correctly', () {
      final dec = const TimePeriod(year: 2026, month: 12);
      expect(dec.next, const TimePeriod(year: 2027, month: 1));
    });

    test('lastMonths returns correct count', () {
      final months = TimePeriod.lastMonths(3, reference: DateTime(2026, 3, 15));
      expect(months.length, 3);
      expect(months[0], const TimePeriod(year: 2026, month: 3));
      expect(months[1], const TimePeriod(year: 2026, month: 2));
      expect(months[2], const TimePeriod(year: 2026, month: 1));
    });

    test('start is first day of month', () {
      final period = const TimePeriod(year: 2026, month: 2);
      expect(period.start, DateTime(2026, 2, 1));
    });

    test('end is last day of month', () {
      final period = const TimePeriod(year: 2026, month: 2);
      expect(period.end.day, 28);
    });
  });
}
