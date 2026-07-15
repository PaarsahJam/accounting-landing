import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/category.dart';
import '../domain/expense.dart';
import '../domain/payment_method.dart';

abstract class ExpenseRepository {
  Future<AppResult<List<Expense>>> fetchExpenses();
  Future<AppResult<List<ExpenseCategory>>> fetchCategories();
  Future<AppResult<List<PaymentMethod>>> fetchPaymentMethods();
  Future<AppResult<Expense>> createExpense(Expense expense);
  Future<AppResult<Expense>> updateExpense(Expense expense);
  Future<AppResult<void>> deleteExpense(String id);
}

class MockExpenseRepository implements ExpenseRepository {
  final List<Expense> _expenses = [
    Expense(
      id: 'EXP-2001',
      merchant: 'Cloud Services',
      amount: 480000,
      categoryId: 'cat-software',
      paymentMethodId: 'pm-card',
      occurredAt: DateTime(2026, 6, 18),
      description: 'Cloud infrastructure subscription',
      attachmentIds: const ['att-001'],
      status: ExpenseStatus.submitted,
      businessId: 'biz-001',
      createdAt: DateTime(2026, 6, 18, 9, 0),
      updatedAt: DateTime(2026, 6, 18, 9, 0),
      createdBy: 'user-1',
      updatedBy: 'user-1',
      isDeleted: false,
    ),
    Expense(
      id: 'EXP-2002',
      merchant: 'Office Supplies',
      amount: 76000,
      categoryId: 'cat-operations',
      paymentMethodId: 'pm-cash',
      occurredAt: DateTime(2026, 6, 20),
      description: 'Office stationery order',
      attachmentIds: const [],
      status: ExpenseStatus.draft,
      businessId: 'biz-001',
      createdAt: DateTime(2026, 6, 20, 12, 30),
      updatedAt: DateTime(2026, 6, 20, 12, 30),
      createdBy: 'user-1',
      updatedBy: 'user-1',
      isDeleted: false,
    ),
  ];

  final List<ExpenseCategory> _categories = [
    const ExpenseCategory(
      id: 'cat-software',
      name: 'Software',
      color: 'blue',
      isActive: true,
    ),
    const ExpenseCategory(
      id: 'cat-operations',
      name: 'Operations',
      color: 'orange',
      isActive: true,
    ),
    const ExpenseCategory(
      id: 'cat-travel',
      name: 'Travel',
      color: 'green',
      isActive: true,
    ),
  ];

  final List<PaymentMethod> _paymentMethods = [
    const PaymentMethod(id: 'pm-card', name: 'Card', isDefault: true),
    const PaymentMethod(id: 'pm-cash', name: 'Cash', isDefault: false),
    const PaymentMethod(id: 'pm-transfer', name: 'Transfer', isDefault: false),
  ];

  @override
  Future<AppResult<List<Expense>>> fetchExpenses() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      final expenses = List<Expense>.from(
        _expenses.where((expense) => !expense.isDeleted),
      );
      return AppResult.success(expenses);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ExpenseCategory>>> fetchCategories() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(List<ExpenseCategory>.from(_categories));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<PaymentMethod>>> fetchPaymentMethods() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(List<PaymentMethod>.from(_paymentMethods));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Expense>> createExpense(Expense expense) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _expenses.add(expense);
      return AppResult.success(expense);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Expense>> updateExpense(Expense expense) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _expenses.indexWhere((item) => item.id == expense.id);
      if (index >= 0) {
        _expenses[index] = expense;
      } else {
        _expenses.add(expense);
      }
      return AppResult.success(expense);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteExpense(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _expenses.indexWhere((item) => item.id == id);
      if (index >= 0) {
        _expenses[index] = _expenses[index].copyWith(isDeleted: true);
      }
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
