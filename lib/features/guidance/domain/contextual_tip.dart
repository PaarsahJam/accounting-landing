import 'package:flutter/widgets.dart';

/// A single first-time contextual tip shown once per device.
///
/// [id] is the concept (or tip) identifier used for dismissal persistence, so
/// a tip never reappears once the user has dismissed it.
class ContextualTip {
  const ContextualTip({
    required this.id,
    required this.title,
    required this.body,
    this.targetKey,
  });

  final String id;
  final String title;
  final String body;

  /// The widget to point at. When null the tip is shown centered.
  final GlobalKey? targetKey;
}
