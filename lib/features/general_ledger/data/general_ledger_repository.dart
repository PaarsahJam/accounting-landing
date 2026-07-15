import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/finance/balance_snapshot.dart';
import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/ledger_account.dart';
import '../../../core/finance/ledger_account_type.dart';
import '../../../core/finance/ledger_repository.dart';
import '../../../core/finance/transaction_line.dart';
import '../domain/account_detail_view_data.dart';
import '../domain/general_ledger_view_data.dart';

abstract class GeneralLedgerRepository {
  Future<AppResult<GeneralLedgerViewData>> fetchViewData();
  Future<AppResult<AccountDetailViewData>> fetchAccountDetail(String accountId);
}

class MockGeneralLedgerRepository implements GeneralLedgerRepository {
  final LedgerRepository _ledgerRepository;

  MockGeneralLedgerRepository({LedgerRepository? ledgerRepository})
    : _ledgerRepository = ledgerRepository ?? MockLedgerRepository();

  @override
  Future<AppResult<GeneralLedgerViewData>> fetchViewData() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));

      final chart = await _ledgerRepository.fetchChartOfAccounts();
      var entries = await _ledgerRepository.fetchEntries();
      if (entries.isEmpty) {
        entries = _buildSampleEntries(chart.accounts);
      }

      var snapshot = await _ledgerRepository.calculateBalanceSnapshot(
        periodId: '2026-06',
      );
      if (snapshot.balances.isEmpty) {
        snapshot = _buildSnapshot(entries, '2026-06');
      }

      final trialBalance = _buildTrialBalance(chart.accounts, entries);

      return AppResult.success(
        GeneralLedgerViewData(
          accounts: chart.accounts,
          entries: entries,
          snapshot: snapshot,
          trialBalance: trialBalance,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<AccountDetailViewData>> fetchAccountDetail(
    String accountId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final chart = await _ledgerRepository.fetchChartOfAccounts();
      final account = chart.accounts.firstWhere(
        (item) => item.id == accountId,
        orElse: () => chart.accounts.first,
      );
      final entries = await _ledgerRepository.fetchEntries();
      final workingEntries = entries.isEmpty
          ? _buildSampleEntries(chart.accounts)
          : entries;
      final transactionViews = _buildTransactionViews(account, workingEntries);
      final currentBalance = transactionViews.fold<double>(
        account.openingBalance,
        (sum, item) => sum + item.amount,
      );

      return AppResult.success(
        AccountDetailViewData(
          account: account,
          transactions: transactionViews,
          currentBalance: currentBalance,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  List<JournalEntry> _buildSampleEntries(List<LedgerAccount> accounts) {
    final cash = _accountByCode(accounts, '1000');
    final revenue = _accountByCode(accounts, '4000');
    final expense = _accountByCode(accounts, '5000');

    return [
      JournalEntry(
        id: 'je-001',
        date: DateTime(2026, 6, 1),
        reference: 'INV-1001',
        memo: 'Service revenue for June',
        lines: [
          TransactionLine(
            accountId: cash.id,
            amount: 5000,
            currency: cash.currency,
            description: 'Cash received',
          ),
          TransactionLine(
            accountId: revenue.id,
            amount: -5000,
            currency: revenue.currency,
            description: 'Revenue recognized',
          ),
        ],
      ),
      JournalEntry(
        id: 'je-002',
        date: DateTime(2026, 6, 3),
        reference: 'EXP-2001',
        memo: 'Office supplies',
        lines: [
          TransactionLine(
            accountId: expense.id,
            amount: 1200,
            currency: expense.currency,
            description: 'Supplies expense',
          ),
          TransactionLine(
            accountId: cash.id,
            amount: -1200,
            currency: cash.currency,
            description: 'Cash disbursement',
          ),
        ],
      ),
    ];
  }

  List<AccountTransactionView> _buildTransactionViews(
    LedgerAccount account,
    List<JournalEntry> entries,
  ) {
    final views = <AccountTransactionView>[];

    for (final entry in entries) {
      for (final line in entry.lines) {
        if (line.accountId != account.id) {
          continue;
        }

        final amount = line.amount;
        final isDebit = amount >= 0;
        views.add(
          AccountTransactionView(
            entry: entry,
            amount: amount.abs(),
            isDebit: isDebit,
            description: line.description ?? entry.reference,
          ),
        );
      }
    }

    return views;
  }

  BalanceSnapshot _buildSnapshot(List<JournalEntry> entries, String periodId) {
    final balances = <String, double>{};
    for (final entry in entries) {
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

  LedgerAccount _accountByCode(List<LedgerAccount> accounts, String code) {
    return accounts.firstWhere((account) => account.code == code);
  }

  List<TrialBalanceLine> _buildTrialBalance(
    List<LedgerAccount> accounts,
    List<JournalEntry> entries,
  ) {
    final totals = <String, double>{};
    for (final entry in entries) {
      for (final line in entry.lines) {
        totals[line.accountId] = (totals[line.accountId] ?? 0) + line.amount;
      }
    }

    return accounts.map((account) {
      final balance = totals[account.id] ?? 0;
      final isCredit =
          account.type == LedgerAccountType.liability ||
          account.type == LedgerAccountType.equity ||
          account.type == LedgerAccountType.revenue;
      return TrialBalanceLine(
        account: account,
        debit: isCredit ? 0 : balance.abs(),
        credit: isCredit ? balance.abs() : 0,
      );
    }).toList();
  }
}
