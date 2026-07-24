import 'kpi_definition.dart';
import 'kpi_value.dart';
import 'time_period.dart';

enum TrendDirection { up, down, stable }

class MetricTrend {
  MetricTrend({
    required this.definition,
    required this.dataPoints,
  }) : _sorted = false;

  final KpiDefinition definition;
  final List<KpiValue> dataPoints;
  bool _sorted;

  List<KpiValue> get points {
    if (!_sorted) {
      dataPoints.sort((a, b) => a.period.label.compareTo(b.period.label));
      _sorted = true;
    }
    return dataPoints;
  }

  List<TimePeriod> get periods => points.map((p) => p.period).toList();
  List<double> get values => points.map((p) => p.value).toList();

  double? get min => points.isEmpty ? null : values.reduce((a, b) => a < b ? a : b);
  double? get max => points.isEmpty ? null : values.reduce((a, b) => a > b ? a : b);
  double? get avg {
    if (points.isEmpty) return null;
    return values.reduce((a, b) => a + b) / points.length;
  }

  TrendDirection get direction {
    if (points.length < 2) return TrendDirection.stable;
    final first = points.first.value;
    final last = points.last.value;
    final change = last - first;
    if (change.abs() < 0.01) return TrendDirection.stable;
    return change > 0 ? TrendDirection.up : TrendDirection.down;
  }

  double? get slope {
    if (points.length < 2) return null;
    final n = points.length;
    final xs = List.generate(n, (i) => i.toDouble());
    final ys = values;
    final sumX = xs.reduce((a, b) => a + b);
    final sumY = ys.reduce((a, b) => a + b);
    final sumXY = _zip(xs, ys).map((p) => p.$1 * p.$2).reduce((a, b) => a + b);
    final sumX2 = xs.map((x) => x * x).reduce((a, b) => a + b);
    return (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
  }
}

List<(double, double)> _zip(List<double> a, List<double> b) {
  final result = <(double, double)>[];
  for (var i = 0; i < a.length && i < b.length; i++) {
    result.add((a[i], b[i]));
  }
  return result;
}
