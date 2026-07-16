// lib/features/fiscal_periods/domain/fiscal_period.dart

enum FiscalPeriodStatus { open, closed, locked }

class FiscalPeriod {
  const FiscalPeriod({
    required this.id,
    required this.fiscalYearId,
    required this.periodNumber,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  final int id;
  final int fiscalYearId;
  final int periodNumber;
  final DateTime startDate;
  final DateTime endDate;
  final FiscalPeriodStatus status;

  // Add necessary methods if needed.
}
