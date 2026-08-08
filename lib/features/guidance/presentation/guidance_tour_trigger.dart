import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/extensions/responsive_breakpoint.dart';
import '../../workflows/workflow_provider.dart';
import '../guidance_tour_provider.dart';
import 'guidance_tour_builder.dart';

/// Starts the first-run guidance tour once the user reaches the dashboard,
/// unless it has already been completed on this device.
///
/// The overlay itself is rendered by the app shell; this widget only decides
/// when to begin the tour.
class GuidanceTourTrigger extends ConsumerWidget {
  const GuidanceTourTrigger({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seenAsync = ref.watch(guidanceTourSeenProvider);
    final controller = ref.watch(guidanceTourControllerProvider);
    final copilotVisible = ref.watch(workflowControllerProvider).isVisible;
    final location = GoRouterState.of(context).matchedLocation;

    if (!controller.isVisible &&
        !copilotVisible &&
        location == '/dashboard' &&
        seenAsync.hasValue &&
        seenAsync.value == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        final current = ref.read(guidanceTourControllerProvider);
        if (current.isVisible) return;
        if (ref.read(workflowControllerProvider).isVisible) return;
        final seen = ref.read(guidanceTourSeenProvider);
        if (!(seen.hasValue && seen.value == false)) return;
        if (GoRouterState.of(context).matchedLocation != '/dashboard') return;
        final l10n = AppLocalizations.of(context)!;
        final useRail = ResponsiveBreakpoint(context).useNavigationRail;
        current.start(buildGuidanceTourSteps(l10n: l10n, useRail: useRail));
      });
    }

    return child;
  }
}
