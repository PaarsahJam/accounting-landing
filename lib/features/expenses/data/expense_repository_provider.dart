import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_expense_repository.dart';
import 'expense_repository.dart';

part 'expense_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ExpenseRepository expenseRepository(Ref ref) {
  final repo = DriftExpenseRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
