import 'dart:convert';

import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/expense_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/category.dart';
import '../domain/expense.dart';
import '../domain/payment_method.dart';
import 'expense_repository.dart';

/// Tenant-scoped Drift implementation of [ExpenseRepository].
class DriftExpenseRepository implements ExpenseRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final ExpenseDao _dao;

  DriftExpenseRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = ExpenseDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<Expense>>> fetchExpenses() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllExpenses(companyId);
      return AppResult.success(
        entries.map(_toDomain).where((e) => !e.isDeleted).toList(),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ExpenseCategory>>> fetchCategories() async {
    return AppResult.success(const []);
  }

  @override
  Future<AppResult<List<PaymentMethod>>> fetchPaymentMethods() async {
    return AppResult.success(const []);
  }

  @override
  Future<AppResult<Expense>> createExpense(Expense expense) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertExpense(_toCompanion(expense, companyId));
      return AppResult.success(expense);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Expense>> updateExpense(Expense expense) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateExpense(_toCompanion(expense, companyId), companyId);
      return AppResult.success(expense);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteExpense(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteExpense(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  Expense _toDomain(ExpenseTableData entry) {
    return Expense(
      id: entry.id,
      merchant: entry.merchant,
      amount: entry.amount,
      categoryId: entry.categoryId,
      paymentMethodId: entry.paymentMethodId,
      occurredAt: entry.occurredAt,
      description: entry.description,
      attachmentIds: (jsonDecode(entry.attachmentIds) as List)
          .cast<String>(),
      status: ExpenseStatus.values.firstWhere(
        (s) => s.name == entry.status,
        orElse: () => ExpenseStatus.draft,
      ),
      businessId: entry.businessId,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      createdBy: entry.createdBy,
      updatedBy: entry.updatedBy,
      isDeleted: entry.isDeleted,
    );
  }

  ExpenseTableCompanion _toCompanion(Expense expense, String companyId) {
    return ExpenseTableCompanion.insert(
      id: expense.id,
      companyId: companyId,
      merchant: expense.merchant,
      amount: expense.amount,
      categoryId: expense.categoryId,
      paymentMethodId: expense.paymentMethodId,
      occurredAt: expense.occurredAt,
      description: expense.description,
      attachmentIds: jsonEncode(expense.attachmentIds),
      status: expense.status.name,
      businessId: expense.businessId,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
      createdBy: expense.createdBy,
      updatedBy: expense.updatedBy,
      isDeleted: expense.isDeleted,
    );
  }
}
