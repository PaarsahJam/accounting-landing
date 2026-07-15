// lib/features/fiscal_periods/controller/fiscal_year_controller.dart

import 'package:accounting_app/features/fiscal_periods/domain/fiscal_year.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repository/fiscal_year_repository.dart';

class FiscalYearController extends StateNotifier<List<FiscalYear>> {
  final FiscalYearRepository _repository;

  FiscalYearController(this._repository) : super([]);

  Future<void> load() async {
    state = await _repository.load();
  }

  Future<void> add(FiscalYear fiscalYear) async {
    await _repository.add(fiscalYear);
    await load();
  }

  Future<void> update(FiscalYear fiscalYear) async {
    await _repository.update(fiscalYear);
    await load();
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
    await load();
  }

  Future<void> activate(int id) async {
    final fiscalYear = state.firstWhere((e) => e.id == id);
    await _repository.update(fiscalYear.copyWith(status: FiscalYearStatus.active));
    await load();
  }

  Future<void> archive(int id) async {
    final fiscalYear = state.firstWhere((e) => e.id == id);
    await _repository.update(fiscalYear.copyWith(status: FiscalYearStatus.archived));
    await load();
  }
}

final fiscalYearControllerProvider = StateNotifierProvider<FiscalYearController, List<FiscalYear>>((ref) {
  return FiscalYearController(ref.watch(fiscalYearRepositoryProvider));
});