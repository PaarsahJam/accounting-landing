import 'package:drift/drift.dart';

import 'app_database.dart';

class BankStatementDao extends DatabaseAccessor<AppDatabase> {
  BankStatementDao(super.db);

  $BankStatementTableTable get _statements => db.bankStatementTable;
  $BankStatementTransactionTableTable get _transactions =>
      db.bankStatementTransactionTable;

  Future<List<BankStatementTableData>> getAllStatements(String companyId) =>
      (select(_statements)..where((t) => t.companyId.equals(companyId))).get();

  Future<List<BankStatementTableData>> getStatementsForAccount(
    String bankAccountId,
    String companyId,
  ) =>
      (select(_statements)
            ..where((t) =>
                t.bankAccountId.equals(bankAccountId) &
                t.companyId.equals(companyId)))
          .get();

  Future<BankStatementTableData?> getStatementById(
    String id,
    String companyId,
  ) =>
      (select(_statements)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<List<BankStatementTransactionTableData>>
      getTransactionsByStatementId(
    String statementId,
    String companyId,
  ) =>
          (select(_transactions)
                ..where((t) =>
                    t.statementId.equals(statementId) &
                    t.companyId.equals(companyId)))
              .get();

  Future<int> insertStatement(BankStatementTableCompanion statement) =>
      into(_statements).insert(statement);

  Future<int> insertTransaction(
    BankStatementTransactionTableCompanion txn,
  ) =>
      into(_transactions).insert(txn);

  Future<int> updateStatement(
    BankStatementTableCompanion statement,
    String companyId,
  ) {
    final id = statement.id.value;
    return (update(_statements)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(statement);
  }

  Future<int> updateTransaction(
    BankStatementTransactionTableCompanion txn,
    String companyId,
  ) {
    final id = txn.id.value;
    return (update(_transactions)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(txn);
  }

  Future<int> deleteStatement(String id, String companyId) =>
      (delete(_statements)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  Future<int> deleteTransactionsByStatementId(
    String statementId,
    String companyId,
  ) =>
      (delete(_transactions)
            ..where((t) =>
                t.statementId.equals(statementId) &
                t.companyId.equals(companyId)))
          .go();
}
