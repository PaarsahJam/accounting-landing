// lib/features/fiscal_periods/repository/fiscal_year_repository.dart

import 'package:accounting_app/features/fiscal_periods/domain/trial_balance_entry.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../domain/fiscal_year.dart';

class FiscalYearRepository extends StateNotifier<List<FiscalYear>> {
  FiscalYearRepository() : super([]);

  Future<void> load() async {
    // Simulate fetching data from a database.
    state = [
      FiscalYear(id: 1, year: 2023, status: FiscalYearStatus.active, startDate: DateTime(2023, 1, 1), endDate: DateTime(2023, 12, 31)),
    ];
  }

  Future<void> add(FiscalYear fiscalYear) async {
    state = [...state, fiscalYear];
  }

  Future<void> update(FiscalYear fiscalYear) async {
    final index = state.indexWhere((e) => e.id == fiscalYear.id);
    if (index != -1) {
      state[index] = fiscalYear;
    }
  }

  Future<void> delete(int id) async {
    state.removeWhere((e) => e.id == id);
  }

  Future<List<TrialBalanceEntry>> validateTrialBalance(int fiscalYearId) async {
    // Use repository adapter to validate trial balance.
    return [];
  }

  Future<List<FiscalYear>> getFiscalYears() async => state;

}

final fiscalYearRepositoryProvider = StateNotifierProvider<FiscalYearRepository, List<FiscalYear>>((ref) {
  return FiscalYearRepository();
});