import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../copilot_profile/copilot_profile_provider.dart';
import '../../copilot_profile/domain/copilot_profile.dart';
import '../../copilot_profile/domain/copilot_profile_adaptation.dart';
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
    ref.read(copilotProfileProvider.notifier).recordWorkflowUse(task.id);
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
    final profile = ref.watch(copilotProfileProvider);

    final recommendations = recommendWorkflows(
      profile: profile,
      allTaskIds: WorkflowTaskIds.all,
      finishedTaskIds: progress.finishedTaskIds,
    );

    final suggested = recommendations
        .where(
          (recommendation) =>
              recommendation.taskId != progress.activeTaskId,
        )
        .map(
          (recommendation) => (
            task: tasks.firstWhere(
              (task) => task.id == recommendation.taskId,
            ),
            reason: recommendation.reason,
          ),
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
                        _subtitleFor(profile.skillLevel, l10n),
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
              (entry) => _TaskTile(
                task: entry.task,
                progress: progress,
                active: false,
                reason: entry.reason,
                onAction: () => _launch(context, ref, entry.task, fromIndex: 0),
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

  String _subtitleFor(UserSkillLevel skillLevel, AppLocalizations l10n) =>
      switch (skillLevel) {
        UserSkillLevel.beginner => l10n.workflowCopilotSubtitleSimple,
        UserSkillLevel.intermediate => l10n.workflowCopilotSubtitleStandard,
        UserSkillLevel.advanced => l10n.workflowCopilotSubtitleExpert,
      };
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.task,
    required this.progress,
    required this.active,
    this.finished = false,
    this.reason,
    this.onAction,
  });

  final WorkflowTask task;
  final WorkflowProgress progress;
  final bool active;
  final bool finished;
  final WorkflowRecommendationReason? reason;
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

    final reasonLabel = _reasonLabel(l10n);

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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (reasonLabel != null) ...[
            const SizedBox(height: 2),
            Text(
              reasonLabel,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: colorScheme.primary),
            ),
          ],
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: trailing,
      onTap: finished ? null : onAction,
    );
  }

  String? _reasonLabel(AppLocalizations? l10n) {
    if (reason == null) return null;
    return switch (reason!) {
      WorkflowRecommendationReason.businessTypeMatch =>
        l10n?.workflowRecommendationReasonBusinessType,
      WorkflowRecommendationReason.frequentlyUsed =>
        l10n?.workflowRecommendationReasonFrequentlyUsed,
      WorkflowRecommendationReason.skillLevelMatch =>
        l10n?.workflowRecommendationReasonSkillLevel,
      WorkflowRecommendationReason.defaultOrder =>
        l10n?.workflowRecommendationReasonDefault,
    };
  }
}
