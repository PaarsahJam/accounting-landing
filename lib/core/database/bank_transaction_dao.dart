import 'package:drift/drift.dart';

import 'app_database.dart';

class BankTransactionDao extends DatabaseAccessor<AppDatabase> {
  BankTransactionDao(super.db);

  $BankTransactionTableTable get _transactions => db.bankTransactionTable;

  Future<List<BankTransactionTableData>> getTransactionsByAccount(
    String accountId,
    String companyId,
  ) =>
      (select(_transactions)
            ..where((t) =>
                t.accountId.equals(accountId) &
                t.companyId.equals(companyId)))
          .get();

  Future<BankTransactionTableData?> getTransactionById(
    String id,
    String companyId,
  ) =>
      (select(_transactions)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertTransaction(BankTransactionTableCompanion txn) =>
      into(_transactions).insert(txn);

  Future<int> updateTransaction(
    BankTransactionTableCompanion txn,
    String companyId,
  ) {
    final id = txn.id.value;
    return (update(_transactions)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(txn);
  }

  Future<int> deleteTransaction(String id, String companyId) =>
      (delete(_transactions)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  Future<List<BankTransactionTableData>> getAllTransactions(
    String companyId,
  ) =>
      (select(_transactions)
            ..where((t) => t.companyId.equals(companyId)))
          .get();
}
