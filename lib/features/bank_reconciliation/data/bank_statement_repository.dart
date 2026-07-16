import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/bank_statement.dart';
import '../domain/bank_statement_status.dart';
import '../domain/bank_statement_transaction.dart';

abstract class BankStatementRepository {
  Future<AppResult<List<BankStatement>>> fetchStatements();
  Future<AppResult<List<BankStatement>>> fetchStatementsForAccount(
    String bankAccountId,
  );
  Future<AppResult<BankStatement>> fetchStatement(String id);
  Future<AppResult<BankStatement>> matchTransaction({
    required String statementId,
    required String transactionId,
    required String erpEntryId,
    required String erpEntryLabel,
    bool autoMatch = false,
  });
  Future<AppResult<BankStatement>> unmatchTransaction({
    required String statementId,
    required String transactionId,
  });
  Future<AppResult<BankStatement>> autoMatch(String statementId);
  Future<AppResult<BankStatement>> finalizeStatement(String statementId);
}

class MockBankStatementRepository implements BankStatementRepository {
  MockBankStatementRepository() {
    _initStatements();
  }

  final List<BankStatement> _statements = [];

  void _initStatements() {
    _statements.addAll([
      BankStatement(
        id: 'BS-2024-03-001',
        bankAccountId: 'BA-1001',
        bankAccountName: 'Main Checking Account',
        periodStart: DateTime(2024, 3, 1),
        periodEnd: DateTime(2024, 3, 31),
        openingBalance: 50_000.00,
        closingBalance: 125_450.00,
        status: BankStatementStatus.inProgress,
        importedAt: DateTime(2024, 4, 1),
        transactions: [
          BankStatementTransaction(
            id: 'BST-001',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 1),
            amount: 50_000.00,
            description: 'Customer payment received',
            reference: 'DEP-20240301',
            isMatched: true,
            matchedErpEntryId: 'ERP-TXN-001',
          ),
          BankStatementTransaction(
            id: 'BST-002',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 5),
            amount: -12_500.00,
            description: 'Vendor payment – Office Supplies',
            reference: 'WD-20240305',
            isMatched: true,
            matchedErpEntryId: 'ERP-TXN-002',
          ),
          BankStatementTransaction(
            id: 'BST-003',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 10),
            amount: 75_000.00,
            description: 'Transfer from savings',
            reference: 'TRF-20240310',
            isMatched: false,
          ),
          BankStatementTransaction(
            id: 'BST-004',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 15),
            amount: 450.00,
            description: 'Monthly interest credit',
            reference: 'INT-20240315',
            isMatched: false,
            notes: 'Timing difference',
          ),
          BankStatementTransaction(
            id: 'BST-005',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 20),
            amount: -25.00,
            description: 'Monthly account maintenance fee',
            reference: 'FEE-20240320',
            isMatched: false,
            notes: 'Bank fee — no ERP entry',
          ),
          BankStatementTransaction(
            id: 'BST-006',
            statementId: 'BS-2024-03-001',
            date: DateTime(2024, 3, 28),
            amount: -37_475.00,
            description: 'Reconciliation adjustment',
            reference: 'ADJ-20240328',
            isMatched: false,
            notes: 'Duplicate check',
          ),
        ],
      ),
      BankStatement(
        id: 'BS-2024-02-001',
        bankAccountId: 'BA-1001',
        bankAccountName: 'Main Checking Account',
        periodStart: DateTime(2024, 2, 1),
        periodEnd: DateTime(2024, 2, 29),
        openingBalance: 20_000.00,
        closingBalance: 50_000.00,
        status: BankStatementStatus.reconciled,
        importedAt: DateTime(2024, 3, 1),
        reconciledAt: DateTime(2024, 3, 5),
        transactions: [
          BankStatementTransaction(
            id: 'BST-010',
            statementId: 'BS-2024-02-001',
            date: DateTime(2024, 2, 1),
            amount: 30_000.00,
            description: 'Sales invoice payment',
            reference: 'DEP-20240201',
            isMatched: true,
            matchedErpEntryId: 'ERP-TXN-010',
          ),
        ],
      ),
      BankStatement(
        id: 'BS-2024-03-002',
        bankAccountId: 'BA-1002',
        bankAccountName: 'Business Savings',
        periodStart: DateTime(2024, 3, 1),
        periodEnd: DateTime(2024, 3, 31),
        openingBalance: 310_000.00,
        closingBalance: 320_000.00,
        status: BankStatementStatus.draft,
        importedAt: DateTime(2024, 4, 2),
        transactions: [
          BankStatementTransaction(
            id: 'BST-020',
            statementId: 'BS-2024-03-002',
            date: DateTime(2024, 3, 15),
            amount: 10_000.00,
            description: 'Interest earned',
            reference: 'INT-20240315-SAV',
            isMatched: false,
          ),
        ],
      ),
      BankStatement(
        id: 'BS-2024-01-001',
        bankAccountId: 'BA-1001',
        bankAccountName: 'Main Checking Account',
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime(2024, 1, 31),
        openingBalance: 0,
        closingBalance: 20_000.00,
        status: BankStatementStatus.needsAttention,
        importedAt: DateTime(2024, 2, 1),
        transactions: [
          BankStatementTransaction(
            id: 'BST-030',
            statementId: 'BS-2024-01-001',
            date: DateTime(2024, 1, 10),
            amount: 25_000.00,
            description: 'Opening deposit',
            reference: 'DEP-20240110',
            isMatched: true,
            matchedErpEntryId: 'ERP-TXN-030',
          ),
          BankStatementTransaction(
            id: 'BST-031',
            statementId: 'BS-2024-01-001',
            date: DateTime(2024, 1, 15),
            amount: -5_000.00,
            description: 'Unknown debit — needs review',
            reference: 'UNKNOWN-001',
            isMatched: false,
            notes: 'Needs investigation',
          ),
        ],
      ),
    ]);
  }

  @override
  Future<AppResult<List<BankStatement>>> fetchStatements() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_statements));
  }

  @override
  Future<AppResult<List<BankStatement>>> fetchStatementsForAccount(
    String bankAccountId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final result = _statements
        .where((s) => s.bankAccountId == bankAccountId)
        .toList();
    return AppResult.success(List.unmodifiable(result));
  }

  @override
  Future<AppResult<BankStatement>> fetchStatement(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final statement = _statements.where((s) => s.id == id).firstOrNull;
    if (statement == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Statement not found'),
      );
    }
    return AppResult.success(statement);
  }

  @override
  Future<AppResult<BankStatement>> matchTransaction({
    required String statementId,
    required String transactionId,
    required String erpEntryId,
    required String erpEntryLabel,
    bool autoMatch = false,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _statements.indexWhere((s) => s.id == statementId);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Statement not found'),
      );
    }
    final statement = _statements[idx];
    final txnIdx = statement.transactions.indexWhere(
      (t) => t.id == transactionId,
    );
    if (txnIdx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Transaction not found'),
      );
    }
    final updatedTxns = List<BankStatementTransaction>.from(
      statement.transactions,
    );
    updatedTxns[txnIdx] = updatedTxns[txnIdx].copyWith(
      isMatched: true,
      matchedErpEntryId: erpEntryId,
    );
    final updated = statement.copyWith(
      transactions: updatedTxns,
      status: _deriveStatus(updatedTxns),
    );
    _statements[idx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<BankStatement>> unmatchTransaction({
    required String statementId,
    required String transactionId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _statements.indexWhere((s) => s.id == statementId);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Statement not found'),
      );
    }
    final statement = _statements[idx];
    final txnIdx = statement.transactions.indexWhere(
      (t) => t.id == transactionId,
    );
    if (txnIdx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Transaction not found'),
      );
    }
    final updatedTxns = List<BankStatementTransaction>.from(
      statement.transactions,
    );
    updatedTxns[txnIdx] = updatedTxns[txnIdx].copyWith(
      isMatched: false,
      matchedErpEntryId: null,
    );
    final updated = statement.copyWith(
      transactions: updatedTxns,
      status: _deriveStatus(updatedTxns),
    );
    _statements[idx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<BankStatement>> autoMatch(String statementId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final idx = _statements.indexWhere((s) => s.id == statementId);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Statement not found'),
      );
    }
    final statement = _statements[idx];
    // Auto-match all unmatched transactions that have a non-UNKNOWN reference.
    final updatedTxns = statement.transactions.map((t) {
      if (!t.isMatched && !t.reference.startsWith('UNKNOWN')) {
        return t.copyWith(
          isMatched: true,
          matchedErpEntryId: 'ERP-AUTO-${t.id}',
        );
      }
      return t;
    }).toList();
    final updated = statement.copyWith(
      transactions: updatedTxns,
      status: _deriveStatus(updatedTxns),
    );
    _statements[idx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<BankStatement>> finalizeStatement(String statementId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final idx = _statements.indexWhere((s) => s.id == statementId);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Statement not found'),
      );
    }
    final statement = _statements[idx];
    final updated = statement.copyWith(
      status: BankStatementStatus.reconciled,
      reconciledAt: DateTime.now(),
    );
    _statements[idx] = updated;
    return AppResult.success(updated);
  }

  BankStatementStatus _deriveStatus(List<BankStatementTransaction> txns) {
    if (txns.isEmpty) return BankStatementStatus.draft;
    final allMatched = txns.every((t) => t.isMatched);
    if (allMatched) return BankStatementStatus.inProgress;
    return BankStatementStatus.inProgress;
  }
}
