import 'journal_entry.dart';
import 'chart_of_accounts.dart';
import 'balance_snapshot.dart';

abstract class LedgerRepository {
  Future<void> postJournalEntry(JournalEntry entry);
  Future<List<JournalEntry>> fetchEntries();
  Future<BalanceSnapshot> calculateBalanceSnapshot({required String periodId});
  Future<ChartOfAccounts> fetchChartOfAccounts();
}

class MockLedgerRepository implements LedgerRepository {
  final List<JournalEntry> _entries = [];
  final ChartOfAccounts _chart = ChartOfAccounts.mockDefault();

  @override
  Future<void> postJournalEntry(JournalEntry entry) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _entries.add(entry);
  }

  @override
  Future<List<JournalEntry>> fetchEntries() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return List.unmodifiable(_entries);
  }

  @override
  Future<ChartOfAccounts> fetchChartOfAccounts() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return _chart;
  }

  @override
  Future<BalanceSnapshot> calculateBalanceSnapshot({
    required String periodId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final Map<String, double> balances = {};
    for (final entry in _entries) {
      for (final line in entry.lines) {
        balances[line.accountId] =
            (balances[line.accountId] ?? 0) + line.amount;
      }
    }
    return BalanceSnapshot(
      periodId: periodId,
      balances: Map.unmodifiable(balances),
    );
  }
}
