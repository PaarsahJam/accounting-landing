import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/crm_repository.dart';
import '../data/crm_repository_provider.dart';
import 'interaction.dart';

part 'interactions_controller.g.dart';

@riverpod
class InteractionsController extends _$InteractionsController {
  late final CrmRepository _repository;
  late String _contactId;

  @override
  FutureOr<List<Interaction>> build(String contactId) async {
    _contactId = contactId;
    _repository = ref.watch(crmRepositoryProvider);
    final result = await _repository.fetchInteractions(contactId);
    if (result.isSuccess) {
      return result.data ?? const <Interaction>[];
    }
    AppLogger.warning('Failed to load interactions', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createInteraction(Interaction interaction) async {
    try {
      final result = await _repository.createInteraction(interaction);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <Interaction>[];
      state = AsyncValue.data([result.data!, ...current]);
    } catch (e, _) {
      AppLogger.warning('Failed to create interaction', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> deleteInteraction(String id) async {
    try {
      final result = await _repository.deleteInteraction(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <Interaction>[];
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, _) {
      AppLogger.warning('Failed to delete interaction', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    try {
      final result = await _repository.fetchInteractions(_contactId);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Interaction>[]);
    } catch (e, _) {
      AppLogger.warning('Failed to refresh interactions', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }
}
