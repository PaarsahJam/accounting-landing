import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/finance/ledger_repository.dart';
import 'package:accounting_app/core/finance/ledger_service.dart';
import 'package:accounting_app/core/finance/journal_entry.dart';
import 'package:accounting_app/core/finance/transaction_line.dart';

void main() {
  test('posting journal entry updates snapshot', () async {
    final repo = MockLedgerRepository();
    final service = LedgerService(repo);

    final entry = JournalEntry(
      id: 'je1',
      date: DateTime.now(),
      reference: 'INV-1',
      lines: [
        TransactionLine(accountId: '1', amount: 1000.0, currency: 'USD'),
        TransactionLine(accountId: '4', amount: -1000.0, currency: 'USD'),
      ],
    );

    await service.postEntry(entry);
    final snapshot = await service.snapshot('month');
    expect(snapshot.balances['1'], 1000.0);
    expect(snapshot.balances['4'], -1000.0);
  });

  test('posting unbalanced journal entry is rejected by service', () async {
    final repo = MockLedgerRepository();
    final service = LedgerService(repo);

    final entry = JournalEntry(
      id: 'je2',
      date: DateTime.now(),
      reference: 'INV-2',
      lines: [
        TransactionLine(accountId: '1', amount: 1000.0, currency: 'USD'),
        TransactionLine(accountId: '4', amount: -900.0, currency: 'USD'),
      ],
    );

    await expectLater(service.postEntry(entry), throwsA(isA<ArgumentError>()));
  });

  test('posting empty journal entry is rejected by service', () async {
    final repo = MockLedgerRepository();
    final service = LedgerService(repo);

    final entry = JournalEntry(
      id: 'je-empty',
      date: DateTime.now(),
      reference: 'INV-3',
      lines: const [],
    );

    await expectLater(service.postEntry(entry), throwsA(isA<ArgumentError>()));
  });
}
