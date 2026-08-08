import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/secure_storage.dart';
import 'domain/guidance_tour.dart';

part 'guidance_tour_provider.g.dart';

const _seenKey = 'guidance_tour_seen';

/// Singleton tour controller shared by the trigger and the overlay.
@Riverpod(keepAlive: true)
GuidanceTourController guidanceTourController(Ref ref) =>
    GuidanceTourController();

/// Whether the user has already completed or skipped the guidance tour.
///
/// Stored in secure storage so it only shows once per device.
@Riverpod(keepAlive: true)
Future<bool> guidanceTourSeen(Ref ref) async {
  try {
    final value = await SecureStorage.instance.read(_seenKey);
    return value == 'true';
  } catch (_) {
    return false;
  }
}

/// Persists that the tour was completed and refreshes [guidanceTourSeenProvider].
Future<void> markGuidanceTourSeen(WidgetRef ref) async {
  try {
    await SecureStorage.instance.write(_seenKey, 'true');
  } catch (_) {
    // Persistence is best-effort; ignore storage failures.
  }
  ref.invalidate(guidanceTourSeenProvider);
}
