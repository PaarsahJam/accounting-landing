import 'dart:async';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/workflow_approval.dart';
import '../domain/workflow_instance.dart';

abstract class WorkflowRepository {
  Future<AppResult<List<WorkflowInstance>>> fetchInstances({
    String? definitionId,
    String? entityId,
  });

  Future<AppResult<WorkflowInstance>> fetchInstance(String id);

  Future<AppResult<WorkflowInstance>> saveInstance(WorkflowInstance instance);

  Future<AppResult<WorkflowInstance>> addApprovalEntry({
    required String instanceId,
    required String approverId,
    required String approverName,
    required ApprovalDecision decision,
    String? note,
  });

  Future<AppResult<void>> deleteInstance(String id);
}

class MockWorkflowRepository implements WorkflowRepository {
  final List<WorkflowInstance> _instances = [];

  MockWorkflowRepository() {
    _seed();
  }

  void _seed() {}

  @override
  Future<AppResult<List<WorkflowInstance>>> fetchInstances({
    String? definitionId,
    String? entityId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      var result = _instances.toList();
      if (definitionId != null) {
        result = result.where((i) => i.definitionId == definitionId).toList();
      }
      if (entityId != null) {
        result = result.where((i) => i.entityId == entityId).toList();
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<WorkflowInstance>> fetchInstance(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final instance = _instances.firstWhere(
        (i) => i.id == id,
        orElse: () => throw Exception('Instance not found: $id'),
      );
      return AppResult.success(instance);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<WorkflowInstance>> saveInstance(
    WorkflowInstance instance,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final index = _instances.indexWhere((i) => i.id == instance.id);
      if (index >= 0) {
        _instances[index] = instance;
      } else {
        _instances.add(instance);
      }
      return AppResult.success(instance);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<WorkflowInstance>> addApprovalEntry({
    required String instanceId,
    required String approverId,
    required String approverName,
    required ApprovalDecision decision,
    String? note,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final index = _instances.indexWhere((i) => i.id == instanceId);
      if (index < 0) {
        return AppResult.failure(
          UnknownFailure(message: 'Instance not found: $instanceId'),
        );
      }
      final instance = _instances[index];
      final entry = WorkflowApprovalEntry(
        approverId: approverId,
        approverName: approverName,
        decision: decision,
        note: note,
        decidedAt: DateTime.now(),
      );
      final updated = instance.copyWith(
        approval: instance.approval.copyWith(
          currentApprovals: [...instance.approval.currentApprovals, entry],
        ),
        updatedAt: DateTime.now(),
      );
      _instances[index] = updated;
      return AppResult.success(updated);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> deleteInstance(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _instances.removeWhere((i) => i.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }
}
