import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../audit_trail/domain/audit_entity_type.dart';
import '../../user_roles/domain/authorization.dart';
import '../../user_roles/domain/permission.dart';
import '../../user_roles/domain/user_roles_controller.dart';
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
    // Authorization gate: only callers holding postJournal may advance a
    // workflow. Fails closed — an unauthenticated caller (null current user)
    // has no permission, so requirePermission throws AuthorizationFailure.
    ref.requirePermission(
      Permission.postJournal,
      action: 'execute this workflow transition',
    );
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
    // Authorization gate: creating a workflow instance starts a mutation path.
    ref.requirePermission(
      Permission.postJournal,
      action: 'start this workflow',
    );
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
    // Authorization gate (fail closed): recording an approval mutates workflow
    // state, so require the postJournal permission first. This denies callers
    // with no authenticated user *before* any role IDs are forwarded — the
    // engine's approverRoles guard bypasses an empty callerRoleIds list, so we
    // must not rely on forwarding alone to keep unauthenticated callers out.
    ref.requirePermission(
      Permission.postJournal,
      action: 'approve this workflow',
    );

    // Route through the engine so its approverRoles guard is also enforced. The
    // caller's role IDs are read from the current signed-in user; passing them
    // in prevents a user without an approver role from recording an approval
    // even if the UI approval control is bypassed. The gate above guarantees a
    // non-null current user here, so callerRoleIds is never empty.
    final currentUser = ref.read(currentUserControllerProvider).value;
    final callerRoleIds =
        currentUser == null ? const <String>[] : [currentUser.roleId];

    final engineResult = await _engine.addApproval(
      instance: instance,
      approverId: approverId,
      approverName: approverName,
      decision: decision,
      callerRoleIds: callerRoleIds,
      note: note,
    );
    if (!engineResult.isSuccess) {
      throw engineResult.error ??
          const UnknownFailure(message: 'Failed to add approval');
    }

    final saveResult = await _repository.saveInstance(engineResult.data!);
    if (!saveResult.isSuccess) {
      throw saveResult.error ??
          const UnknownFailure(message: 'Failed to persist approval');
    }
    final current = state.asData?.value ?? <WorkflowInstance>[];
    state = AsyncValue.data(
      current
          .map((i) => i.id == saveResult.data!.id ? saveResult.data! : i)
          .toList(),
    );
    return saveResult.data!;
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
