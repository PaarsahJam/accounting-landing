import 'package:freezed_annotation/freezed_annotation.dart';

import 'models/roadmap_item.dart';
import 'models/roadmap_mutation.dart';

part 'roadmap_mutation_request.freezed.dart';

@freezed
abstract class RoadmapMutationRequest with _$RoadmapMutationRequest {
  const factory RoadmapMutationRequest({
    required RoadmapItem item,
    required RoadmapMutation mutation,
    required bool isDestructive,
    required bool isPosting,
    required String confirmationToken,
    required String requestedBy,
  }) = _RoadmapMutationRequest;

  const RoadmapMutationRequest._();
}