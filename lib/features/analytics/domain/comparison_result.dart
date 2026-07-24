import 'kpi_definition.dart';
import 'kpi_value.dart';
import 'time_period.dart';

enum ComparisonType { periodOverPeriod, budgetVsActual }

class ComparisonResult {
  const ComparisonResult({
    required this.definition,
    required this.type,
    required this.current,
    required this.previous,
  });

  final KpiDefinition definition;
  final ComparisonType type;
  final KpiValue current;
  final KpiValue previous;

  double get absoluteChange => current.value - previous.value;

  double? get percentChange {
    if (previous.value == 0) return null;
    return (absoluteChange / previous.value) * 100;
  }

  bool get isPositiveChange {
    if (definition.isHigherBetter) return absoluteChange >= 0;
    return absoluteChange <= 0;
  }

  static ComparisonResult periodOverPeriod({
    required KpiDefinition definition,
    required KpiValue current,
    required TimePeriod previousPeriod,
    double? previousValue,
  }) {
    return ComparisonResult(
      definition: definition,
      type: ComparisonType.periodOverPeriod,
      current: current,
      previous: KpiValue(
        definition: definition,
        value: previousValue ?? 0,
        period: previousPeriod,
      ),
    );
  }
}
