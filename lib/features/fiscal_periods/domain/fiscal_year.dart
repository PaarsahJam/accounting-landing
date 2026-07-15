// lib/features/fiscal_periods/domain/fiscal_year.dart

enum FiscalYearStatus { active, archived }

class FiscalYear {
  const FiscalYear({
    required this.id,
    required this.year,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  final int id;
  final int year;
  final FiscalYearStatus status;
  final DateTime startDate;
  final DateTime endDate;

  // Add necessary methods if needed.
}