import 'ledger_repository.dart';
import 'journal_entry.dart';
import 'balance_snapshot.dart';

class LedgerService {
  final LedgerRepository repository;

  const LedgerService(this.repository);

  Future<void> postEntry(JournalEntry entry) async {
    // Validate double-entry invariant before posting
    entry.validate();
    await repository.postJournalEntry(entry);
  }

  Future<List<JournalEntry>> entries() => repository.fetchEntries();

  Future<BalanceSnapshot> snapshot(String periodId) =>
      repository.calculateBalanceSnapshot(periodId: periodId);

  Future<void> ensureChartInitialized() async {
    await repository.fetchChartOfAccounts();
  }
}
