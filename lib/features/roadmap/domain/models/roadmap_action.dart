import 'package:freezed_annotation/freezed_annotation.dart';

part 'roadmap_action.freezed.dart';

@freezed
abstract class RoadmapAction with _$RoadmapAction {
  const factory RoadmapAction({
    required String id,
    required String label,
    required RoadmapActionType type,
    required List<String> targetAccountIds,
    double? amount,
    String? description,
    required bool requiresConfirmation,
  }) = _RoadmapAction;

  const RoadmapAction._();

  bool get isDestructive => type == RoadmapActionType.delete || type == RoadmapActionType.reverse;
}

enum RoadmapActionType {
  create,
  update,
  delete,
  reverse,
  adjust,
}