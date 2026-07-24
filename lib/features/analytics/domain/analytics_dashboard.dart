import 'kpi_definition.dart';
import 'kpi_value.dart';
import 'metric_trend.dart';
import 'comparison_result.dart';

class AnalyticsDashboard {
  const AnalyticsDashboard({
    required this.kpis,
    required this.trends,
    required this.comparisons,
  });

  final List<KpiValue> kpis;
  final Map<String, MetricTrend> trends;
  final Map<String, ComparisonResult> comparisons;

  KpiValue? kpi(String id) {
    for (final k in kpis) {
      if (k.definition.id == id) return k;
    }
    return null;
  }

  List<KpiValue> byCategory(KpiCategory category) {
    return kpis.where((k) => k.definition.category == category).toList();
  }

  static const empty = AnalyticsDashboard(kpis: [], trends: {}, comparisons: {});
}
