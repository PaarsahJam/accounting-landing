import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/domain/bank_account_status.dart';
import 'package:accounting_app/features/banking/domain/bank_account_type.dart';
import 'package:accounting_app/features/banking/domain/bank_transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockBankingRepository', () {
    late MockBankingRepository repository;

    setUp(() {
      repository = MockBankingRepository();
    });

    group('fetchAccounts', () {
      test('returns a non-empty list of bank accounts', () async {
        final result = await repository.fetchAccounts();
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
      });

      test('includes accounts of various types', () async {
        final result = await repository.fetchAccounts();
        final types = result.data!.map((a) => a.accountType).toSet();
        expect(types, contains(BankAccountType.checking));
        expect(types, contains(BankAccountType.savings));
        expect(types, contains(BankAccountType.cash));
        expect(types, contains(BankAccountType.creditCard));
      });

      test('includes active and inactive accounts', () async {
        final result = await repository.fetchAccounts();
        final statuses = result.data!.map((a) => a.status).toSet();
        expect(statuses, contains(BankAccountStatus.active));
        expect(statuses, contains(BankAccountStatus.inactive));
      });
    });

    group('fetchAccount', () {
      test('returns a specific account by id', () async {
        final result = await repository.fetchAccount('BA-1001');
        expect(result.isSuccess, isTrue);
        expect(result.data!.id, equals('BA-1001'));
        expect(result.data!.name, equals('Main Checking Account'));
      });

      test('returns failure for unknown id', () async {
        final result = await repository.fetchAccount('UNKNOWN');
        expect(result.isSuccess, isFalse);
      });
    });

    group('fetchTransactions', () {
      test('returns transactions for a known account', () async {
        final result = await repository.fetchTransactions('BA-1001');
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
      });

      test('returns empty list for account with no transactions', () async {
        final result = await repository.fetchTransactions('BA-1005');
        expect(result.isSuccess, isTrue);
        expect(result.data, isEmpty);
      });

      test('returns empty list for unknown account', () async {
        final result = await repository.fetchTransactions('UNKNOWN');
        expect(result.isSuccess, isTrue);
        expect(result.data, isEmpty);
      });

      test('transactions contain all expected types for BA-1001', () async {
        final result = await repository.fetchTransactions('BA-1001');
        final types = result.data!.map((t) => t.transactionType).toSet();
        expect(types, contains(BankTransactionType.deposit));
        expect(types, contains(BankTransactionType.withdrawal));
        expect(types, contains(BankTransactionType.transfer));
        expect(types, contains(BankTransactionType.interest));
        expect(types, contains(BankTransactionType.bankFee));
        expect(types, contains(BankTransactionType.adjustment));
      });

      test('running balance reflects transaction sequence', () async {
        final result = await repository.fetchTransactions('BA-1001');
        expect(result.data!.last.runningBalance, equals(125450.0));
      });
    });
  });

  group('BankAccountType', () {
    test('labels are correct', () {
      expect(BankAccountType.checking.label, equals('Checking'));
      expect(BankAccountType.savings.label, equals('Savings'));
      expect(BankAccountType.cash.label, equals('Cash'));
      expect(BankAccountType.creditCard.label, equals('Credit Card'));
    });
  });

  group('BankAccountStatus', () {
    test('labels are correct', () {
      expect(BankAccountStatus.active.label, equals('Active'));
      expect(BankAccountStatus.inactive.label, equals('Inactive'));
      expect(BankAccountStatus.frozen.label, equals('Frozen'));
    });
  });

  group('BankTransactionType', () {
    test('labels are correct', () {
      expect(BankTransactionType.deposit.label, equals('Deposit'));
      expect(BankTransactionType.withdrawal.label, equals('Withdrawal'));
      expect(BankTransactionType.transfer.label, equals('Transfer'));
      expect(BankTransactionType.interest.label, equals('Interest'));
      expect(BankTransactionType.bankFee.label, equals('Bank Fee'));
      expect(BankTransactionType.adjustment.label, equals('Adjustment'));
    });
  });
}
