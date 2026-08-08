import 'package:flutter/foundation.dart';

import 'workflow_task.dart';

/// Drives the workflow copilot overlay: the active task and the current step.
///
/// This is transient UI state only. Which task is active and which steps were
/// completed lives in [WorkflowProgress] (see workflow_provider.dart) so the
/// user can pause and resume later.
class WorkflowController extends ChangeNotifier {
  WorkflowTask? _task;
  int _currentIndex = 0;
  bool _isVisible = false;

  WorkflowTask? get task => _task;
  int get currentIndex => _currentIndex;
  bool get isVisible => _isVisible;

  WorkflowStep? get currentStep =>
      _isVisible ? _task?.stepAt(_currentIndex) : null;

  int get stepNumber => _currentIndex + 1;
  int get totalSteps => _task?.steps.length ?? 0;
  bool get isLast => _task != null && _currentIndex == _task!.steps.length - 1;

  /// The step after the current one, or null on the last step.
  WorkflowStep? get nextStep => _task?.stepAt(_currentIndex + 1);

  /// Begins showing [task] at [fromIndex] (defaults to the first step).
  void start(WorkflowTask task, {int fromIndex = 0}) {
    if (task.steps.isEmpty) return;
    _task = task;
    _currentIndex = fromIndex.clamp(0, task.steps.length - 1);
    _isVisible = true;
    notifyListeners();
  }

  /// Advances to the next step; hides the overlay after the last step.
  void next() {
    if (_task == null) return;
    if (_currentIndex < _task!.steps.length - 1) {
      _currentIndex += 1;
      notifyListeners();
    } else {
      stop();
    }
  }

  /// Hides the overlay. Progress is untouched, so the task can be resumed.
  void stop() {
    _isVisible = false;
    _task = null;
    _currentIndex = 0;
    notifyListeners();
  }
}
