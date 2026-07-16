// lib/features/recurring_transactions/domain/recurring_transaction.dart

/// How often a recurring transaction fires.
enum RecurrenceFrequency {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly;

  String get label {
    switch (this) {
      case RecurrenceFrequency.daily:
        return 'Daily';
      case RecurrenceFrequency.weekly:
        return 'Weekly';
      case RecurrenceFrequency.monthly:
        return 'Monthly';
      case RecurrenceFrequency.quarterly:
        return 'Quarterly';
      case RecurrenceFrequency.yearly:
        return 'Yearly';
    }
  }
}

/// An immutable record describing a recurring transaction schedule.
class RecurringTransaction {
  const RecurringTransaction({
    required this.id,
    required this.name,
    required this.sourceDocumentId,
    required this.sourceDocumentType,
    required this.frequency,
    required this.nextRun,
    this.lastRun,
    this.isActive = true,
    this.notes,
  });

  /// Unique identifier.
  final String id;

  /// Human-readable name (e.g. "Monthly Office Rent").
  final String name;

  /// ID of the source template document.
  final String sourceDocumentId;

  /// Type label of the source document (e.g. "Vendor Bill").
  final String sourceDocumentType;

  /// How frequently this transaction recurs.
  final RecurrenceFrequency frequency;

  /// Date/time when this should fire next.
  final DateTime nextRun;

  /// Date/time when this last fired (null if never run).
  final DateTime? lastRun;

  /// Whether the schedule is active.
  final bool isActive;

  /// Optional free-form notes.
  final String? notes;

  RecurringTransaction copyWith({
    String? id,
    String? name,
    String? sourceDocumentId,
    String? sourceDocumentType,
    RecurrenceFrequency? frequency,
    DateTime? nextRun,
    DateTime? lastRun,
    bool? isActive,
    String? notes,
  }) {
    return RecurringTransaction(
      id: id ?? this.id,
      name: name ?? this.name,
      sourceDocumentId: sourceDocumentId ?? this.sourceDocumentId,
      sourceDocumentType: sourceDocumentType ?? this.sourceDocumentType,
      frequency: frequency ?? this.frequency,
      nextRun: nextRun ?? this.nextRun,
      lastRun: lastRun ?? this.lastRun,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RecurringTransaction($id, $name, $frequency)';
}
