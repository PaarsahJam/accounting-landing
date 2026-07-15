import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/dashboard_repository.dart';
import '../data/dashboard_repository_provider.dart';
import 'dashboard_metrics.dart';

part 'dashboard_metrics_controller.g.dart';

@riverpod
class DashboardMetricsController extends _$DashboardMetricsController {
  late final DashboardRepository _repository;

  @override
  FutureOr<DashboardMetrics> build() async {
    _repository = ref.watch(dashboardRepositoryProvider);
    final result = await _repository.fetchMetrics();
    if (result.isSuccess) {
      return result.data!;
    }
    AppLogger.warning('Failed to load dashboard metrics', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchMetrics();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data!);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh dashboard metrics', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
