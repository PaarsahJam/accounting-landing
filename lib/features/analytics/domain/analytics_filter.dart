import 'kpi_definition.dart';

class AnalyticsFilter {
  const AnalyticsFilter({
    this.categories,
    this.kpiIds,
    this.from,
    this.to,
    this.dimension,
    this.dimensionValue,
  });

  final List<KpiCategory>? categories;
  final List<String>? kpiIds;
  final DateTime? from;
  final DateTime? to;
  final String? dimension;
  final String? dimensionValue;

  bool matches(KpiDefinition kpi) {
    if (categories != null && !categories!.contains(kpi.category)) return false;
    if (kpiIds != null && !kpiIds!.contains(kpi.id)) return false;
    return true;
  }

  static const none = AnalyticsFilter();
}
