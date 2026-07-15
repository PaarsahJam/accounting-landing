import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'expense_repository.dart';

part 'expense_repository_provider.g.dart';

@riverpod
ExpenseRepository expenseRepository(Ref ref) {
  return MockExpenseRepository();
}
