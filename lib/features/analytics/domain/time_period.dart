class TimePeriod {
  const TimePeriod({
    required this.year,
    required this.month,
  });

  final int year;
  final int month;

  DateTime get start => DateTime(year, month, 1);
  DateTime get end => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  String get label => '$year/${month.toString().padLeft(2, '0')}';

  bool contains(DateTime date) {
    return date.year == year && date.month == month;
  }

  TimePeriod get previous {
    if (month == 1) return TimePeriod(year: year - 1, month: 12);
    return TimePeriod(year: year, month: month - 1);
  }

  TimePeriod get next {
    if (month == 12) return TimePeriod(year: year + 1, month: 1);
    return TimePeriod(year: year, month: month + 1);
  }

  static List<TimePeriod> lastMonths(int count, {DateTime? reference}) {
    final ref = reference ?? DateTime.now();
    final result = <TimePeriod>[];
    for (var i = 0; i < count; i++) {
      final m = ref.month - i;
      if (m >= 1) {
        result.add(TimePeriod(year: ref.year, month: m));
      } else {
        result.add(TimePeriod(year: ref.year - 1, month: 12 + m));
      }
    }
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimePeriod && year == other.year && month == other.month;

  @override
  int get hashCode => Object.hash(year, month);

  @override
  String toString() => 'TimePeriod($label)';
}
