import 'kpi_definition.dart';
import 'time_period.dart';

class KpiValue {
  const KpiValue({
    required this.definition,
    required this.value,
    required this.period,
    this.previousValue,
    this.target,
  });

  final KpiDefinition definition;
  final double value;
  final TimePeriod period;
  final double? previousValue;
  final double? target;

  double? get varianceFromTarget {
    if (target == null) return null;
    return value - target!;
  }

  double? get variancePercentFromTarget {
    if (target == null || target == 0) return null;
    return ((value - target!) / target! * 100);
  }

  double? get periodOverPeriodChange {
    if (previousValue == null) return null;
    return value - previousValue!;
  }

  double? get periodOverPeriodPercentChange {
    if (previousValue == null || previousValue == 0) return null;
    return ((value - previousValue!) / previousValue! * 100);
  }

  String get formattedValue {
    if (definition.isPercentage) {
      return '${value.toStringAsFixed(definition.decimalPlaces)}%';
    }
    return value.toStringAsFixed(definition.decimalPlaces);
  }

  String get formattedChange {
    final change = periodOverPeriodPercentChange;
    if (change == null) return '';
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }

  @override
  String toString() =>
      'KpiValue(${definition.name}: $formattedValue, ${period.label})';
}
