import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/bank_account.dart';
import '../domain/bank_account_status.dart';
import '../domain/bank_account_type.dart';
import '../domain/bank_transaction.dart';
import '../domain/bank_transaction_type.dart';

abstract class BankingRepository {
  Future<AppResult<List<BankAccount>>> fetchAccounts();
  Future<AppResult<BankAccount>> fetchAccount(String id);
  Future<AppResult<List<BankTransaction>>> fetchTransactions(String accountId);
}

class MockBankingRepository implements BankingRepository {
  MockBankingRepository();

  final List<BankAccount> _accounts = [
    BankAccount(
      id: 'BA-1001',
      name: 'Main Checking Account',
      accountNumber: '1234-5678-9012',
      accountType: BankAccountType.checking,
      currency: 'USD',
      currentBalance: 125_450.00,
      status: BankAccountStatus.active,
      createdAt: DateTime(2024, 1, 1),
    ),
    BankAccount(
      id: 'BA-1002',
      name: 'Business Savings',
      accountNumber: '9876-5432-1098',
      accountType: BankAccountType.savings,
      currency: 'USD',
      currentBalance: 320_000.00,
      status: BankAccountStatus.active,
      createdAt: DateTime(2024, 1, 15),
    ),
    BankAccount(
      id: 'BA-1003',
      name: 'Petty Cash',
      accountNumber: 'CASH-001',
      accountType: BankAccountType.cash,
      currency: 'USD',
      currentBalance: 2_500.00,
      status: BankAccountStatus.active,
      createdAt: DateTime(2024, 2, 1),
    ),
    BankAccount(
      id: 'BA-1004',
      name: 'Corporate Credit Card',
      accountNumber: '4111-1111-1111-4321',
      accountType: BankAccountType.creditCard,
      currency: 'USD',
      currentBalance: -8_200.00,
      status: BankAccountStatus.active,
      createdAt: DateTime(2024, 3, 1),
    ),
    BankAccount(
      id: 'BA-1005',
      name: 'Inactive Savings Account',
      accountNumber: '0000-0000-0099',
      accountType: BankAccountType.savings,
      currency: 'USD',
      currentBalance: 0.00,
      status: BankAccountStatus.inactive,
      createdAt: DateTime(2023, 6, 1),
    ),
  ];

  final Map<String, List<BankTransaction>> _transactions = {
    'BA-1001': [
      BankTransaction(
        id: 'TXN-1001-001',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 1),
        amount: 50_000.00,
        transactionType: BankTransactionType.deposit,
        reference: 'DEP-20240301',
        description: 'Customer payment received',
        runningBalance: 100_000.00,
        createdAt: DateTime(2024, 3, 1),
        updatedAt: DateTime(2024, 3, 1),
      ),
      BankTransaction(
        id: 'TXN-1001-002',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 5),
        amount: -12_500.00,
        transactionType: BankTransactionType.withdrawal,
        reference: 'WD-20240305',
        description: 'Vendor payment – Office Supplies',
        runningBalance: 87_500.00,
        createdAt: DateTime(2024, 3, 5),
        updatedAt: DateTime(2024, 3, 5),
      ),
      BankTransaction(
        id: 'TXN-1001-003',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 10),
        amount: 75_000.00,
        transactionType: BankTransactionType.transfer,
        reference: 'TRF-20240310',
        description: 'Transfer from savings',
        runningBalance: 162_500.00,
        createdAt: DateTime(2024, 3, 10),
        updatedAt: DateTime(2024, 3, 10),
      ),
      BankTransaction(
        id: 'TXN-1001-004',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 15),
        amount: 450.00,
        transactionType: BankTransactionType.interest,
        reference: 'INT-20240315',
        description: 'Monthly interest credit',
        runningBalance: 162_950.00,
        createdAt: DateTime(2024, 3, 15),
        updatedAt: DateTime(2024, 3, 15),
      ),
      BankTransaction(
        id: 'TXN-1001-005',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 20),
        amount: -25.00,
        transactionType: BankTransactionType.bankFee,
        reference: 'FEE-20240320',
        description: 'Monthly account maintenance fee',
        runningBalance: 162_925.00,
        createdAt: DateTime(2024, 3, 20),
        updatedAt: DateTime(2024, 3, 20),
      ),
      BankTransaction(
        id: 'TXN-1001-006',
        accountId: 'BA-1001',
        date: DateTime(2024, 3, 28),
        amount: -37_475.00,
        transactionType: BankTransactionType.adjustment,
        reference: 'ADJ-20240328',
        description: 'Reconciliation adjustment',
        runningBalance: 125_450.00,
        createdAt: DateTime(2024, 3, 28),
        updatedAt: DateTime(2024, 3, 28),
      ),
    ],
    'BA-1002': [
      BankTransaction(
        id: 'TXN-1002-001',
        accountId: 'BA-1002',
        date: DateTime(2024, 1, 31),
        amount: 320_000.00,
        transactionType: BankTransactionType.deposit,
        reference: 'DEP-20240131',
        description: 'Initial deposit',
        runningBalance: 320_000.00,
        createdAt: DateTime(2024, 1, 31),
        updatedAt: DateTime(2024, 1, 31),
      ),
    ],
    'BA-1003': [
      BankTransaction(
        id: 'TXN-1003-001',
        accountId: 'BA-1003',
        date: DateTime(2024, 2, 1),
        amount: 2_500.00,
        transactionType: BankTransactionType.deposit,
        reference: 'DEP-20240201',
        description: 'Petty cash replenishment',
        runningBalance: 2_500.00,
        createdAt: DateTime(2024, 2, 1),
        updatedAt: DateTime(2024, 2, 1),
      ),
    ],
    'BA-1004': [
      BankTransaction(
        id: 'TXN-1004-001',
        accountId: 'BA-1004',
        date: DateTime(2024, 3, 5),
        amount: -8_200.00,
        transactionType: BankTransactionType.withdrawal,
        reference: 'CC-20240305',
        description: 'Business travel expenses',
        runningBalance: -8_200.00,
        createdAt: DateTime(2024, 3, 5),
        updatedAt: DateTime(2024, 3, 5),
      ),
    ],
    'BA-1005': [],
  };

  @override
  Future<AppResult<List<BankAccount>>> fetchAccounts() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_accounts));
  }

  @override
  Future<AppResult<BankAccount>> fetchAccount(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final account = _accounts.where((a) => a.id == id).firstOrNull;
    if (account == null) {
      return AppResult.failure(
        const UnknownFailure(message: 'Bank account not found'),
      );
    }
    return AppResult.success(account);
  }

  @override
  Future<AppResult<List<BankTransaction>>> fetchTransactions(
    String accountId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final txns = _transactions[accountId] ?? const [];
    return AppResult.success(List.unmodifiable(txns));
  }
}
