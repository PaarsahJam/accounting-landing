class AccountingPeriod {
  final String id;
  final String label;
  final DateTime start;
  final DateTime end;

  const AccountingPeriod({
    required this.id,
    required this.label,
    required this.start,
    required this.end,
  });

  bool contains(DateTime d) => !d.isBefore(start) && !d.isAfter(end);

  @override
  String toString() =>
      '$label ($id): ${start.toIso8601String()} - ${end.toIso8601String()}';
}
