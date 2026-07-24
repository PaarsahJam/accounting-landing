import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/crm_repository.dart';
import '../data/crm_repository_provider.dart';
import 'crm_dashboard_data.dart';

part 'crm_dashboard_controller.g.dart';

@riverpod
class CrmDashboardController extends _$CrmDashboardController {
  late final CrmRepository _repository;

  @override
  FutureOr<CrmDashboardData> build() async {
    _repository = ref.watch(crmRepositoryProvider);
    final result = await _repository.fetchDashboardData();
    if (result.isSuccess) {
      return result.data!;
    }
    AppLogger.warning('Failed to load CRM dashboard', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchDashboardData();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data!);
    } catch (e, _) {
      AppLogger.warning('Failed to refresh CRM dashboard', error: e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
