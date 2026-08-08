import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/contextual_tip.dart';
import '../domain/contextual_tip_controller.dart';
import '../guidance_tips_provider.dart';
import 'guidance_bubble.dart';

/// Full-screen overlay for the first-time contextual tips.
///
/// Rendered above the app shell (as a Stack sibling) exactly like
/// [GuidanceTourOverlay], it dims the app, highlights the target section and
/// shows a "Got it" bubble. Dismissing a tip persists it so it never shows
/// again for the same concept.
class ContextualTipOverlay extends ConsumerStatefulWidget {
  const ContextualTipOverlay({super.key});

  @override
  ConsumerState<ContextualTipOverlay> createState() =>
      _ContextualTipOverlayState();
}

class _ContextualTipOverlayState extends ConsumerState<ContextualTipOverlay> {
  final GlobalKey _bubbleKey = GlobalKey();
  late final ContextualTipController _controller;

  ContextualTip? _lastTip;
  Rect? _highlightRect;
  Size? _bubbleSize;
  Rect? _bubbleRect;
  GuidanceArrowDirection _arrowDirection = GuidanceArrowDirection.none;
  double _arrowOffsetX = 0;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(contextualTipControllerProvider);
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
    final controller = ref.watch(contextualTipControllerProvider);
    final tip = controller.currentTip;
    if (tip == null) {
      return const SizedBox.shrink();
    }

    if (!identical(tip, _lastTip)) {
      _lastTip = tip;
      _highlightRect = null;
      _bubbleSize = null;
      _bubbleRect = null;
      _arrowDirection = GuidanceArrowDirection.none;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTarget(tip);
        _measureBubble();
      });
    }

    final l10n = AppLocalizations.of(context)!;
    final bubble = GuidanceBubble(
      key: _bubbleKey,
      title: tip.title,
      body: tip.body,
      arrowDirection: _arrowDirection,
      arrowOffsetX: _arrowOffsetX,
      footer: Row(
        children: [
          const Spacer(),
          FilledButton(
            onPressed: _dismissCurrent,
            child: Text(l10n.conceptHelpGotIt),
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

  Future<void> _measureTarget(ContextualTip tip) async {
    final ctx = tip.targetKey?.currentContext;
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
        _highlightRect = raw.intersect(Offset.zero & screen);
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

  void _dismissCurrent() {
    final tip = _controller.currentTip;
    if (tip != null) {
      ref.read(dismissedTipsProvider.notifier).dismiss(tip.id);
    }
    _controller.next();
  }
}
