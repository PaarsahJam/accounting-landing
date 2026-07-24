import 'package:accounting_app/features/analytics/domain/kpi_definition.dart';
import 'package:accounting_app/features/analytics/domain/kpi_value.dart';
import 'package:accounting_app/features/analytics/domain/metric_trend.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';
import 'package:accounting_app/features/analytics/services/metric_calculator.dart';
import 'package:accounting_app/features/analytics/services/trend_aggregator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrendAggregator', () {
    late TrendAggregator aggregator;
    late MetricSourceData emptyData;

    setUp(() {
      aggregator = const TrendAggregator(MetricCalculator());
      emptyData = MetricSourceData();
    });

    test('computeTrend returns MetricTrend with correct definition', () {
      final trend = aggregator.computeTrend(
        definition: KpiDefinition.revenue,
        data: emptyData,
        months: 3,
      );
      expect(trend, isA<MetricTrend>());
      expect(trend.definition.id, 'revenue');
    });

    test('computeTrend returns data points for each month', () {
      final trend = aggregator.computeTrend(
        definition: KpiDefinition.revenue,
        data: emptyData,
        months: 6,
      );
      expect(trend.dataPoints.length, 6);
    });

    test('computeTrend data points are sorted by period', () {
      final trend = aggregator.computeTrend(
        definition: KpiDefinition.revenue,
        data: emptyData,
        months: 12,
      );
      final periods = trend.points.map((p) => p.period.label).toList();
      final sorted = List<String>.from(periods)..sort();
      expect(periods, sorted);
    });

    test('computeAllTrends returns all KPIs by default', () {
      final trends = aggregator.computeAllTrends(data: emptyData, months: 3);
      for (final def in KpiDefinition.all) {
        expect(trends, containsPair(def.id, isA<MetricTrend>()));
      }
    });

    test('computeAllTrends filters by kpiIds', () {
      final trends = aggregator.computeAllTrends(
        data: emptyData,
        months: 3,
        kpiIds: ['revenue', 'expenses'],
      );
      expect(trends.length, 2);
      expect(trends, containsPair('revenue', isA<MetricTrend>()));
      expect(trends, containsPair('expenses', isA<MetricTrend>()));
      expect(trends, isNot(contains('grossProfit')));
    });

    test('MetricTrend direction is stable for flat data', () {
      final trend = aggregator.computeTrend(
        definition: KpiDefinition.revenue,
        data: emptyData,
        months: 3,
      );
      expect(trend.direction, TrendDirection.stable);
    });

    test('MetricTrend min, max, avg', () {
      final trend = aggregator.computeTrend(
        definition: KpiDefinition.revenue,
        data: emptyData,
        months: 5,
      );
      expect(trend.min, 0);
      expect(trend.max, 0);
      expect(trend.avg, 0);
    });

    test('MetricTrend slope is null for single point', () {
      final trend = MetricTrend(
        definition: KpiDefinition.revenue,
        dataPoints: [
          KpiValue(
            definition: KpiDefinition.revenue,
            value: 100,
            period: const TimePeriod(year: 2026, month: 1),
          ),
        ],
      );
      expect(trend.slope, isNull);
    });
  });
}
