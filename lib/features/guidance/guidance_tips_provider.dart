import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/secure_storage.dart';
import 'domain/contextual_tip_controller.dart';

part 'guidance_tips_provider.g.dart';

const _dismissedTipsKey = 'guidance_tips_dismissed';

const _delimiter = ',';

/// Encodes the dismissed tip ids for storage as a comma-separated string.
String encodeDismissedTips(Set<String> ids) {
  final sorted = ids.toList()..sort();
  return sorted.join(_delimiter);
}

/// Decodes a stored comma-separated string into a set of tip ids.
Set<String> decodeDismissedTips(String? raw) {
  if (raw == null || raw.isEmpty) return const {};
  return raw
      .split(_delimiter)
      .map((id) => id.trim())
      .where((id) => id.isNotEmpty)
      .toSet();
}

/// Singleton controller shared by the tip trigger and the tip overlay.
@Riverpod(keepAlive: true)
ContextualTipController contextualTipController(Ref ref) =>
    ContextualTipController();

/// Tracks which contextual tips the user has dismissed.
///
/// Persisted in secure storage so a dismissed tip stays hidden across app
/// launches. Persistence is best-effort: storage failures are ignored.
@Riverpod(keepAlive: true)
class DismissedTips extends _$DismissedTips {
  @override
  Set<String> build() {
    _load();
    return const {};
  }

  Future<void> _load() async {
    try {
      final raw = await SecureStorage.instance.read(_dismissedTipsKey);
      final stored = decodeDismissedTips(raw);
      if (stored.isNotEmpty) {
        state = {...state, ...stored};
      }
    } catch (_) {
      // Ignore: the tip simply shows again next time.
    }
  }

  bool isDismissed(String id) => state.contains(id);

  /// Persists that [id] was dismissed and updates the in-memory state.
  Future<void> dismiss(String id) async {
    if (state.contains(id)) return;
    state = {...state, id};
    try {
      await SecureStorage.instance.write(_dismissedTipsKey, encodeDismissedTips(state));
    } catch (_) {
      // Persistence is best-effort; keep the in-memory dismissal.
    }
  }

  /// Clears all dismissals (used for testing and re-enabling tips).
  Future<void> reset() async {
    state = const {};
    try {
      await SecureStorage.instance.delete(_dismissedTipsKey);
    } catch (_) {
      // Best-effort.
    }
  }
}
