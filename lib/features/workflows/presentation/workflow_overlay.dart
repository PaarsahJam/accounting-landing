import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../guidance/presentation/guidance_bubble.dart';
import '../domain/workflow_controller.dart';
import '../domain/workflow_task.dart';
import '../workflow_provider.dart';

/// Full-screen overlay that dims the app, highlights the current workflow step
/// target and shows a tooltip bubble with Next / Resume later / Cancel.
///
/// It is rendered above the app shell (as a Stack sibling) so it can point at
/// the app bar and page content at the same time. When the user navigates away
/// from the step's module the overlay quietly pauses, keeping its progress.
class WorkflowOverlay extends ConsumerStatefulWidget {
  const WorkflowOverlay({super.key});

  @override
  ConsumerState<WorkflowOverlay> createState() => _WorkflowOverlayState();
}

class _WorkflowOverlayState extends ConsumerState<WorkflowOverlay> {
  final GlobalKey _bubbleKey = GlobalKey();
  late final WorkflowController _controller;

  WorkflowStep? _lastStep;
  Rect? _highlightRect;
  Size? _bubbleSize;
  Rect? _bubbleRect;
  GuidanceArrowDirection _arrowDirection = GuidanceArrowDirection.none;
  double _arrowOffsetX = 0;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(workflowControllerProvider);
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(workflowControllerProvider);
    final step = controller.currentStep;
    if (step == null) {
      return const SizedBox.shrink();
    }

    if (!identical(step, _lastStep)) {
      _lastStep = step;
      _highlightRect = null;
      _bubbleSize = null;
      _bubbleRect = null;
      _arrowDirection = GuidanceArrowDirection.none;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTarget(step);
        _measureBubble();
      });
    }

    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bubble = GuidanceBubble(
      key: _bubbleKey,
      title: step.title,
      body: step.body,
      bodyLabel: l10n.workflowWhyThisMatters,
      stepCountLabel: l10n.workflowStepCount(
        controller.stepNumber,
        controller.totalSteps,
      ),
      arrowDirection: _arrowDirection,
      arrowOffsetX: _arrowOffsetX,
      footer: Wrap(
        spacing: 8,
        runSpacing: 4,
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextButton(
            onPressed: _cancel,
            child: Text(
              l10n.workflowCancel,
              style: TextStyle(color: scheme.onInverseSurface),
            ),
          ),
          TextButton(
            onPressed: _pause,
            child: Text(
              l10n.workflowResumeLater,
              style: TextStyle(color: scheme.onInverseSurface),
            ),
          ),
          FilledButton(
            onPressed: _next,
            child: Text(
              controller.isLast ? l10n.workflowFinish : l10n.workflowNext,
            ),
          ),
        ],
      ),
    );

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GuidanceScrimPainter(highlightRect: _highlightRect),
            ),
          ),
          if (_bubbleSize == null || _bubbleRect == null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: bubble,
              ),
            )
          else
            Positioned.fromRect(rect: _bubbleRect!, child: bubble),
        ],
      ),
    );
  }

  void _next() {
    final step = _controller.currentStep;
    if (step == null) return;

    final progress = ref.read(workflowProgressProvider.notifier);
    if (_controller.isLast) {
      progress.markStepComplete(step.id);
      progress.finishTask();
      _controller.stop();
      return;
    }

    progress.markStepComplete(step.id);
    final nextStep = _controller.nextStep;
    if (nextStep == null) {
      _controller.next();
      return;
    }
    if (nextStep.route != GoRouterState.of(context).matchedLocation) {
      // Deep-link to the next module; the trigger re-opens the overlay there.
      _controller.stop();
      context.go(nextStep.route);
    } else {
      _controller.next();
    }
  }

  /// Closes the overlay without losing progress; the task can be resumed.
  void _pause() {
    _controller.stop();
  }

  /// Abandons the task entirely, discarding its step progress.
  void _cancel() {
    ref.read(workflowProgressProvider.notifier).cancel();
    _controller.stop();
  }

  Future<void> _measureTarget(WorkflowStep step) async {
    final ctx = step.targetKey?.currentContext;
    if (ctx == null || !mounted) {
      _highlightRect = null;
      _computeLayout();
      return;
    }
    try {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 250),
        alignment: 0.5,
      );
    } catch (_) {
      // Ignore: the target may live in a non-scrollable area.
    }
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final render = ctx.findRenderObject();
      if (render is RenderBox && render.attached) {
        final screen = MediaQuery.sizeOf(context);
        final topLeft = render.localToGlobal(Offset.zero);
        final raw = Rect.fromLTWH(
          topLeft.dx,
          topLeft.dy,
          render.size.width,
          render.size.height,
        );
        final pad = const EdgeInsets.all(4);
        final inflated = Rect.fromLTRB(
          raw.left - pad.left,
          raw.top - pad.top,
          raw.right + pad.right,
          raw.bottom + pad.bottom,
        ).intersect(Offset.zero & screen);
        if (inflated.width <= 0 || inflated.height <= 0) {
          _highlightRect = null;
        } else {
          _highlightRect = inflated;
        }
      } else {
        _highlightRect = null;
      }
      _computeLayout();
    });
  }

  void _measureBubble() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final render = _bubbleKey.currentContext?.findRenderObject();
      if (render is RenderBox && render.attached) {
        _bubbleSize = render.size;
        _computeLayout();
      }
    });
  }

  void _computeLayout() {
    if (!mounted) return;
    final bubbleSize = _bubbleSize;
    if (bubbleSize == null) return;

    final screen = MediaQuery.sizeOf(context);
    final rect = _computeBubbleRect(screen, bubbleSize);
    _bubbleRect = rect;

    if (_highlightRect != null) {
      if (rect.bottom <= _highlightRect!.top) {
        _arrowDirection = GuidanceArrowDirection.down;
      } else if (rect.top >= _highlightRect!.bottom) {
        _arrowDirection = GuidanceArrowDirection.up;
      } else {
        _arrowDirection = GuidanceArrowDirection.none;
      }
      _arrowOffsetX = (_highlightRect!.center.dx - rect.left)
          .clamp(16.0, rect.width - 16.0)
          .toDouble();
    } else {
      _arrowDirection = GuidanceArrowDirection.none;
      _arrowOffsetX = rect.width / 2;
    }
    setState(() {});
  }

  Rect _computeBubbleRect(Size screen, Size bubbleSize) {
    const margin = 16.0;
    const gap = 12.0;
    final w = bubbleSize.width;
    final h = bubbleSize.height;

    double left;
    double top;
    final highlight = _highlightRect;
    if (highlight != null) {
      left = (highlight.center.dx - w / 2).clamp(margin, screen.width - w - margin);
      final above = highlight.top - h - gap;
      final below = highlight.bottom + gap;
      if (above >= margin) {
        top = above;
      } else if (below + h <= screen.height - margin) {
        top = below;
      } else {
        top = (screen.height - h) / 2;
      }
    } else {
      left = (screen.width - w) / 2;
      top = (screen.height - h) / 2;
    }
    return Rect.fromLTWH(left, top, w, h);
  }
}
