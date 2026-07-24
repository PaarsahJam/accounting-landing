import 'package:freezed_annotation/freezed_annotation.dart';

import 'roadmap_action.dart';
import 'financial_impact.dart';

part 'roadmap_mutation.freezed.dart';

@freezed
abstract class RoadmapMutation with _$RoadmapMutation {
  const factory RoadmapMutation({
    required String id,
    required String roadmapItemId,
    required String roadmapItemTitle,
    required List<FinancialImpact> impacts,
    required List<RoadmapAction> actions,
    required MutationKind kind,
    required DateTime plannedDate,
    required String performedBy,
  }) = _RoadmapMutation;

  const RoadmapMutation._();

  double get totalDebit => impacts.fold<double>(0, (sum, i) => sum + i.debitAmount);

  double get totalCredit => impacts.fold<double>(0, (sum, i) => sum + i.creditAmount);

  bool get isBalanced => (totalDebit - totalCredit).abs() < 0.005;
}

enum MutationKind {
  adjustment,
  correction,
  posting,
  reversal,
}