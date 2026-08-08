import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/guidance_tour.dart';
import '../guidance_tour_provider.dart';

enum _ArrowDirection { up, down, none }

/// Full-screen overlay that dims the app, highlights the current tour target
/// and shows a tooltip bubble with Next / Done / Skip controls.
///
/// It is rendered above the app shell (as a Stack sibling) so it can point at
/// the navigation rail, the app bar and the page content at the same time.
class GuidanceTourOverlay extends ConsumerStatefulWidget {
  const GuidanceTourOverlay({super.key});

  @override
  ConsumerState<GuidanceTourOverlay> createState() =>
      _GuidanceTourOverlayState();
}

class _GuidanceTourOverlayState extends ConsumerState<GuidanceTourOverlay> {
  final GlobalKey _bubbleKey = GlobalKey();
  late final GuidanceTourController _controller;

  GuidanceTourStep? _lastStep;
  Rect? _highlightRect;
  Size? _bubbleSize;
  Rect? _bubbleRect;
  _ArrowDirection _arrowDirection = _ArrowDirection.none;
  double _arrowOffsetX = 0;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(guidanceTourControllerProvider);
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
    final controller = ref.watch(guidanceTourControllerProvider);
    final step = controller.currentStep;
    if (step == null) {
      return const SizedBox.shrink();
    }

    if (!identical(step, _lastStep)) {
      _lastStep = step;
      _highlightRect = null;
      _bubbleSize = null;
      _bubbleRect = null;
      _arrowDirection = _ArrowDirection.none;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTarget(step);
        _measureBubble();
      });
    }

    final bubble = _TourBubble(
      key: _bubbleKey,
      step: step,
      stepIndex: controller.currentIndex,
      stepCount: controller.steps.length,
      arrowDirection: _arrowDirection,
      arrowOffsetX: _arrowOffsetX,
      onNext: controller.isLast ? null : controller.next,
      onDone: _finish,
      onSkip: _finish,
    );

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _TourScrimPainter(highlightRect: _highlightRect),
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

  Future<void> _measureTarget(GuidanceTourStep step) async {
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
      // Ignore: the target may live in a non-scrollable area (e.g. nav rail).
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
        final pad = step.highlightPadding;
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
        _arrowDirection = _ArrowDirection.down;
      } else if (rect.top >= _highlightRect!.bottom) {
        _arrowDirection = _ArrowDirection.up;
      } else {
        _arrowDirection = _ArrowDirection.none;
      }
      _arrowOffsetX = (_highlightRect!.center.dx - rect.left)
          .clamp(16.0, rect.width - 16.0)
          .toDouble();
    } else {
      _arrowDirection = _ArrowDirection.none;
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
      left = (highlight.center.dx - w / 2)
          .clamp(margin, screen.width - w - margin);
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

  void _finish() {
    ref.read(guidanceTourControllerProvider).stop();
    markGuidanceTourSeen(ref);
  }
}

class _TourBubble extends StatelessWidget {
  const _TourBubble({
    super.key,
    required this.step,
    required this.stepIndex,
    required this.stepCount,
    required this.arrowDirection,
    required this.arrowOffsetX,
    required this.onNext,
    required this.onDone,
    required this.onSkip,
  });

  final GuidanceTourStep step;
  final int stepIndex;
  final int stepCount;
  final _ArrowDirection arrowDirection;
  final double arrowOffsetX;
  final VoidCallback? onNext;
  final VoidCallback onDone;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final width = math.min(MediaQuery.sizeOf(context).width - 32, 380.0);

    return SizedBox(
      width: width,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: scheme.inverseSurface,
        child: CustomPaint(
          painter: _ArrowPainter(
            color: scheme.inverseSurface,
            direction: arrowDirection,
            offsetX: arrowOffsetX,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.guidanceTourStepCount(stepIndex + 1, stepCount),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onInverseSurface.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onInverseSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  step.body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onInverseSurface,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: onSkip,
                      child: Text(
                        l10n.guidanceTourSkip,
                        style: TextStyle(color: scheme.onInverseSurface),
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: onNext ?? onDone,
                      child: Text(
                        onNext == null
                            ? l10n.guidanceTourDone
                            : l10n.guidanceTourNext,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TourScrimPainter extends CustomPainter {
  _TourScrimPainter({this.highlightRect});

  final Rect? highlightRect;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final fill = Paint()
      ..color = Colors.black.withValues(alpha: 0.55);

    final highlight = highlightRect;
    if (highlight == null) {
      canvas.drawRect(bounds, fill);
      return;
    }

    final path = Path()
      ..addRect(bounds)
      ..addRRect(RRect.fromRectAndRadius(highlight, const Radius.circular(14)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, fill);
    canvas.drawRRect(
      RRect.fromRectAndRadius(highlight, const Radius.circular(14)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white.withValues(alpha: 0.9),
    );
  }

  @override
  bool shouldRepaint(covariant _TourScrimPainter old) =>
      old.highlightRect != highlightRect;
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.color,
    required this.direction,
    required this.offsetX,
  });

  final Color color;
  final _ArrowDirection direction;
  final double offsetX;

  @override
  void paint(Canvas canvas, Size size) {
    if (direction == _ArrowDirection.none) return;
    const w = 16.0;
    const h = 9.0;
    final x = offsetX.clamp(w / 2 + 2, size.width - w / 2 - 2);
    final path = Path();
    if (direction == _ArrowDirection.down) {
      path.moveTo(x - w / 2, 0);
      path.lineTo(x + w / 2, 0);
      path.lineTo(x, h);
    } else {
      path.moveTo(x - w / 2, size.height);
      path.lineTo(x + w / 2, size.height);
      path.lineTo(x, size.height - h);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter old) =>
      old.color != color ||
      old.direction != direction ||
      old.offsetX != offsetX;
}
