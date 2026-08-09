import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/secure_storage.dart';
import 'domain/copilot_profile.dart';
import 'domain/copilot_profile_adaptation.dart';

const _profileKey = 'copilot_profile';

/// Encodes [profile] for storage as a JSON object.
String encodeCopilotProfile(CopilotProfile profile) => jsonEncode({
      'businessType': profile.businessType.name,
      'skillLevel': profile.skillLevel.name,
      'completedLearningSteps': profile.completedLearningSteps.toList()..sort(),
      'workflowUsageCounts': profile.workflowUsageCounts,
    });

/// Decodes a stored JSON object back into a [CopilotProfile].
///
/// Unknown or invalid values fall back to safe defaults so a corrupt store
/// never breaks the app.
CopilotProfile decodeCopilotProfile(String? raw) {
  if (raw == null || raw.isEmpty) return const CopilotProfile();
  try {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return CopilotProfile(
      businessType: BusinessType.values.firstWhere(
        (type) => type.name == map['businessType'],
        orElse: () => BusinessType.general,
      ),
      skillLevel: UserSkillLevel.values.firstWhere(
        (level) => level.name == map['skillLevel'],
        orElse: () => UserSkillLevel.beginner,
      ),
      completedLearningSteps:
          ((map['completedLearningSteps'] as List?) ?? const [])
              .whereType<String>()
              .toSet(),
      workflowUsageCounts:
          ((map['workflowUsageCounts'] as Map?) ?? const {}).map(
        (key, value) => MapEntry('$key', (value as num).toInt()),
      ),
    );
  } catch (_) {
    return const CopilotProfile();
  }
}

/// Holds and persists the personalized copilot profile.
///
/// Persisted in secure storage so personalization survives app restarts.
/// Persistence is best-effort: storage failures are ignored.
class CopilotProfileNotifier extends Notifier<CopilotProfile> {
  @override
  CopilotProfile build() {
    _load();
    return const CopilotProfile();
  }

  Future<void> _load() async {
    try {
      final raw = await SecureStorage.instance.read(_profileKey);
      final stored = decodeCopilotProfile(raw);
      if (stored.isConfigured) {
        state = stored;
      }
    } catch (_) {
      // Ignore: the profile simply starts with defaults.
    }
  }

  Future<void> _persist() async {
    try {
      await SecureStorage.instance.write(
        _profileKey,
        encodeCopilotProfile(state),
      );
    } catch (_) {
      // Persistence is best-effort; keep the in-memory state.
    }
  }

  /// Sets the user's business type.
  Future<void> setBusinessType(BusinessType type) async {
    state = state.copyWith(businessType: type);
    await _persist();
  }

  /// Sets the user's self-reported skill level.
  Future<void> setSkillLevel(UserSkillLevel level) async {
    state = state.copyWith(skillLevel: level);
    await _persist();
  }

  /// Marks [stepId] as a completed learning step.
  Future<void> completeLearningStep(String stepId) async {
    if (state.completedLearningSteps.contains(stepId)) return;
    state = state.copyWith(
      completedLearningSteps: {...state.completedLearningSteps, stepId},
    );
    await _persist();
  }

  /// Records one use of [workflowId]; after
  /// [kFrequentlyUsedWorkflowThreshold] uses it counts as frequently used.
  Future<void> recordWorkflowUse(String workflowId) async {
    final current = state.workflowUsageCounts[workflowId] ?? 0;
    state = state.copyWith(
      workflowUsageCounts: {
        ...state.workflowUsageCounts,
        workflowId: current + 1,
      },
    );
    await _persist();
  }

  /// Clears the profile back to defaults.
  Future<void> reset() async {
    state = const CopilotProfile();
    try {
      await SecureStorage.instance.delete(_profileKey);
    } catch (_) {
      // Best-effort.
    }
  }
}

/// Singleton controller for the personalized copilot profile.
final copilotProfileProvider =
    NotifierProvider<CopilotProfileNotifier, CopilotProfile>(
  CopilotProfileNotifier.new,
);

/// The guidance tone derived from the current profile.
final guidanceToneProvider = Provider<GuidanceTone>(
  (ref) => guidanceToneFor(ref.watch(copilotProfileProvider)),
);
