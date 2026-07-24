import 'package:accounting_app/features/analytics/domain/analytics_dashboard.dart';
import 'package:accounting_app/features/analytics/domain/analytics_filter.dart';
import 'package:accounting_app/features/analytics/domain/kpi_value.dart';
import 'package:accounting_app/features/analytics/domain/metric_trend.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';

import '../data/analytics_repository.dart';
import '../domain/kpi_definition.dart';
import 'metric_calculator.dart';
import 'trend_aggregator.dart';
import 'comparison_service.dart';

class AnalyticsQueryService {
  AnalyticsQueryService({
    required AnalyticsRepository repository,
    MetricCalculator? calculator,
    TrendAggregator? trendAggregator,
    ComparisonService? comparisonService,
  })  : _repo = repository,
        _calculator = calculator ?? const MetricCalculator(),
        _comparisonService = comparisonService ?? const ComparisonService(),
        _trendAggregator = trendAggregator ?? TrendAggregator(MetricCalculator());

  final AnalyticsRepository _repo;
  final MetricCalculator _calculator;
  final TrendAggregator _trendAggregator;
  final ComparisonService _comparisonService;

  Future<AnalyticsDashboard> loadDashboard({
    required TimePeriod period,
    AnalyticsFilter filter = AnalyticsFilter.none,
  }) async {
    final sourceData = await _repo.fetchSourceData(filter: filter);
    final previousPeriod = period.previous;

    final kpis = _calculator.calculateAll(
      data: sourceData,
      period: period,
      previousPeriod: previousPeriod,
    );

    final filtered = kpis.where((k) => filter.matches(k.definition)).toList();

    final trends = _trendAggregator.computeAllTrends(
      data: sourceData,
      months: 12,
      kpiIds: filtered.map((k) => k.definition.id).toList(),
    );

    final previousKpis = _calculator.calculateAll(
      data: sourceData,
      period: previousPeriod,
    );
    final comparisons = _comparisonService.compareAll(
      currentKpis: filtered,
      previousKpis: previousKpis,
      currentPeriod: period,
      previousPeriod: previousPeriod,
    );

    return AnalyticsDashboard(
      kpis: filtered,
      trends: trends,
      comparisons: comparisons,
    );
  }

  Future<List<KpiValue>> loadKpis({
    required TimePeriod period,
    List<String>? kpiIds,
    TimePeriod? previousPeriod,
  }) async {
    final sourceData = await _repo.fetchSourceData();
    final prev = previousPeriod ?? period.previous;
    final all = _calculator.calculateAll(data: sourceData, period: period, previousPeriod: prev);
    if (kpiIds == null) return all;
    return all.where((k) => kpiIds.contains(k.definition.id)).toList();
  }

  Future<MetricTrend> loadTrend({
    required String kpiId,
    required int months,
  }) async {
    final sourceData = await _repo.fetchSourceData();
    final def = KpiDefinition.all.firstWhere((k) => k.id == kpiId);
    return _trendAggregator.computeTrend(
      definition: def,
      data: sourceData,
      months: months,
    );
  }
}
