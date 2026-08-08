import 'package:flutter/widgets.dart';

/// A single step in the first-run guidance tour.
class GuidanceTourStep {
  const GuidanceTourStep({
    required this.title,
    required this.body,
    this.targetKey,
    this.highlightPadding = const EdgeInsets.all(4),
  });

  /// Localized heading shown in the tooltip.
  final String title;

  /// Localized body text shown in the tooltip.
  final String body;

  /// The widget to point at. When null the step is a full-screen summary
  /// (e.g. the final "you're all set" step).
  final GlobalKey? targetKey;

  /// Extra space added around the highlighted area, so the hole can
  /// visually enclose icon + label even for small targets.
  final EdgeInsets highlightPadding;
}

/// Drives the guidance tour: holds the ordered steps and the current index.
class GuidanceTourController extends ChangeNotifier {
  List<GuidanceTourStep> _steps = const [];
  int _currentIndex = 0;
  bool _isVisible = false;

  List<GuidanceTourStep> get steps => _steps;
  int get currentIndex => _currentIndex;
  bool get isVisible => _isVisible;

  GuidanceTourStep? get currentStep =>
      _isVisible && _steps.isNotEmpty ? _steps[_currentIndex] : null;

  bool get isLast => _currentIndex == _steps.length - 1;

  void start(List<GuidanceTourStep> steps) {
    _steps = List.of(steps);
    _currentIndex = 0;
    _isVisible = true;
    notifyListeners();
  }

  void next() {
    if (_currentIndex < _steps.length - 1) {
      _currentIndex += 1;
      notifyListeners();
    }
  }

  void stop() {
    _isVisible = false;
    _steps = const [];
    _currentIndex = 0;
    notifyListeners();
  }
}
