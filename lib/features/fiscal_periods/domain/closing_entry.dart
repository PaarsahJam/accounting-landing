// lib/features/fiscal_periods/domain/closing_entry.dart

class ClosingEntry {
  const ClosingEntry({
    required this.id,
    required this.accountCode,
    required this.amount,
  });

  final int id;
  final String accountCode;
  final double amount;

  // Add necessary methods if needed.
}
