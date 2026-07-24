import 'package:accounting_app/features/analytics/domain/kpi_definition.dart';
import 'package:accounting_app/features/analytics/domain/metric_trend.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';

import 'metric_calculator.dart';

class TrendAggregator {
  const TrendAggregator(this._calculator);

  final MetricCalculator _calculator;

  MetricTrend computeTrend({
    required KpiDefinition definition,
    required MetricSourceData data,
    required int months,
  }) {
    final periods = TimePeriod.lastMonths(months);
    final dataPoints = periods.map((period) {
      final prev = period.previous;
      return _calculator.calculateAll(data: data, period: period, previousPeriod: prev)
          .firstWhere((k) => k.definition.id == definition.id);
    }).toList();

    return MetricTrend(definition: definition, dataPoints: dataPoints);
  }

  Map<String, MetricTrend> computeAllTrends({
    required MetricSourceData data,
    required int months,
    List<String>? kpiIds,
  }) {
    final defs = kpiIds != null
        ? KpiDefinition.all.where((k) => kpiIds.contains(k.id))
        : KpiDefinition.all;

    final result = <String, MetricTrend>{};
    for (final def in defs) {
      result[def.id] = computeTrend(definition: def, data: data, months: months);
    }
    return result;
  }
}
