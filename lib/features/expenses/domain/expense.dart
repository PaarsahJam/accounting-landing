import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';

enum ExpenseStatus { draft, submitted, approved, rejected }

@freezed
abstract class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String merchant,
    required double amount,
    required String categoryId,
    required String paymentMethodId,
    required DateTime occurredAt,
    required String description,
    required List<String> attachmentIds,
    required ExpenseStatus status,
    required String businessId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    required bool isDeleted,
  }) = _Expense;
}
