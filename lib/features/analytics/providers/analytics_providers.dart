import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/analytics_repository.dart';
import '../domain/analytics_dashboard.dart';
import '../domain/kpi_value.dart';
import '../domain/metric_trend.dart';
import '../domain/time_period.dart';
import '../services/analytics_query_service.dart';
import '../services/metric_calculator.dart';

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return MockAnalyticsRepository();
});

final metricCalculatorProvider = Provider<MetricCalculator>((ref) {
  return const MetricCalculator();
});

final analyticsQueryServiceProvider = Provider<AnalyticsQueryService>((ref) {
  return AnalyticsQueryService(
    repository: ref.watch(analyticsRepositoryProvider),
  );
});

final analyticsDashboardProvider = FutureProvider.family<AnalyticsDashboard, TimePeriod>((ref, period) {
  final service = ref.watch(analyticsQueryServiceProvider);
  return service.loadDashboard(period: period);
});

final analyticsKpisProvider = FutureProvider.family<List<KpiValue>, TimePeriod>((ref, period) {
  final service = ref.watch(analyticsQueryServiceProvider);
  return service.loadKpis(period: period);
});

final analyticsTrendProvider = FutureProvider.family<MetricTrend, String>((ref, kpiId) {
  final service = ref.watch(analyticsQueryServiceProvider);
  return service.loadTrend(kpiId: kpiId, months: 12);
});

final currentPeriodProvider = Provider<TimePeriod>((ref) {
  final now = DateTime.now();
  return TimePeriod(year: now.year, month: now.month);
});
