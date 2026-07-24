import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';

abstract class WorkflowCondition {
  String get description;

  AppResult<bool> evaluate(Map<String, dynamic> context);
}

class MinValueCondition extends WorkflowCondition {
  final String field;
  final num minValue;

  MinValueCondition({required this.field, required this.minValue});

  @override
  String get description => 'Value of $field must be at least $minValue';

  @override
  AppResult<bool> evaluate(Map<String, dynamic> context) {
    final value = context[field];
    if (value is num) {
      return AppResult.success(value >= minValue);
    }
    return AppResult.failure(
      ValidationFailure(message: 'Field $field is not a number or missing'),
    );
  }
}

class MaxValueCondition extends WorkflowCondition {
  final String field;
  final num maxValue;

  MaxValueCondition({required this.field, required this.maxValue});

  @override
  String get description => 'Value of $field must be at most $maxValue';

  @override
  AppResult<bool> evaluate(Map<String, dynamic> context) {
    final value = context[field];
    if (value is num) {
      return AppResult.success(value <= maxValue);
    }
    return AppResult.failure(
      ValidationFailure(message: 'Field $field is not a number or missing'),
    );
  }
}

class FieldNotEmptyCondition extends WorkflowCondition {
  final String field;

  FieldNotEmptyCondition({required this.field});

  @override
  String get description => 'Field $field must not be empty';

  @override
  AppResult<bool> evaluate(Map<String, dynamic> context) {
    final value = context[field];
    if (value == null) return AppResult.success(false);
    if (value is String) return AppResult.success(value.isNotEmpty);
    return AppResult.success(true);
  }
}

class CompositeCondition extends WorkflowCondition {
  final List<WorkflowCondition> conditions;
  final bool requireAll;

  CompositeCondition({
    required this.conditions,
    this.requireAll = true,
  });

  @override
  String get description {
    final op = requireAll ? 'all' : 'any';
    return 'Must satisfy $op of: ${conditions.map((c) => c.description).join(', ')}';
  }

  @override
  AppResult<bool> evaluate(Map<String, dynamic> context) {
    for (final condition in conditions) {
      final result = condition.evaluate(context);
      if (!result.isSuccess) return result;
      final passed = result.data ?? false;
      if (requireAll && !passed) return AppResult.success(false);
      if (!requireAll && passed) return AppResult.success(true);
    }
    return AppResult.success(requireAll);
  }
}
