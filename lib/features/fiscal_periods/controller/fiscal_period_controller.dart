// lib/features/fiscal_periods/controller/fiscal_period_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/fiscal_period_repository.dart';

class FiscalPeriodController extends StateNotifier<List<FiscalPeriod>> {
  final FiscalPeriodRepository _repository;

  FiscalPeriodController(this._repository) : super([]);

  Future<void> load() async {
    state = await _repository.load();
  }

  Future<void> add(FiscalPeriod fiscalPeriod) async {
    await _repository.add(fiscalPeriod);
    await load();
  }

  Future<void> update(FiscalPeriod fiscalPeriod) async {
    await _repository.update(fiscalPeriod);
    await load();
  }

  Future<void> delete(int id) async {
    await _repository.delete(id);
    await load();
  }
}

final fiscalPeriodControllerProvider = StateNotifierProvider<FiscalPeriodController, List<FiscalPeriod>>((ref) {
  return FiscalPeriodController(ref.watch(fiscalPeriodRepositoryProvider));
});