import 'package:accounting_app/features/copilot_profile/domain/copilot_profile.dart';
import 'package:accounting_app/features/copilot_profile/domain/copilot_profile_adaptation.dart';
import 'package:accounting_app/features/guidance/domain/concept.dart';
import 'package:accounting_app/features/guidance/domain/contextual_tip.dart';
import 'package:accounting_app/features/workflows/domain/workflow_definitions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const allTaskIds = WorkflowTaskIds.all;

  CopilotProfile profile({
    BusinessType businessType = BusinessType.general,
    UserSkillLevel skillLevel = UserSkillLevel.beginner,
    Set<String> completedLearningSteps = const {},
    Map<String, int> workflowUsageCounts = const {},
  }) {
    return CopilotProfile(
      businessType: businessType,
      skillLevel: skillLevel,
      completedLearningSteps: completedLearningSteps,
      workflowUsageCounts: workflowUsageCounts,
    );
  }

  List<String> recommendedIds({
    required CopilotProfile p,
    Set<String> finished = const {},
  }) {
    return recommendWorkflows(
      profile: p,
      allTaskIds: allTaskIds,
      finishedTaskIds: finished,
    ).map((r) => r.taskId).toList();
  }

  group('recommendWorkflows', () {
    test('excludes finished workflows', () {
      final p = profile();
      final ids = recommendedIds(p: p, finished: {allTaskIds.first});
      expect(ids, isNot(contains(allTaskIds.first)));
    });

    test('business-type preferences are ranked first with an explicit reason',
        () {
      final p = profile(businessType: BusinessType.retail);
      final recommendations = recommendWorkflows(
        profile: p,
        allTaskIds: allTaskIds,
        finishedTaskIds: const {},
      );
      expect(recommendations.first.reason,
          WorkflowRecommendationReason.businessTypeMatch);
    });

    test('frequently used workflows get a dedicated reason', () {
      final p = profile(
        workflowUsageCounts: {
          WorkflowTaskIds.recordCustomerPayment: kFrequentlyUsedWorkflowThreshold,
        },
      );
      final recommendations = recommendWorkflows(
        profile: p,
        allTaskIds: allTaskIds,
        finishedTaskIds: const {},
      );
      expect(
        recommendations
            .firstWhere((r) => r.taskId == WorkflowTaskIds.recordCustomerPayment)
            .reason,
        WorkflowRecommendationReason.frequentlyUsed,
      );
    });

    test('personal usage ranks above the business-type match', () {
      final p = profile(
        businessType: BusinessType.retail,
        workflowUsageCounts: {
          WorkflowTaskIds.createFirstInvoice: kFrequentlyUsedWorkflowThreshold,
        },
      );
      final recommendations = recommendWorkflows(
        profile: p,
        allTaskIds: allTaskIds,
        finishedTaskIds: const {},
      );
      final byId = {for (final r in recommendations) r.taskId: r.reason};
      expect(byId[WorkflowTaskIds.createFirstInvoice],
          WorkflowRecommendationReason.frequentlyUsed);
    });
  });

  group('guidanceToneFor', () {
    test('advanced users get expert tone', () {
      expect(
        guidanceToneFor(profile(skillLevel: UserSkillLevel.advanced)),
        GuidanceTone.expert,
      );
    });

    test('intermediate users get standard tone', () {
      expect(
        guidanceToneFor(profile(skillLevel: UserSkillLevel.intermediate)),
        GuidanceTone.standard,
      );
    });

    test('beginners without foundational steps get simple tone', () {
      expect(
        guidanceToneFor(profile(skillLevel: UserSkillLevel.beginner)),
        GuidanceTone.simple,
      );
    });

    test('beginners with foundational steps complete get standard tone', () {
      final p = profile(
        skillLevel: UserSkillLevel.beginner,
        completedLearningSteps: const {
          LearningStepIds.invoice,
          LearningStepIds.receivable,
          LearningStepIds.profit,
        },
      );
      expect(guidanceToneFor(p), GuidanceTone.standard);
    });
  });

  group('adaptTipsForProfile', () {
    ContextualTip tip(String id) => ContextualTip(
          id: id,
          title: id,
          body: id,
        );

    test('drops tips for completed learning steps', () {
      final p = profile(completedLearningSteps: {ConceptIds.invoice});
      final adapted = adaptTipsForProfile(
        profile: p,
        candidates: [tip(ConceptIds.invoice), tip(ConceptIds.payment)],
      );
      expect(adapted.map((t) => t.id), ['payment']);
    });

    test('advanced users lose foundational tips unless preferred', () {
      final p = profile(skillLevel: UserSkillLevel.advanced);
      final adapted = adaptTipsForProfile(
        profile: p,
        candidates: [
          tip(ConceptIds.invoice),
          tip(ConceptIds.bankReconciliation),
        ],
      );
      expect(adapted.map((t) => t.id), [ConceptIds.bankReconciliation]);
    });

    test('business-preferred tips are ordered first', () {
      final p = profile(businessType: BusinessType.retail);
      final adapted = adaptTipsForProfile(
        profile: p,
        candidates: [
          tip(ConceptIds.profit),
          tip(ConceptIds.receivable),
          tip(ConceptIds.payment),
        ],
      );
      expect(
        adapted.map((t) => t.id),
        [ConceptIds.receivable, ConceptIds.payment, ConceptIds.profit],
      );
    });
  });
}
