import 'package:flutter/widgets.dart';

import 'contextual_tip.dart';

/// Drives the contextual tip overlay: holds the queued tips for the current
/// route and the active tip index. Advancing past the last tip hides it.
class ContextualTipController extends ChangeNotifier {
  List<ContextualTip> _queue = const [];
  int _index = 0;
  bool _isVisible = false;

  List<ContextualTip> get queue => _queue;
  int get currentIndex => _index;
  bool get isVisible => _isVisible;

  ContextualTip? get currentTip =>
      _isVisible && _queue.isNotEmpty ? _queue[_index] : null;

  bool get isLast => _index == _queue.length - 1;

  /// Starts showing [tips]. Only the tips that have not been dismissed are
  /// expected to be passed in.
  void start(List<ContextualTip> tips) {
    _queue = List.of(tips);
    _index = 0;
    _isVisible = _queue.isNotEmpty;
    notifyListeners();
  }

  /// Dismisses the current tip and advances to the next one (or hides).
  void next() {
    if (_index < _queue.length - 1) {
      _index += 1;
      notifyListeners();
    } else {
      stop();
    }
  }

  void stop() {
    _isVisible = false;
    _queue = const [];
    _index = 0;
    notifyListeners();
  }
}
