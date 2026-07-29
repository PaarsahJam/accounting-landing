import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/bank_account_dao.dart';
import '../../../core/database/bank_transaction_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/bank_account.dart';
import '../domain/bank_account_status.dart';
import '../domain/bank_account_type.dart';
import '../domain/bank_transaction.dart';
import '../domain/bank_transaction_type.dart';
import 'banking_repository.dart';

/// Tenant-scoped Drift implementation of [BankingRepository].
class DriftBankingRepository implements BankingRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final BankAccountDao _accountDao;
  late final BankTransactionDao _transactionDao;

  DriftBankingRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _accountDao = BankAccountDao(_database);
    _transactionDao = BankTransactionDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<BankAccount>>> fetchAccounts() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _accountDao.getAllAccounts(companyId);
      return AppResult.success(entries.map(_toAccountDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankAccount>> fetchAccount(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entry = await _accountDao.getAccountById(id, companyId);
      if (entry == null) {
        return AppResult.failure(
          const UnknownFailure(message: 'Bank account not found'),
        );
      }
      return AppResult.success(_toAccountDomain(entry));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<BankTransaction>>> fetchTransactions(
    String accountId,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries =
          await _transactionDao.getTransactionsByAccount(accountId, companyId);
      return AppResult.success(entries.map(_toTransactionDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  BankAccount _toAccountDomain(BankAccountTableData entry) {
    return BankAccount(
      id: entry.id,
      name: entry.name,
      accountNumber: entry.accountNumber,
      accountType: BankAccountType.values.firstWhere(
        (t) => t.name == entry.accountType,
        orElse: () => BankAccountType.checking,
      ),
      currency: entry.currency,
      currentBalance: entry.currentBalance,
      status: BankAccountStatus.values.firstWhere(
        (s) => s.name == entry.status,
        orElse: () => BankAccountStatus.active,
      ),
      createdAt: entry.createdAt,
    );
  }

  BankTransaction _toTransactionDomain(BankTransactionTableData entry) {
    return BankTransaction(
      id: entry.id,
      accountId: entry.accountId,
      date: entry.date,
      amount: entry.amount,
      transactionType: BankTransactionType.values.firstWhere(
        (t) => t.name == entry.transactionType,
        orElse: () => BankTransactionType.adjustment,
      ),
      reference: entry.reference,
      description: entry.description,
      runningBalance: entry.runningBalance,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }
}
