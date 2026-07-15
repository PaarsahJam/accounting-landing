import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/finance/journal_entry.dart';
import 'package:accounting_app/core/finance/transaction_line.dart';

void main() {
  test('journal entry is balanced and validate() succeeds', () {
    final lines = [
      TransactionLine(accountId: '1', amount: 500.0, currency: 'USD'),
      TransactionLine(accountId: '4', amount: -500.0, currency: 'USD'),
    ];
    final entry = JournalEntry(
      id: 'e1',
      date: DateTime.now(),
      reference: 'T1',
      lines: lines,
    );
    expect(entry.isBalanced, isTrue);
    expect(() => entry.validate(), returnsNormally);
  });

  test('journal entry with zero lines is not balanced', () {
    final entry = JournalEntry(
      id: 'e0',
      date: DateTime.now(),
      reference: 'T0',
      lines: const [],
    );

    expect(entry.isBalanced, isFalse);
    expect(() => entry.validate(), throwsArgumentError);
  });

  test('journal entry with negative values can still be balanced', () {
    final lines = [
      TransactionLine(accountId: '1', amount: -250.0, currency: 'USD'),
      TransactionLine(accountId: '4', amount: 250.0, currency: 'USD'),
    ];
    final entry = JournalEntry(
      id: 'e-neg',
      date: DateTime.now(),
      reference: 'T-neg',
      lines: lines,
    );

    expect(entry.isBalanced, isTrue);
    expect(() => entry.validate(), returnsNormally);
  });

  test('journal entry rounds to cents when checking balance', () {
    final lines = [
      TransactionLine(accountId: '1', amount: 10.005, currency: 'USD'),
      TransactionLine(accountId: '4', amount: -10.004, currency: 'USD'),
    ];
    final entry = JournalEntry(
      id: 'e-round',
      date: DateTime.now(),
      reference: 'T-round',
      lines: lines,
    );

    expect(entry.isBalanced, isTrue);
    expect(() => entry.validate(), returnsNormally);
  });

  test('journal entry unbalanced triggers validate error', () {
    final lines = [
      TransactionLine(accountId: '1', amount: 500.0, currency: 'USD'),
      TransactionLine(accountId: '4', amount: -400.0, currency: 'USD'),
    ];
    final entry = JournalEntry(
      id: 'e2',
      date: DateTime.now(),
      reference: 'T2',
      lines: lines,
    );
    expect(entry.isBalanced, isFalse);
    expect(() => entry.validate(), throwsArgumentError);
  });
}
