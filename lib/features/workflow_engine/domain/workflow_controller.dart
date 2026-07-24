import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../audit_trail/domain/audit_entity_type.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/workflow_repository.dart';
import '../data/workflow_repository_provider.dart';
import 'workflow_approval.dart';
import 'workflow_engine.dart';
import 'workflow_instance.dart';
import 'workflow_registry.dart';

part 'workflow_controller.g.dart';

@riverpod
class WorkflowInstanceController extends _$WorkflowInstanceController {
  late final WorkflowRepository _repository;
  late final WorkflowEngine _engine;

  @override
  FutureOr<List<WorkflowInstance>> build() async {
    _repository = ref.watch(workflowRepositoryProvider);
    _engine = WorkflowEngine(registry: WorkflowRegistry());
    final result = await _repository.fetchInstances();
    if (result.isSuccess) {
      return result.data ?? const <WorkflowInstance>[];
    }
    AppLogger.warning('Failed to load workflow instances', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<WorkflowInstance?> getInstanceForEntity({
    required String definitionId,
    required String entityId,
  }) async {
    final instances = state.asData?.value ?? <WorkflowInstance>[];
    try {
      return instances.firstWhere(
        (i) => i.definitionId == definitionId && i.entityId == entityId,
      );
    } catch (_) {
      return null;
    }
  }

  Future<TransitionResult> executeTransition({
    required WorkflowInstance instance,
    required String transitionId,
    required String performedBy,
    String? note,
    Map<String, dynamic>? contextOverride,
  }) async {
    final result = await _engine.transition(
      instance: instance,
      transitionId: transitionId,
      performedBy: performedBy,
      note: note,
      contextOverride: contextOverride,
    );
    if (!result.isSuccess) {
      throw result.error ?? const UnknownFailure(message: 'Transition failed');
    }
    final transitionResult = result.data!;
    if (!transitionResult.succeeded) {
      throw ValidationFailure(
        message:
            'Transition conditions failed: ${transitionResult.conditionsFailed.join(", ")}',
      );
    }
    final saveResult =
        await _repository.saveInstance(transitionResult.instance);
    if (!saveResult.isSuccess) {
      throw saveResult.error ??
          const UnknownFailure(message: 'Failed to persist transition');
    }
    final current = state.asData?.value ?? <WorkflowInstance>[];
    state = AsyncValue.data(
      current
          .map((i) => i.id == transitionResult.instance.id
              ? transitionResult.instance
              : i)
          .toList(),
    );
    return transitionResult;
  }

  Future<WorkflowInstance> createAndSaveInstance({
    required String definitionId,
    required String entityId,
    required AuditEntityType entityType,
    Map<String, dynamic> context = const {},
  }) async {
    final instance = await _engine.createInstance(
      definitionId: definitionId,
      entityId: entityId,
      entityType: entityType,
      context: context,
    );
    final saveResult = await _repository.saveInstance(instance);
    if (!saveResult.isSuccess) {
      throw saveResult.error ??
          const UnknownFailure(message: 'Failed to save instance');
    }
    final current = state.asData?.value ?? <WorkflowInstance>[];
    state = AsyncValue.data([...current, instance]);
    return instance;
  }

  Future<WorkflowInstance> addApproval({
    required WorkflowInstance instance,
    required String approverId,
    required String approverName,
    required ApprovalDecision decision,
    String? note,
  }) async {
    final result = await _repository.addApprovalEntry(
      instanceId: instance.id,
      approverId: approverId,
      approverName: approverName,
      decision: decision,
      note: note,
    );
    if (!result.isSuccess) {
      throw result.error ??
          const UnknownFailure(message: 'Failed to add approval');
    }
    final current = state.asData?.value ?? <WorkflowInstance>[];
    state = AsyncValue.data(
      current
          .map((i) => i.id == result.data!.id ? result.data! : i)
          .toList(),
    );
    return result.data!;
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchInstances();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <WorkflowInstance>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh workflow instances', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
