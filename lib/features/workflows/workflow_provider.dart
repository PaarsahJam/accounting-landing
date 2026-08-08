import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/secure_storage.dart';
import 'domain/workflow_controller.dart';
import 'domain/workflow_progress.dart';

part 'workflow_provider.g.dart';

const _workflowProgressKey = 'workflow_copilot_progress';

/// Singleton copilot controller shared by the trigger, overlay and panel.
@Riverpod(keepAlive: true)
WorkflowController workflowController(Ref ref) => WorkflowController();

/// Encodes [progress] for storage as a JSON object.
String encodeWorkflowProgress(WorkflowProgress progress) => jsonEncode({
      'activeTaskId': progress.activeTaskId,
      'completedStepIds': progress.completedStepIds.toList()..sort(),
      'finishedTaskIds': progress.finishedTaskIds.toList()..sort(),
    });

/// Decodes a stored JSON object back into [WorkflowProgress].
WorkflowProgress decodeWorkflowProgress(String? raw) {
  if (raw == null || raw.isEmpty) return WorkflowProgress.empty;
  try {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return WorkflowProgress(
      activeTaskId: map['activeTaskId'] as String?,
      completedStepIds:
          ((map['completedStepIds'] as List?) ?? const [])
              .whereType<String>()
              .toSet(),
      finishedTaskIds:
          ((map['finishedTaskIds'] as List?) ?? const [])
              .whereType<String>()
              .toSet(),
    );
  } catch (_) {
    return WorkflowProgress.empty;
  }
}

/// Tracks the active workflow task, its completed steps, and finished tasks.
///
/// Persisted in secure storage so a task can be resumed after the app is
/// closed. Persistence is best-effort: storage failures are ignored.
@Riverpod(keepAlive: true)
class WorkflowProgressNotifier extends _$WorkflowProgressNotifier {
  @override
  WorkflowProgress build() {
    _load();
    return WorkflowProgress.empty;
  }

  Future<void> _load() async {
    try {
      final raw = await SecureStorage.instance.read(_workflowProgressKey);
      final stored = decodeWorkflowProgress(raw);
      if (stored.isActive || stored.finishedTaskIds.isNotEmpty) {
        state = stored;
      }
    } catch (_) {
      // Ignore: the copilot simply starts fresh.
    }
  }

  Future<void> _persist() async {
    try {
      await SecureStorage.instance.write(
        _workflowProgressKey,
        encodeWorkflowProgress(state),
      );
    } catch (_) {
      // Persistence is best-effort; keep the in-memory state.
    }
  }

  /// Makes [taskId] the active task, resetting its step progress.
  Future<void> start(String taskId) async {
    state = WorkflowProgress(
      activeTaskId: taskId,
      finishedTaskIds: state.finishedTaskIds,
    );
    await _persist();
  }

  /// Records [stepId] as completed within the active task.
  Future<void> markStepComplete(String stepId) async {
    final current = state;
    if (!current.isActive) return;
    if (current.completedStepIds.contains(stepId)) return;
    state = WorkflowProgress(
      activeTaskId: current.activeTaskId,
      completedStepIds: {...current.completedStepIds, stepId},
      finishedTaskIds: current.finishedTaskIds,
    );
    await _persist();
  }

  /// Marks the active task as finished and clears the active slot.
  Future<void> finishTask() async {
    final current = state;
    if (!current.isActive) return;
    state = WorkflowProgress(
      finishedTaskIds: {...current.finishedTaskIds, current.activeTaskId!},
    );
    await _persist();
  }

  /// Cancels the active task. Step progress is discarded so the task starts
  /// fresh next time; finished tasks are kept.
  Future<void> cancel() async {
    state = WorkflowProgress(finishedTaskIds: state.finishedTaskIds);
    await _persist();
  }

  /// Clears all copilot progress (used for testing and re-enabling).
  Future<void> reset() async {
    state = WorkflowProgress.empty;
    try {
      await SecureStorage.instance.delete(_workflowProgressKey);
    } catch (_) {
      // Best-effort.
    }
  }
}
