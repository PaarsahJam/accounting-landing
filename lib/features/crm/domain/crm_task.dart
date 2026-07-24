import 'package:freezed_annotation/freezed_annotation.dart';

part 'crm_task.freezed.dart';

enum TaskPriority { low, medium, high, urgent }

enum TaskStatus { notStarted, inProgress, completed, cancelled }

@freezed
abstract class CrmTask with _$CrmTask {
  const factory CrmTask({
    required String id,
    required String customerId,
    String? contactId,
    required String title,
    required String description,
    required TaskStatus status,
    required TaskPriority priority,
    required DateTime dueDate,
    required String assignedTo,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _CrmTask;
}
