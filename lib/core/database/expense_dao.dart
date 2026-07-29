import 'package:drift/drift.dart';

import 'app_database.dart';

class ExpenseDao extends DatabaseAccessor<AppDatabase> {
  ExpenseDao(super.db);

  $ExpenseTableTable get _expenses => db.expenseTable;

  Future<List<ExpenseTableData>> getAllExpenses(String companyId) =>
      (select(_expenses)..where((t) => t.companyId.equals(companyId))).get();

  Future<ExpenseTableData?> getExpenseById(String id, String companyId) =>
      (select(_expenses)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertExpense(ExpenseTableCompanion expense) =>
      into(_expenses).insert(expense);

  Future<int> updateExpense(ExpenseTableCompanion expense, String companyId) {
    final id = expense.id.value;
    return (update(_expenses)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(expense);
  }

  Future<int> deleteExpense(String id, String companyId) =>
      (delete(_expenses)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();
}
