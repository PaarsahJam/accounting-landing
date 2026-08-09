import '../../../features/guidance/domain/concept.dart';

/// The industry the business operates in. Used by explicit, testable
/// personalization rules to pick recommended workflows and tips.
enum BusinessType {
  general,
  retail,
  wholesale,
  services,
  manufacturing,
  restaurant,
}

/// The user's self-reported accounting skill level.
enum UserSkillLevel {
  beginner,
  intermediate,
  advanced,
}

/// The guidance tone derived from the user's profile. Not stored directly;
/// computed by explicit rules in `guidanceToneFor`.
enum GuidanceTone {
  /// Plain-language guidance for users new to accounting.
  simple,

  /// Balanced guidance for users who know the basics.
  standard,

  /// Concise, no hand-holding guidance for experienced users.
  expert,
}

/// Stable ids for the learnable concepts. Reuses the concept library ids so
/// learning steps and contextual tips stay aligned.
abstract final class LearningStepIds {
  LearningStepIds._();

  static const invoice = ConceptIds.invoice;
  static const receivable = ConceptIds.receivable;
  static const profit = ConceptIds.profit;
  static const payment = ConceptIds.payment;
  static const bankReconciliation = ConceptIds.bankReconciliation;
}

/// A workflow counts as "frequently used" once its usage count reaches this
/// threshold. Kept explicit so the adaptation rule is auditable.
const int kFrequentlyUsedWorkflowThreshold = 2;

/// The personalized copilot profile.
///
/// Stores business type, skill level, completed learning steps and workflow
/// usage. Adaptation is applied through pure, explicit rule functions in
/// `copilot_profile_adaptation.dart` — never through opaque scoring.
class CopilotProfile {
  const CopilotProfile({
    this.businessType = BusinessType.general,
    this.skillLevel = UserSkillLevel.beginner,
    this.completedLearningSteps = const {},
    this.workflowUsageCounts = const {},
  });

  /// The user's industry (defaults to [BusinessType.general]).
  final BusinessType businessType;

  /// The user's self-reported skill level (defaults to beginner).
  final UserSkillLevel skillLevel;

  /// Learning step ids the user has completed (see [LearningStepIds]).
  final Set<String> completedLearningSteps;

  /// Workflow id -> usage count, used to derive [frequentlyUsedWorkflows].
  final Map<String, int> workflowUsageCounts;

  /// Whether the user has actively personalized their profile.
  bool get isConfigured =>
      businessType != BusinessType.general ||
      skillLevel != UserSkillLevel.beginner ||
      completedLearningSteps.isNotEmpty ||
      workflowUsageCounts.isNotEmpty;

  /// Workflow ids used at least [kFrequentlyUsedWorkflowThreshold] times.
  Set<String> get frequentlyUsedWorkflows => workflowUsageCounts.entries
      .where((entry) => entry.value >= kFrequentlyUsedWorkflowThreshold)
      .map((entry) => entry.key)
      .toSet();

  CopilotProfile copyWith({
    BusinessType? businessType,
    UserSkillLevel? skillLevel,
    Set<String>? completedLearningSteps,
    Map<String, int>? workflowUsageCounts,
  }) {
    return CopilotProfile(
      businessType: businessType ?? this.businessType,
      skillLevel: skillLevel ?? this.skillLevel,
      completedLearningSteps:
          completedLearningSteps ?? this.completedLearningSteps,
      workflowUsageCounts: workflowUsageCounts ?? this.workflowUsageCounts,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CopilotProfile &&
        other.businessType == businessType &&
        other.skillLevel == skillLevel &&
        other.completedLearningSteps.length ==
            completedLearningSteps.length &&
        completedLearningSteps.containsAll(other.completedLearningSteps) &&
        other.workflowUsageCounts.length == workflowUsageCounts.length &&
        workflowUsageCounts.entries.every(
          (e) => other.workflowUsageCounts[e.key] == e.value,
        );
  }

  @override
  int get hashCode => Object.hash(
        businessType,
        skillLevel,
        Object.hashAll(completedLearningSteps.toList()..sort()),
        Object.hashAll(
          (workflowUsageCounts.entries.toList()
                ..sort((a, b) => a.key.compareTo(b.key)))
              .map((e) => '${e.key}:${e.value}'),
        ),
      );
}
