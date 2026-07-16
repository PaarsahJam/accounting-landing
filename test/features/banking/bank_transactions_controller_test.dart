import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/banking/domain/bank_transaction_type.dart';
import 'package:accounting_app/features/banking/domain/bank_transactions_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BankTransactionsController', () {
    late ProviderContainer container;
    const accountId = 'BA-1001';

    setUp(() {
      container = ProviderContainer(
        overrides: [
          bankingRepositoryProvider.overrideWithValue(MockBankingRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads transactions for account', () async {
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      final txnState = await controller.future;
      expect(txnState.transactions, isNotEmpty);
      expect(txnState.accountId, equals(accountId));
    });

    test('filtered returns all when no filter set', () async {
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      final txnState = await controller.future;
      expect(txnState.filtered.length, equals(txnState.transactions.length));
    });

    test('setTypeFilter filters to deposit only', () async {
      // Keep listener to prevent auto-disposal
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      controller.setTypeFilter(BankTransactionType.deposit);
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value!;
      expect(
        state.filtered.every(
          (t) => t.transactionType == BankTransactionType.deposit,
        ),
        isTrue,
      );
    });

    test('setTypeFilter(null) clears the filter', () async {
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      controller.setTypeFilter(BankTransactionType.deposit);
      controller.setTypeFilter(null);
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value!;
      expect(state.filtered.length, equals(state.transactions.length));
    });

    test('setSearch filters by description', () async {
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      controller.setSearch('interest');
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value!;
      expect(state.filtered, isNotEmpty);
      expect(
        state.filtered.every(
          (t) =>
              t.description.toLowerCase().contains('interest') ||
              t.reference.toLowerCase().contains('interest'),
        ),
        isTrue,
      );
    });

    test('setSearch with no match returns empty filtered list', () async {
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      controller.setSearch('XYZXYZXYZ_NO_MATCH');
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value!;
      expect(state.filtered, isEmpty);
    });

    test('setDateRange filters by date range', () async {
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      controller.setDateRange(DateTime(2024, 3, 10), DateTime(2024, 3, 15));
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value!;
      expect(state.filtered, isNotEmpty);
      for (final txn in state.filtered) {
        expect(txn.date.isAfter(DateTime(2024, 3, 9)), isTrue);
        expect(txn.date.isBefore(DateTime(2024, 3, 16)), isTrue);
      }
    });

    test('refresh reloads transactions', () async {
      container.listen(
        bankTransactionsControllerProvider(accountId),
        (_, _) {},
      );
      final controller = container.read(
        bankTransactionsControllerProvider(accountId).notifier,
      );
      await controller.future;
      await controller.refresh();
      final state = container
          .read(bankTransactionsControllerProvider(accountId))
          .value;
      expect(state, isNotNull);
      expect(state!.transactions, isNotEmpty);
    });

    test('empty account returns empty filtered list', () async {
      final controller = container.read(
        bankTransactionsControllerProvider('BA-1005').notifier,
      );
      final txnState = await controller.future;
      expect(txnState.filtered, isEmpty);
    });
  });
}
