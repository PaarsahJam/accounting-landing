import 'package:flutter/widgets.dart';

/// A single guided step within a [WorkflowTask].
///
/// Each step deep-links to [route] and explains why the step matters in
/// [body]. [targetKey] points the copilot at the relevant widget on that
/// route (a page header, an action button, a metric, ...).
class WorkflowStep {
  const WorkflowStep({
    required this.id,
    required this.title,
    required this.body,
    required this.route,
    this.targetKey,
  });

  /// Stable id used for progress tracking.
  final String id;

  /// Localized heading describing what to do in this step.
  final String title;

  /// Localized plain-language explanation of why this step matters.
  final String body;

  /// Route to deep-link to for this step (e.g. '/sales-invoices').
  final String route;

  /// Optional widget to highlight on the destination page.
  final GlobalKey? targetKey;
}

/// A task-based workflow made of ordered [steps].
class WorkflowTask {
  const WorkflowTask({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
  });

  /// Stable id used for progress tracking.
  final String id;

  /// Localized title shown in the copilot panel.
  final String title;

  /// One-line description shown in the copilot panel.
  final String description;

  /// Ordered steps the user works through.
  final List<WorkflowStep> steps;

  int get totalSteps => steps.length;

  WorkflowStep? stepAt(int index) =>
      (index >= 0 && index < steps.length) ? steps[index] : null;
}
