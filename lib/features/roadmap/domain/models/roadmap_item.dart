import 'package:freezed_annotation/freezed_annotation.dart';

import 'roadmap_action.dart';
import 'financial_impact.dart';

part 'roadmap_item.freezed.dart';

@freezed
abstract class RoadmapItem with _$RoadmapItem {
  const factory RoadmapItem({
    required String id,
    required String title,
    required String description,
    required RoadmapStatus status,
    required List<RoadmapAction> actions,
    required List<FinancialImpact> financialImpacts,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? proposedBy,
    required bool requiresConfirmation,
  }) = _RoadmapItem;

  const RoadmapItem._();

  bool get hasFinancialImpact => financialImpacts.isNotEmpty;

  bool get isDestructive => actions.any((a) => a.isDestructive);

  bool get isPendingReview => status == RoadmapStatus.pendingReview;
}

enum RoadmapStatus {
  draft,
  pendingReview,
  approved,
  rejected,
  archived,
}