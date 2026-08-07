// lib/features/fiscal_periods/repository/fiscal_period_repository.dart

import 'package:flutter_riverpod/legacy.dart';
import '../domain/fiscal_period.dart';

class FiscalPeriodRepository extends StateNotifier<List<FiscalPeriod>> {
  FiscalPeriodRepository() : super([]);

  Future<void> load() async {
    // Defer to the next microtask so the provider is not modified while the
    // widget tree is still building (Riverpod disallows in-build mutation).
    await Future<void>.delayed(Duration.zero);
    // Simulate fetching data from a database.
    state = [
      FiscalPeriod(
        id: 1,
        fiscalYearId: 1,
        periodNumber: 1,
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 1, 31),
        status: FiscalPeriodStatus.open,
      ),
    ];
  }

  Future<void> add(FiscalPeriod fiscalPeriod) async {
    state = [...state, fiscalPeriod];
  }

  Future<void> update(FiscalPeriod fiscalPeriod) async {
    final index = state.indexWhere((e) => e.id == fiscalPeriod.id);
    if (index != -1) {
      state[index] = fiscalPeriod;
    }
  }

  Future<void> delete(int id) async {
    state.removeWhere((e) => e.id == id);
  }
}

final fiscalPeriodRepositoryProvider =
    StateNotifierProvider<FiscalPeriodRepository, List<FiscalPeriod>>((ref) {
      return FiscalPeriodRepository();
    });
