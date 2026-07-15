import 'package:flutter/foundation.dart';

enum FiscalYearStatus { active, archived }

@immutable
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

  FiscalYear copyWith({
    int? id,
    int? year,
    FiscalYearStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return FiscalYear(
      id: id ?? this.id,
      year: year ?? this.year,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FiscalYear &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          year == other.year &&
          status == other.status &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode =>
      id.hashCode ^
      year.hashCode ^
      status.hashCode ^
      startDate.hashCode ^
      endDate.hashCode;
}