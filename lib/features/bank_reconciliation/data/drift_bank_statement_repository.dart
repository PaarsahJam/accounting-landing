import 'package:drift/drift.dart';

import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/bank_statement_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/bank_statement.dart';
import '../domain/bank_statement_status.dart';
import '../domain/bank_statement_transaction.dart';
import 'bank_statement_repository.dart';

/// Tenant-scoped Drift implementation of [BankStatementRepository].
class DriftBankStatementRepository implements BankStatementRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final BankStatementDao _dao;

  DriftBankStatementRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = BankStatementDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<BankStatement>>> fetchStatements() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllStatements(companyId);
      final result = <BankStatement>[];
      for (final entry in entries) {
        final txns =
            await _dao.getTransactionsByStatementId(entry.id, companyId);
        result.add(_toDomain(entry, txns));
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<BankStatement>>> fetchStatementsForAccount(
    String bankAccountId,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries =
          await _dao.getStatementsForAccount(bankAccountId, companyId);
      final result = <BankStatement>[];
      for (final entry in entries) {
        final txns =
            await _dao.getTransactionsByStatementId(entry.id, companyId);
        result.add(_toDomain(entry, txns));
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankStatement>> fetchStatement(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entry = await _dao.getStatementById(id, companyId);
      if (entry == null) {
        return AppResult.failure(
          const UnknownFailure(message: 'Statement not found'),
        );
      }
      final txns =
          await _dao.getTransactionsByStatementId(entry.id, companyId);
      return AppResult.success(_toDomain(entry, txns));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankStatement>> matchTransaction({
    required String statementId,
    required String transactionId,
    required String erpEntryId,
    required String erpEntryLabel,
    bool autoMatch = false,
  }) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateTransaction(
        BankStatementTransactionTableCompanion(
          id: Value(transactionId),
          isMatched: Value(true),
          matchedErpEntryId: Value(erpEntryId),
        ),
        companyId,
      );
      return fetchStatement(statementId).then((r) => r);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankStatement>> unmatchTransaction({
    required String statementId,
    required String transactionId,
  }) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateTransaction(
        BankStatementTransactionTableCompanion(
          id: Value(transactionId),
          isMatched: Value(false),
          matchedErpEntryId: const Value.absent(),
        ),
        companyId,
      );
      return fetchStatement(statementId).then((r) => r);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankStatement>> autoMatch(String statementId) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final txns =
          await _dao.getTransactionsByStatementId(statementId, companyId);
      for (final txn in txns) {
        if (!txn.isMatched && !txn.reference.startsWith('UNKNOWN')) {
          await _dao.updateTransaction(
            BankStatementTransactionTableCompanion(
              id: Value(txn.id),
              isMatched: Value(true),
              matchedErpEntryId: Value('ERP-AUTO-${txn.id}'),
            ),
            companyId,
          );
        }
      }
      return fetchStatement(statementId).then((r) => r);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankStatement>> finalizeStatement(
    String statementId,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateStatement(
        BankStatementTableCompanion(
          id: Value(statementId),
          status: Value(BankStatementStatus.reconciled.name),
          reconciledAt: Value(DateTime.now()),
        ),
        companyId,
      );
      return fetchStatement(statementId).then((r) => r);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  BankStatement _toDomain(
    BankStatementTableData entry,
    List<BankStatementTransactionTableData> txnEntries,
  ) {
    return BankStatement(
      id: entry.id,
      bankAccountId: entry.bankAccountId,
      bankAccountName: entry.bankAccountName,
      periodStart: entry.periodStart,
      periodEnd: entry.periodEnd,
      openingBalance: entry.openingBalance,
      closingBalance: entry.closingBalance,
      status: BankStatementStatus.values.firstWhere(
        (s) => s.name == entry.status,
        orElse: () => BankStatementStatus.draft,
      ),
      importedAt: entry.importedAt,
      reconciledAt: entry.reconciledAt,
      transactions: txnEntries
          .map((t) => BankStatementTransaction(
                id: t.id,
                statementId: t.statementId,
                date: t.date,
                amount: t.amount,
                description: t.description,
                reference: t.reference,
                isMatched: t.isMatched,
                matchedErpEntryId: t.matchedErpEntryId,
                notes: t.notes,
              ))
          .toList(),
    );
  }
}
