// test/features/recurring_transactions/recurring_transactions_controller_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/recurring_transactions/data/recurring_transactions_repository.dart';
import 'package:accounting_app/features/recurring_transactions/data/recurring_transactions_repository_provider.dart';
import 'package:accounting_app/features/recurring_transactions/domain/recurring_transaction.dart';
import 'package:accounting_app/features/recurring_transactions/domain/recurring_transactions_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    recurringTransactionsRepositoryProvider.overrideWithValue(
      MockRecurringTransactionsRepository(
        auditRepository: MockAuditTrailRepository(),
      ),
    ),
  ],
);

void main() {
  group('RecurringTransactionsController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads 4 seeded transactions', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final items = await container.read(
        recurringTransactionsControllerProvider.future,
      );
      expect(items.length, equals(4));
    });

    test('activate updates isActive in state', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      await notifier.future;

      final success = await notifier.activate('RT-004');
      expect(success, isTrue);

      final state = container
          .read(recurringTransactionsControllerProvider)
          .value!;
      expect(state.firstWhere((t) => t.id == 'RT-004').isActive, isTrue);
    });

    test('deactivate updates isActive in state', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      await notifier.future;

      final success = await notifier.deactivate('RT-001');
      expect(success, isTrue);

      final state = container
          .read(recurringTransactionsControllerProvider)
          .value!;
      expect(state.firstWhere((t) => t.id == 'RT-001').isActive, isFalse);
    });

    test('activate returns false for unknown id', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      await notifier.future;
      final success = await notifier.activate('NO-SUCH');
      expect(success, isFalse);
    });

    test('create adds item to state', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      await notifier.future;

      final tx = RecurringTransaction(
        id: '',
        name: 'New Test',
        sourceDocumentId: 'VB-99',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.monthly,
        nextRun: DateTime(2026, 4, 1),
      );
      final result = await notifier.create(tx);
      expect(result!.isSuccess, isTrue);

      final state = container
          .read(recurringTransactionsControllerProvider)
          .value!;
      expect(state.any((t) => t.name == 'New Test'), isTrue);
      expect(state.length, equals(5));
    });

    test('updateTransaction replaces item in state', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      final initial = await notifier.future;
      final target = initial.first;
      final updated = target.copyWith(name: 'Renamed');

      final result = await notifier.updateTransaction(updated);
      expect(result!.isSuccess, isTrue);

      final state = container
          .read(recurringTransactionsControllerProvider)
          .value!;
      expect(
        state.firstWhere((t) => t.id == target.id).name,
        equals('Renamed'),
      );
    });

    test('executeNow advances nextRun in state', () async {
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      final notifier = container.read(
        recurringTransactionsControllerProvider.notifier,
      );
      final initial = await notifier.future;
      final prevNextRun = initial.firstWhere((t) => t.id == 'RT-001').nextRun;

      final success = await notifier.executeNow('RT-001');
      expect(success, isTrue);

      final state = container
          .read(recurringTransactionsControllerProvider)
          .value!;
      expect(
        state.firstWhere((t) => t.id == 'RT-001').nextRun.isAfter(prevNextRun),
        isTrue,
      );
    });
  });

  group('activeRecurringTransactionsProvider', () {
    test('returns only active transactions', () async {
      final container = _makeContainer();
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      await container.read(recurringTransactionsControllerProvider.future);

      final active = container.read(activeRecurringTransactionsProvider);
      expect(active.every((t) => t.isActive), isTrue);
      expect(active.length, equals(3));
      container.dispose();
    });
  });

  group('inactiveRecurringTransactionsProvider', () {
    test('returns only inactive transactions', () async {
      final container = _makeContainer();
      container.listen(recurringTransactionsControllerProvider, (_, _) {});
      await container.read(recurringTransactionsControllerProvider.future);

      final inactive = container.read(inactiveRecurringTransactionsProvider);
      expect(inactive.every((t) => !t.isActive), isTrue);
      expect(inactive.length, equals(1));
      container.dispose();
    });
  });
}
