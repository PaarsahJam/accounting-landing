import '../../../features/guidance/domain/contextual_tip.dart';
import '../../workflows/domain/workflow_definitions.dart';
import 'copilot_profile.dart';

/// Why a workflow was recommended to the user.
///
/// Every recommendation carries an explicit reason so the adaptation is
/// auditable and testable — no opaque scoring is involved.
enum WorkflowRecommendationReason {
  /// The workflow matches the user's business type.
  businessTypeMatch,

  /// The user has used this workflow frequently.
  frequentlyUsed,

  /// The workflow matches the user's skill level.
  skillLevelMatch,

  /// Fallback: the workflow is unfinished and listed in catalog order.
  defaultOrder,
}

/// A recommended workflow and the explicit reason it was recommended.
class WorkflowRecommendation {
  const WorkflowRecommendation({
    required this.taskId,
    required this.reason,
  });

  final String taskId;
  final WorkflowRecommendationReason reason;
}

// ───────────────────────────────────────────────────────────────────────────
// Explicit adaptation tables. Each rule below is a named, documented mapping
// so the personalization logic stays transparent and unit-testable.
// ───────────────────────────────────────────────────────────────────────────

/// Business type -> workflows to prioritize, in preference order.
const Map<BusinessType, List<String>> _businessWorkflowPreferences = {
  BusinessType.general: [
    WorkflowTaskIds.createFirstInvoice,
    WorkflowTaskIds.recordCustomerPayment,
    WorkflowTaskIds.reviewWhoOwesMe,
  ],
  BusinessType.retail: [
    WorkflowTaskIds.recordCustomerPayment,
    WorkflowTaskIds.reviewWhoOwesMe,
    WorkflowTaskIds.createFirstInvoice,
  ],
  BusinessType.wholesale: [
    WorkflowTaskIds.reviewWhoOwesMe,
    WorkflowTaskIds.recordCustomerPayment,
    WorkflowTaskIds.createFirstInvoice,
  ],
  BusinessType.services: [
    WorkflowTaskIds.createFirstInvoice,
    WorkflowTaskIds.reviewWhoOwesMe,
    WorkflowTaskIds.recordCustomerPayment,
  ],
  BusinessType.manufacturing: [
    WorkflowTaskIds.createFirstInvoice,
    WorkflowTaskIds.reviewWhoOwesMe,
    WorkflowTaskIds.recordCustomerPayment,
  ],
  BusinessType.restaurant: [
    WorkflowTaskIds.recordCustomerPayment,
    WorkflowTaskIds.createFirstInvoice,
    WorkflowTaskIds.reviewWhoOwesMe,
  ],
};

/// Skill level -> workflow prioritized for that level.
const Map<UserSkillLevel, String> _skillLevelWorkflow = {
  UserSkillLevel.beginner: WorkflowTaskIds.createFirstInvoice,
  UserSkillLevel.advanced: WorkflowTaskIds.reviewWhoOwesMe,
};

/// Business type -> contextual concept tips to show first.
const Map<BusinessType, List<String>> _businessTipPreferences = {
  BusinessType.retail: [
    LearningStepIds.receivable,
    LearningStepIds.payment,
  ],
  BusinessType.wholesale: [
    LearningStepIds.receivable,
    LearningStepIds.payment,
  ],
  BusinessType.services: [
    LearningStepIds.invoice,
    LearningStepIds.receivable,
  ],
  BusinessType.manufacturing: [
    LearningStepIds.invoice,
    LearningStepIds.receivable,
  ],
  BusinessType.restaurant: [
    LearningStepIds.payment,
    LearningStepIds.receivable,
  ],
  BusinessType.general: [],
};

/// Foundational tips that experienced users are assumed to know.
const Set<String> _foundationalTips = {
  LearningStepIds.invoice,
  LearningStepIds.profit,
};

/// Guidance tone for [profile], using explicit rules:
/// - advanced    -> expert
/// - intermediate -> standard
/// - beginner    -> simple, unless the foundational learning steps (invoice,
///   receivable, profit) are complete, in which case standard.
GuidanceTone guidanceToneFor(CopilotProfile profile) {
  switch (profile.skillLevel) {
    case UserSkillLevel.advanced:
      return GuidanceTone.expert;
    case UserSkillLevel.intermediate:
      return GuidanceTone.standard;
    case UserSkillLevel.beginner:
      final foundational = {
        LearningStepIds.invoice,
        LearningStepIds.receivable,
        LearningStepIds.profit,
      };
      if (profile.completedLearningSteps.containsAll(foundational)) {
        return GuidanceTone.standard;
      }
      return GuidanceTone.simple;
  }
}

/// Recommends unfinished workflows for [profile], ordered by preference.
///
/// Rules (applied in order, each with an explicit [WorkflowRecommendationReason]):
/// 1. Drop finished workflows.
/// 2. Tag each remaining workflow with a single reason:
///    - [WorkflowRecommendationReason.frequentlyUsed] when the user has used it
///      at least [kFrequentlyUsedWorkflowThreshold] times (personal usage beats
///      the generic business-type preference).
///    - [WorkflowRecommendationReason.businessTypeMatch] when the workflow is in
///      the business-type preference list.
///    - [WorkflowRecommendationReason.skillLevelMatch] when the workflow is the
///      one prioritized for the user's skill level.
///    - [WorkflowRecommendationReason.defaultOrder] otherwise.
/// 3. Sort by reason rank (businessTypeMatch first, then frequentlyUsed, then
///    skillLevelMatch, then defaultOrder); within the same rank, keep the
///    catalog order for determinism.
List<WorkflowRecommendation> recommendWorkflows({
  required CopilotProfile profile,
  required List<String> allTaskIds,
  required Set<String> finishedTaskIds,
}) {
  final businessPrefs = _businessWorkflowPreferences[profile.businessType] ??
      _businessWorkflowPreferences[BusinessType.general]!;
  final skillLevelWorkflow = _skillLevelWorkflow[profile.skillLevel];
  final frequent = profile.frequentlyUsedWorkflows;

  WorkflowRecommendationReason reasonFor(String taskId) {
    if (frequent.contains(taskId)) {
      return WorkflowRecommendationReason.frequentlyUsed;
    }
    if (businessPrefs.contains(taskId)) {
      return WorkflowRecommendationReason.businessTypeMatch;
    }
    if (skillLevelWorkflow == taskId) {
      return WorkflowRecommendationReason.skillLevelMatch;
    }
    return WorkflowRecommendationReason.defaultOrder;
  }

  final recommendations = allTaskIds
      .where((id) => !finishedTaskIds.contains(id))
      .map((id) => WorkflowRecommendation(taskId: id, reason: reasonFor(id)))
      .toList();

  int rank(WorkflowRecommendationReason reason) => switch (reason) {
        WorkflowRecommendationReason.businessTypeMatch => 0,
        WorkflowRecommendationReason.frequentlyUsed => 1,
        WorkflowRecommendationReason.skillLevelMatch => 2,
        WorkflowRecommendationReason.defaultOrder => 3,
      };

  recommendations.sort((a, b) {
    final byRank = rank(a.reason).compareTo(rank(b.reason));
    if (byRank != 0) return byRank;
    return allTaskIds.indexOf(a.taskId).compareTo(allTaskIds.indexOf(b.taskId));
  });

  return recommendations;
}

/// Adapts the contextual [candidates] for [profile].
///
/// Rules (applied in order):
/// 1. Drop tips for concepts the user has already completed as learning steps.
/// 2. For advanced users, drop foundational tips (invoice, profit) unless the
///    business type explicitly prefers them.
/// 3. Order business-type-preferred tips first, keeping catalog order otherwise.
List<ContextualTip> adaptTipsForProfile({
  required CopilotProfile profile,
  required List<ContextualTip> candidates,
}) {
  final preferred =
      _businessTipPreferences[profile.businessType] ?? const <String>[];

  final filtered = candidates.where((tip) {
    if (profile.completedLearningSteps.contains(tip.id)) return false;
    if (profile.skillLevel == UserSkillLevel.advanced &&
        _foundationalTips.contains(tip.id) &&
        !preferred.contains(tip.id)) {
      return false;
    }
    return true;
  }).toList();

  filtered.sort((a, b) {
    final aPref = preferred.contains(a.id) ? 0 : 1;
    final bPref = preferred.contains(b.id) ? 0 : 1;
    if (aPref != bPref) return aPref.compareTo(bPref);
    return candidates.indexOf(a).compareTo(candidates.indexOf(b));
  });

  return filtered;
}
