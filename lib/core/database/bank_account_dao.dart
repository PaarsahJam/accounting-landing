import 'package:drift/drift.dart';

import 'app_database.dart';

class BankAccountDao extends DatabaseAccessor<AppDatabase> {
  BankAccountDao(super.db);

  $BankAccountTableTable get _accounts => db.bankAccountTable;

  Future<List<BankAccountTableData>> getAllAccounts(String companyId) =>
      (select(_accounts)..where((t) => t.companyId.equals(companyId))).get();

  Future<BankAccountTableData?> getAccountById(String id, String companyId) =>
      (select(_accounts)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertAccount(BankAccountTableCompanion account) =>
      into(_accounts).insert(account);

  Future<int> updateAccount(
    BankAccountTableCompanion account,
    String companyId,
  ) {
    final id = account.id.value;
    return (update(_accounts)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(account);
  }

  Future<int> deleteAccount(String id, String companyId) =>
      (delete(_accounts)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();
}
