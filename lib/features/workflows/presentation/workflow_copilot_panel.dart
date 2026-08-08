import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../domain/workflow_definitions.dart';
import '../domain/workflow_progress.dart';
import '../domain/workflow_task.dart';
import '../workflow_provider.dart';

/// Dashboard entry point for the workflow copilot.
///
/// Lists suggested, active and finished tasks with Start / Resume actions that
/// deep-link into the right module; the trigger then walks the user through
/// the steps.
class WorkflowCopilotPanel extends ConsumerWidget {
  const WorkflowCopilotPanel({super.key});

  Future<void> _launch(
    BuildContext context,
    WidgetRef ref,
    WorkflowTask task, {
    required int fromIndex,
  }) async {
    await ref.read(workflowProgressProvider.notifier).start(task.id);
    if (!context.mounted) return;
    final step = task.stepAt(fromIndex);
    if (step == null) return;
    if (GoRouterState.of(context).matchedLocation == step.route) {
      ref
          .read(workflowControllerProvider)
          .start(task, fromIndex: fromIndex);
    } else {
      // The trigger opens the overlay when the new route matches the step.
      context.go(step.route);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final progress = ref.watch(workflowProgressProvider);
    final tasks = buildWorkflowTasks(l10n);

    final suggested = tasks
        .where(
          (task) =>
              !progress.isFinished(task.id) &&
              task.id != progress.activeTaskId,
        )
        .toList();
    final active = progress.isActive
        ? tasks.where((task) => task.id == progress.activeTaskId).toList()
        : const <WorkflowTask>[];
    final finished = tasks.where((task) => progress.isFinished(task.id)).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.support_agent,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.workflowCopilotTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.workflowCopilotSubtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...active.map(
              (task) => _TaskTile(
                task: task,
                progress: progress,
                active: true,
                onAction: () => _launch(
                  context,
                  ref,
                  task,
                  fromIndex: firstIncompleteIndex(
                    task,
                    progress.completedStepIds,
                  ),
                ),
              ),
            ),
            ...suggested.map(
              (task) => _TaskTile(
                task: task,
                progress: progress,
                active: false,
                onAction: () => _launch(context, ref, task, fromIndex: 0),
              ),
            ),
            if (finished.isNotEmpty) ...[
              const Divider(height: 24),
              Text(
                l10n.workflowCompletedTaskLabel,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 4),
              ...finished.map(
                (task) => _TaskTile(
                  task: task,
                  progress: progress,
                  active: false,
                  finished: true,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.task,
    required this.progress,
    required this.active,
    this.finished = false,
    this.onAction,
  });

  final WorkflowTask task;
  final WorkflowProgress progress;
  final bool active;
  final bool finished;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final leading = active
        ? Icon(Icons.play_circle_outline, color: colorScheme.primary)
        : finished
        ? Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.radio_button_unchecked);

    final completedCount = task.steps
        .where((step) => progress.completedStepIds.contains(step.id))
        .length;

    final subtitle = active
        ? '${task.description}\n${l10n?.workflowStepsProgress(completedCount, task.totalSteps) ?? ''}'
        : task.description;

    final trailing = finished
        ? null
        : active
        ? FilledButton.tonal(
            onPressed: onAction,
            child: Text(l10n?.workflowResumeTask ?? 'Resume'),
          )
        : TextButton(
            onPressed: onAction,
            child: Text(l10n?.workflowStartTask ?? 'Start'),
          );

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: Text(task.title),
      subtitle: Text(
        subtitle,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
      onTap: finished ? null : onAction,
    );
  }
}
