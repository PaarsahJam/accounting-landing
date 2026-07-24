import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/crm_repository.dart';
import '../data/crm_repository_provider.dart';
import 'crm_task.dart';

part 'crm_tasks_controller.g.dart';

@riverpod
class CrmTasksController extends _$CrmTasksController {
  late final CrmRepository _repository;

  @override
  FutureOr<List<CrmTask>> build({String? customerId}) async {
    _repository = ref.watch(crmRepositoryProvider);
    final result = await _repository.fetchTasks(customerId: customerId);
    if (result.isSuccess) {
      return result.data ?? const <CrmTask>[];
    }
    AppLogger.warning('Failed to load tasks', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createTask(CrmTask task) async {
    try {
      final result = await _repository.createTask(task);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <CrmTask>[];
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, _) {
      AppLogger.warning('Failed to create task', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> updateTask(CrmTask task) async {
    try {
      final result = await _repository.updateTask(task);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <CrmTask>[];
      final next = current
          .map((t) => t.id == result.data!.id ? result.data! : t)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, _) {
      AppLogger.warning('Failed to update task', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final result = await _repository.deleteTask(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.asData?.value ?? <CrmTask>[];
      state = AsyncValue.data(current.where((t) => t.id != id).toList());
    } catch (e, _) {
      AppLogger.warning('Failed to delete task', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }

  Future<void> refresh() async {
    try {
      final result = await _repository.fetchTasks();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <CrmTask>[]);
    } catch (e, _) {
      AppLogger.warning('Failed to refresh tasks', error: e);
      if (!state.hasError) {
        state = AsyncValue.error(e, StackTrace.current);
      }
    }
  }
}
