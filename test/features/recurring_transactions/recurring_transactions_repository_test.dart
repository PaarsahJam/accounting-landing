// test/features/recurring_transactions/recurring_transactions_repository_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/recurring_transactions/data/recurring_transactions_repository.dart';
import 'package:accounting_app/features/recurring_transactions/domain/recurring_transaction.dart';
import 'package:flutter_test/flutter_test.dart';

MockRecurringTransactionsRepository _makeRepo() =>
    MockRecurringTransactionsRepository(
      auditRepository: MockAuditTrailRepository(),
    );

final _epoch = DateTime(2026, 1, 1);

void main() {
  group('MockRecurringTransactionsRepository', () {
    test('fetchRecurringTransactions returns 4 seeded items', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRecurringTransactions();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(4));
    });

    test('seeded data contains Monthly Office Rent', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRecurringTransactions();
      expect(result.data!.any((t) => t.name == 'Monthly Office Rent'), isTrue);
    });

    test('seeded data has 3 active and 1 inactive', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRecurringTransactions();
      final active = result.data!.where((t) => t.isActive).length;
      final inactive = result.data!.where((t) => !t.isActive).length;
      expect(active, equals(3));
      expect(inactive, equals(1));
    });

    test('createRecurringTransaction adds item and returns it', () async {
      final repo = _makeRepo();
      final tx = RecurringTransaction(
        id: '',
        name: 'Test Subscription',
        sourceDocumentId: 'VB-TEST',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.weekly,
        nextRun: DateTime(2026, 3, 1),
      );
      final result = await repo.createRecurringTransaction(tx);
      expect(result.isSuccess, isTrue);
      expect(result.data!.name, equals('Test Subscription'));
      expect(result.data!.id, isNotEmpty);

      final all = (await repo.fetchRecurringTransactions()).data!;
      expect(all.length, equals(5));
    });

    test('updateRecurringTransaction persists change', () async {
      final repo = _makeRepo();
      final original = (await repo.fetchRecurringTransactions()).data!.first;
      final updated = original.copyWith(name: 'Updated Name');

      final result = await repo.updateRecurringTransaction(updated);
      expect(result.isSuccess, isTrue);
      expect(result.data!.name, equals('Updated Name'));

      final after = (await repo.fetchRecurringTransactions()).data!;
      expect(
        after.firstWhere((t) => t.id == original.id).name,
        equals('Updated Name'),
      );
    });

    test('updateRecurringTransaction fails for unknown id', () async {
      final repo = _makeRepo();
      final fake = RecurringTransaction(
        id: 'NO-SUCH',
        name: 'x',
        sourceDocumentId: 'x',
        sourceDocumentType: 'x',
        frequency: RecurrenceFrequency.monthly,
        nextRun: _epoch,
      );
      final result = await repo.updateRecurringTransaction(fake);
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('activate sets isActive to true', () async {
      final repo = _makeRepo();
      final result = await repo.activate('RT-004');
      expect(result.isSuccess, isTrue);
      expect(result.data!.isActive, isTrue);

      final all = (await repo.fetchRecurringTransactions()).data!;
      expect(all.firstWhere((t) => t.id == 'RT-004').isActive, isTrue);
    });

    test('deactivate sets isActive to false', () async {
      final repo = _makeRepo();
      final result = await repo.deactivate('RT-001');
      expect(result.isSuccess, isTrue);
      expect(result.data!.isActive, isFalse);
    });

    test('activate fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.activate('NO-SUCH');
      expect(result.isSuccess, isFalse);
    });

    test('executeNow advances nextRun and sets lastRun', () async {
      final repo = _makeRepo();
      final before = (await repo.fetchRecurringTransactions()).data!;
      final target = before.firstWhere((t) => t.id == 'RT-001');
      final prevNextRun = target.nextRun;

      final result = await repo.executeNow('RT-001');
      expect(result.isSuccess, isTrue);
      expect(result.data!.lastRun, isNotNull);
      expect(result.data!.nextRun.isAfter(prevNextRun), isTrue);
    });

    test('executeNow fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.executeNow('NO-SUCH');
      expect(result.isSuccess, isFalse);
    });
  });

  group('RecurringTransaction model', () {
    test('equality is by id', () {
      final a = RecurringTransaction(
        id: 'RT-1',
        name: 'A',
        sourceDocumentId: 'x',
        sourceDocumentType: 'y',
        frequency: RecurrenceFrequency.monthly,
        nextRun: _epoch,
      );
      final b = RecurringTransaction(
        id: 'RT-1',
        name: 'B',
        sourceDocumentId: 'z',
        sourceDocumentType: 'w',
        frequency: RecurrenceFrequency.yearly,
        nextRun: _epoch,
      );
      expect(a, equals(b));
    });

    test('copyWith preserves unchanged fields', () {
      final orig = RecurringTransaction(
        id: 'RT-1',
        name: 'Office Rent',
        sourceDocumentId: 'VB-1',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.monthly,
        nextRun: _epoch,
        isActive: true,
      );
      final copy = orig.copyWith(isActive: false);
      expect(copy.id, equals('RT-1'));
      expect(copy.name, equals('Office Rent'));
      expect(copy.isActive, isFalse);
    });

    test('isActive defaults to true', () {
      final tx = RecurringTransaction(
        id: 'RT-X',
        name: 'x',
        sourceDocumentId: 'x',
        sourceDocumentType: 'x',
        frequency: RecurrenceFrequency.daily,
        nextRun: _epoch,
      );
      expect(tx.isActive, isTrue);
    });
  });

  group('RecurrenceFrequency', () {
    test('all values have non-empty labels', () {
      for (final f in RecurrenceFrequency.values) {
        expect(f.label, isNotEmpty);
      }
    });
  });
}
