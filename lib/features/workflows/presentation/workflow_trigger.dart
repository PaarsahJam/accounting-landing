import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../guidance/guidance_tips_provider.dart';
import '../../guidance/guidance_tour_provider.dart';
import '../domain/workflow_definitions.dart';
import '../workflow_provider.dart';

/// Resumes the active workflow task when the user lands on the route of its
/// next step (after a deep-link, a resume, or an app restart).
///
/// The overlay itself is rendered by the app shell; this widget only decides
/// when to (re)open it. A step is only presented once per route, so "Resume
/// later" stays dismissed until the user navigates again.
class WorkflowTrigger extends ConsumerStatefulWidget {
  const WorkflowTrigger({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<WorkflowTrigger> createState() => _WorkflowTriggerState();
}

class _WorkflowTriggerState extends ConsumerState<WorkflowTrigger> {
  String? _lastRoute;
  bool _pauseScheduled = false;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(workflowProgressProvider);
    final controller = ref.watch(workflowControllerProvider);
    final tourVisible = ref.watch(guidanceTourControllerProvider).isVisible;
    final tipsVisible = ref.watch(contextualTipControllerProvider).isVisible;
    final tourSeen = ref.watch(guidanceTourSeenProvider).value ?? true;
    final location = GoRouterState.of(context).matchedLocation;
    final routeChanged = _lastRoute != location;
    _lastRoute = location;

    // If the overlay is showing a step that lives on another module, pause
    // quietly so it does not float over unrelated pages. Progress is kept.
    if (routeChanged && controller.isVisible) {
      final step = controller.currentStep;
      if (step != null && step.route != location && !_pauseScheduled) {
        _pauseScheduled = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pauseScheduled = false;
          if (!mounted) return;
          final current = ref.read(workflowControllerProvider);
          final currentStep = current.currentStep;
          if (currentStep != null &&
              currentStep.route != GoRouterState.of(context).matchedLocation) {
            current.stop();
          }
        });
      }
    } else if (routeChanged &&
        !controller.isVisible &&
        !tourVisible &&
        !tipsVisible &&
        tourSeen &&
        progress.isActive) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) {
        final step = workflowStepToPresent(
          workflowTaskById(l10n, progress.activeTaskId!),
          progress.completedStepIds,
          location,
        );
        if (step != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            if (ref.read(workflowControllerProvider).isVisible) return;
            if (ref.read(guidanceTourControllerProvider).isVisible) return;
            if (ref.read(contextualTipControllerProvider).isVisible) return;
            final l10nNow = AppLocalizations.of(context);
            if (l10nNow == null) return;
            final progressNow = ref.read(workflowProgressProvider);
            if (!progressNow.isActive) return;
            final taskNow = workflowTaskById(
              l10nNow,
              progressNow.activeTaskId!,
            );
            if (taskNow == null) return;
            final index = firstIncompleteIndex(
              taskNow,
              progressNow.completedStepIds,
            );
            final stepNow = taskNow.stepAt(index);
            if (stepNow == null ||
                stepNow.route != GoRouterState.of(context).matchedLocation) {
              return;
            }
            ref.read(workflowControllerProvider).start(
                  taskNow,
                  fromIndex: index,
                );
          });
        }
      }
    }

    return widget.child;
  }
}
