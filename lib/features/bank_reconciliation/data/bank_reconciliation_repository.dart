import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/bank_reconciliation_models.dart';

abstract class BankReconciliationRepository {
  Future<AppResult<List<BankAccount>>> loadBankAccounts();
  Future<AppResult<List<BankTransaction>>> loadTransactions(
    String bankAccountId,
  );
  Future<AppResult<List<BankTransaction>>> loadUnmatchedTransactions(
    String bankAccountId,
  );
  Future<AppResult<BankTransaction>> matchTransaction({
    required String transactionId,
    required String ledgerEntryId,
  });
  Future<AppResult<BankTransaction>> unmatchTransaction(String transactionId);
  Future<AppResult<ReconciliationSession>> finalizeReconciliation(
    String bankAccountId,
  );
}

class MockBankReconciliationRepository implements BankReconciliationRepository {
  final List<BankAccount> _accounts = [
    const BankAccount(
      id: 'ba-001',
      name: 'Operating Account',
      accountNumber: '****1234',
      currentBalance: 125000000,
      currency: 'IRR',
    ),
    const BankAccount(
      id: 'ba-002',
      name: 'Payroll Account',
      accountNumber: '****5678',
      currentBalance: 42000000,
      currency: 'IRR',
    ),
  ];

  final List<BankTransaction> _transactions = [
    BankTransaction(
      id: 'tx-001',
      reference: 'INV-1001',
      occurredAt: DateTime(2024, 1, 15),
      amount: 2500000,
      description: 'Customer payment',
      matched: true,
      matchedLedgerEntryId: 'ledger-1001',
      bankAccountId: 'ba-001',
    ),
    BankTransaction(
      id: 'tx-002',
      reference: 'MISC-202',
      occurredAt: DateTime(2024, 1, 16),
      amount: 480000,
      description: 'Software subscription',
      matched: false,
      matchedLedgerEntryId: null,
      bankAccountId: 'ba-001',
    ),
    BankTransaction(
      id: 'tx-003',
      reference: 'SAL-204',
      occurredAt: DateTime(2024, 1, 17),
      amount: 9200000,
      description: 'Payroll transfer',
      matched: false,
      matchedLedgerEntryId: null,
      bankAccountId: 'ba-002',
    ),
  ];

  final List<LedgerEntryReference> _ledgerEntries = [
    LedgerEntryReference(
      id: 'ledger-1001',
      label: 'Invoice 1001',
      type: 'Invoice',
      amount: 2500000,
      occurredAt: DateTime(2024, 1, 15),
    ),
    LedgerEntryReference(
      id: 'ledger-1002',
      label: 'Software Subscription',
      type: 'Expense',
      amount: 480000,
      occurredAt: DateTime(2024, 1, 16),
    ),
  ];

  @override
  Future<AppResult<List<BankAccount>>> loadBankAccounts() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(List<BankAccount>.from(_accounts));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<BankTransaction>>> loadTransactions(
    String bankAccountId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(
        _transactions.where((t) => t.bankAccountId == bankAccountId).toList(),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<BankTransaction>>> loadUnmatchedTransactions(
    String bankAccountId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(
        _transactions
            .where((t) => t.bankAccountId == bankAccountId && !t.matched)
            .toList(),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankTransaction>> matchTransaction({
    required String transactionId,
    required String ledgerEntryId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _transactions.indexWhere((t) => t.id == transactionId);
      if (index < 0) {
        return AppResult.failure(
          const UnknownFailure(message: 'Transaction not found'),
        );
      }
      if (!_ledgerEntries.any((entry) => entry.id == ledgerEntryId)) {
        return AppResult.failure(
          const UnknownFailure(message: 'Ledger entry not found'),
        );
      }
      final updated = _transactions[index].copyWith(
        matched: true,
        matchedLedgerEntryId: ledgerEntryId,
      );
      _transactions[index] = updated;
      return AppResult.success(updated);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<BankTransaction>> unmatchTransaction(
    String transactionId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _transactions.indexWhere((t) => t.id == transactionId);
      if (index < 0) {
        return AppResult.failure(
          const UnknownFailure(message: 'Transaction not found'),
        );
      }
      final updated = _transactions[index].copyWith(
        matched: false,
        matchedLedgerEntryId: null,
      );
      _transactions[index] = updated;
      return AppResult.success(updated);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<ReconciliationSession>> finalizeReconciliation(
    String bankAccountId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final matchedCount = _transactions
          .where((t) => t.bankAccountId == bankAccountId && t.matched)
          .length;
      final session = ReconciliationSession(
        id: 'session-${DateTime.now().millisecondsSinceEpoch}',
        bankAccountId: bankAccountId,
        startedAt: DateTime.now(),
        status: ReconciliationStatus.completed,
        matchedCount: matchedCount,
        unmatchedCount: _transactions
            .where((t) => t.bankAccountId == bankAccountId && !t.matched)
            .length,
        totalAmount: _transactions
            .where((t) => t.bankAccountId == bankAccountId)
            .fold<double>(0, (sum, item) => sum + item.amount),
      );
      return AppResult.success(session);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
