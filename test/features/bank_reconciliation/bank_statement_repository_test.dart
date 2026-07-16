import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_statement_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockBankStatementRepository', () {
    late MockBankStatementRepository repository;

    setUp(() {
      repository = MockBankStatementRepository();
    });

    group('fetchStatements', () {
      test('returns a non-empty list of statements', () async {
        final result = await repository.fetchStatements();
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
      });

      test('includes statements for multiple accounts', () async {
        final result = await repository.fetchStatements();
        final accountIds = result.data!.map((s) => s.bankAccountId).toSet();
        expect(accountIds.length, greaterThan(1));
      });

      test('includes statements of all statuses', () async {
        final result = await repository.fetchStatements();
        final statuses = result.data!.map((s) => s.status).toSet();
        expect(statuses, contains(BankStatementStatus.inProgress));
        expect(statuses, contains(BankStatementStatus.reconciled));
        expect(statuses, contains(BankStatementStatus.draft));
        expect(statuses, contains(BankStatementStatus.needsAttention));
      });
    });

    group('fetchStatementsForAccount', () {
      test('returns statements for BA-1001', () async {
        final result = await repository.fetchStatementsForAccount('BA-1001');
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
        for (final s in result.data!) {
          expect(s.bankAccountId, equals('BA-1001'));
        }
      });

      test('returns empty list for unknown account', () async {
        final result = await repository.fetchStatementsForAccount('UNKNOWN');
        expect(result.isSuccess, isTrue);
        expect(result.data, isEmpty);
      });
    });

    group('fetchStatement', () {
      test('returns the correct statement by id', () async {
        final result = await repository.fetchStatement('BS-2024-03-001');
        expect(result.isSuccess, isTrue);
        expect(result.data!.id, equals('BS-2024-03-001'));
        expect(result.data!.bankAccountId, equals('BA-1001'));
      });

      test('returns failure for unknown id', () async {
        final result = await repository.fetchStatement('UNKNOWN');
        expect(result.isSuccess, isFalse);
      });
    });

    group('matchTransaction', () {
      test('marks a transaction as matched', () async {
        final result = await repository.matchTransaction(
          statementId: 'BS-2024-03-001',
          transactionId: 'BST-003',
          erpEntryId: 'ERP-TXN-TEST',
          erpEntryLabel: 'Transfer from savings',
        );
        expect(result.isSuccess, isTrue);
        final txn = result.data!.transactions.firstWhere(
          (t) => t.id == 'BST-003',
        );
        expect(txn.isMatched, isTrue);
        expect(txn.matchedErpEntryId, equals('ERP-TXN-TEST'));
      });

      test('returns failure for unknown statement', () async {
        final result = await repository.matchTransaction(
          statementId: 'UNKNOWN',
          transactionId: 'BST-003',
          erpEntryId: 'ERP-X',
          erpEntryLabel: 'X',
        );
        expect(result.isSuccess, isFalse);
      });

      test('returns failure for unknown transaction', () async {
        final result = await repository.matchTransaction(
          statementId: 'BS-2024-03-001',
          transactionId: 'UNKNOWN',
          erpEntryId: 'ERP-X',
          erpEntryLabel: 'X',
        );
        expect(result.isSuccess, isFalse);
      });
    });

    group('unmatchTransaction', () {
      test('unmatches a previously matched transaction', () async {
        final result = await repository.unmatchTransaction(
          statementId: 'BS-2024-03-001',
          transactionId: 'BST-001',
        );
        expect(result.isSuccess, isTrue);
        final txn = result.data!.transactions.firstWhere(
          (t) => t.id == 'BST-001',
        );
        expect(txn.isMatched, isFalse);
        expect(txn.matchedErpEntryId, isNull);
      });
    });

    group('autoMatch', () {
      test('matches all non-UNKNOWN transactions', () async {
        final result = await repository.autoMatch('BS-2024-03-001');
        expect(result.isSuccess, isTrue);
        // Transactions not starting with UNKNOWN should be matched
        final nonUnknown = result.data!.transactions.where(
          (t) => !t.reference.startsWith('UNKNOWN'),
        );
        for (final txn in nonUnknown) {
          expect(txn.isMatched, isTrue);
        }
      });

      test('does not match UNKNOWN transactions', () async {
        await repository.autoMatch('BS-2024-01-001');
        final result = await repository.fetchStatement('BS-2024-01-001');
        final unknownTxn = result.data!.transactions.firstWhere(
          (t) => t.reference.startsWith('UNKNOWN'),
        );
        expect(unknownTxn.isMatched, isFalse);
      });
    });

    group('finalizeStatement', () {
      test('sets status to reconciled and sets reconciledAt', () async {
        final result = await repository.finalizeStatement('BS-2024-03-001');
        expect(result.isSuccess, isTrue);
        expect(result.data!.status, equals(BankStatementStatus.reconciled));
        expect(result.data!.reconciledAt, isNotNull);
      });
    });

    group('BankStatement computed properties', () {
      test('matched and unmatched counts are correct', () async {
        final result = await repository.fetchStatement('BS-2024-03-001');
        final statement = result.data!;
        expect(statement.matched.length, equals(2)); // BST-001 & BST-002
        expect(statement.unmatched.length, equals(4));
      });

      test('progressPercent is between 0 and 1', () async {
        final result = await repository.fetchStatement('BS-2024-03-001');
        final pct = result.data!.progressPercent;
        expect(pct, greaterThanOrEqualTo(0.0));
        expect(pct, lessThanOrEqualTo(1.0));
      });

      test('totalCredits and totalDebits are positive', () async {
        final result = await repository.fetchStatement('BS-2024-03-001');
        expect(result.data!.totalCredits, greaterThan(0));
        expect(result.data!.totalDebits, greaterThan(0));
      });
    });
  });
}
