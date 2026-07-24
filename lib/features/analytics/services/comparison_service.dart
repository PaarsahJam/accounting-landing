import '../domain/comparison_result.dart';
import '../domain/kpi_definition.dart';
import '../domain/kpi_value.dart';
import '../domain/time_period.dart';

class ComparisonService {
  const ComparisonService();

  ComparisonResult periodOverPeriod({
    required KpiDefinition definition,
    required double currentValue,
    required TimePeriod currentPeriod,
    required double previousValue,
    required TimePeriod previousPeriod,
  }) {
    return ComparisonResult.periodOverPeriod(
      definition: definition,
      current: KpiValue(
        definition: definition,
        value: currentValue,
        period: currentPeriod,
      ),
      previousPeriod: previousPeriod,
      previousValue: previousValue,
    );
  }

  Map<String, ComparisonResult> compareAll({
    required List<KpiValue> currentKpis,
    required List<KpiValue> previousKpis,
    required TimePeriod currentPeriod,
    required TimePeriod previousPeriod,
  }) {
    final result = <String, ComparisonResult>{};
    for (final current in currentKpis) {
      final prev = _findMatch(current.definition.id, previousKpis);
      result[current.definition.id] = ComparisonResult.periodOverPeriod(
        definition: current.definition,
        current: current,
        previousPeriod: previousPeriod,
        previousValue: prev?.value ?? 0,
      );
    }
    return result;
  }

  KpiValue? _findMatch(String id, List<KpiValue> kpis) {
    for (final k in kpis) {
      if (k.definition.id == id) return k;
    }
    return null;
  }
}
