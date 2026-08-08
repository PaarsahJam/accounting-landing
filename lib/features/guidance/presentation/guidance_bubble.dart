import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Direction the bubble arrow points, relative to the bubble.
enum GuidanceArrowDirection { up, down, none }

/// Shared tooltip-style bubble used by the guidance tour and contextual tips.
///
/// Painted on the inverse surface with a rounded card and an optional arrow
/// that points at the highlighted target on screen.
class GuidanceBubble extends StatelessWidget {
  const GuidanceBubble({
    super.key,
    required this.title,
    required this.body,
    required this.footer,
    this.stepCountLabel,
    this.arrowDirection = GuidanceArrowDirection.none,
    this.arrowOffsetX = 0,
    this.maxWidth = 380,
  });

  final String title;
  final String body;

  /// Bottom row of actions (e.g. Next/Skip or Got it).
  final Widget footer;

  /// Optional "Step X of Y" label shown above the title.
  final String? stepCountLabel;

  final GuidanceArrowDirection arrowDirection;
  final double arrowOffsetX;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = math.min(MediaQuery.sizeOf(context).width - 32, maxWidth);

    return SizedBox(
      width: width,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: scheme.inverseSurface,
        child: CustomPaint(
          painter: GuidanceArrowPainter(
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
                if (stepCountLabel != null) ...[
                  Text(
                    stepCountLabel!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.onInverseSurface.withValues(alpha: 0.7),
                        ),
                  ),
                  const SizedBox(height: 6),
                ],
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onInverseSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onInverseSurface,
                      ),
                ),
                const SizedBox(height: 16),
                footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-screen dimming scrim with a highlighted (cut-out) target rect.
class GuidanceScrimPainter extends CustomPainter {
  GuidanceScrimPainter({this.highlightRect});

  final Rect? highlightRect;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final fill = Paint()..color = Colors.black.withValues(alpha: 0.55);

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
  bool shouldRepaint(covariant GuidanceScrimPainter old) =>
      old.highlightRect != highlightRect;
}

/// Paints the small triangle arrow on the bubble edge.
class GuidanceArrowPainter extends CustomPainter {
  GuidanceArrowPainter({
    required this.color,
    required this.direction,
    required this.offsetX,
  });

  final Color color;
  final GuidanceArrowDirection direction;
  final double offsetX;

  @override
  void paint(Canvas canvas, Size size) {
    if (direction == GuidanceArrowDirection.none) return;
    const w = 16.0;
    const h = 9.0;
    final x = offsetX.clamp(w / 2 + 2, size.width - w / 2 - 2);
    final path = Path();
    if (direction == GuidanceArrowDirection.down) {
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
  bool shouldRepaint(covariant GuidanceArrowPainter old) =>
      old.color != color ||
      old.direction != direction ||
      old.offsetX != offsetX;
}
