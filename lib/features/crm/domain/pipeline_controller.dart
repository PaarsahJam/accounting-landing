import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/crm_repository.dart';
import '../data/crm_repository_provider.dart';
import 'lead_opportunity.dart';

part 'pipeline_controller.g.dart';

@riverpod
class PipelineController extends _$PipelineController {
  late final CrmRepository _repository;

  @override
  FutureOr<List<LeadOpportunity>> build({
    String? customerId,
    PipelineStage? stage,
  }) async {
    _repository = ref.watch(crmRepositoryProvider);
    final result = await _repository.fetchOpportunities(
      customerId: customerId,
      stage: stage,
    );
    if (result.isSuccess) {
      return result.data ?? const <LeadOpportunity>[];
    }
    AppLogger.warning('Failed to load opportunities', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createOpportunity(LeadOpportunity opportunity) async {
    try {
      final result = await _repository.createOpportunity(opportunity);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <LeadOpportunity>[];
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, _) {
      AppLogger.warning('Failed to create opportunity', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> updateOpportunity(LeadOpportunity opportunity) async {
    try {
      final result = await _repository.updateOpportunity(opportunity);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <LeadOpportunity>[];
      final next = current
          .map((o) => o.id == result.data!.id ? result.data! : o)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, _) {
      AppLogger.warning('Failed to update opportunity', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> deleteOpportunity(String id) async {
    try {
      final result = await _repository.deleteOpportunity(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <LeadOpportunity>[];
      state = AsyncValue.data(current.where((o) => o.id != id).toList());
    } catch (e, _) {
      AppLogger.warning('Failed to delete opportunity', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    try {
      final result = await _repository.fetchOpportunities();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <LeadOpportunity>[]);
    } catch (e, _) {
      AppLogger.warning('Failed to refresh opportunities', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }
}
