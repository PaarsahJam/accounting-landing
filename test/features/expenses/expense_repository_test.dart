import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/expenses/data/expense_repository.dart';
import 'package:accounting_app/features/expenses/domain/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockExpenseRepository', () {
    late ExpenseRepository repository;

    setUp(() {
      repository = MockExpenseRepository();
    });

    test('returns a successful result with expense data', () async {
      final result = await repository.fetchExpenses();

      expect(result, isA<AppResult<List<Expense>>>());
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.error, isNull);
      expect(result.data!.first.businessId, isNotEmpty);
      expect(result.data!.first.createdAt, isA<DateTime>());
      expect(result.data!.first.updatedAt, isA<DateTime>());
    });

    test('returns successful categories and payment methods results', () async {
      final categoriesResult = await repository.fetchCategories();
      final paymentMethodsResult = await repository.fetchPaymentMethods();

      expect(categoriesResult.isSuccess, isTrue);
      expect(categoriesResult.data, isNotEmpty);
      expect(paymentMethodsResult.isSuccess, isTrue);
      expect(paymentMethodsResult.data, isNotEmpty);
    });
  });
}
