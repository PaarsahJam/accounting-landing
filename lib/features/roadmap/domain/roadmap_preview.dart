import 'package:freezed_annotation/freezed_annotation.dart';

import 'models/roadmap_item.dart';
import 'models/financial_impact.dart';

part 'roadmap_preview.freezed.dart';

@freezed
abstract class RoadmapPreview with _$RoadmapPreview {
  const factory RoadmapPreview({
    required RoadmapItem item,
    required List<FinancialImpact> impacts,
    required bool isBalanced,
    required List<String> warnings,
    required List<String> risks,
    required bool requiresConfirmation,
    required bool canCommit,
  }) = _RoadmapPreview;

  const RoadmapPreview._();
}