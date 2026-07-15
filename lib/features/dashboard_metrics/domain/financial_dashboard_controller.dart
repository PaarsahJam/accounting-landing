import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/financial_dashboard_repository.dart';
import '../data/financial_dashboard_repository_provider.dart';
import 'financial_dashboard.dart';

part 'financial_dashboard_controller.g.dart';

@riverpod
class FinancialDashboardController extends _$FinancialDashboardController {
  late final FinancialDashboardRepository _repository;

  @override
  FutureOr<FinancialDashboard> build() async {
    _repository = ref.watch(financialDashboardRepositoryProvider);
    final result = await _repository.fetchDashboard();
    if (result.isSuccess) {
      return result.data!;
    }
    AppLogger.warning(
      'Failed to load financial dashboard',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchDashboard();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (ref.mounted) {
        state = AsyncValue.data(result.data!);
      }
    } catch (e, st) {
      AppLogger.warning('Failed to refresh financial dashboard', error: e);
      if (ref.mounted) {
        state = AsyncValue.error(e, st);
      }
    }
  }
}
