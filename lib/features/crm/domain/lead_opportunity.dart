import 'package:freezed_annotation/freezed_annotation.dart';

part 'lead_opportunity.freezed.dart';

enum PipelineStage {
  lead,
  qualified,
  proposal,
  negotiation,
  won,
  lost;

  String get label {
    switch (this) {
      case PipelineStage.lead:
        return 'Lead';
      case PipelineStage.qualified:
        return 'Qualified';
      case PipelineStage.proposal:
        return 'Proposal';
      case PipelineStage.negotiation:
        return 'Negotiation';
      case PipelineStage.won:
        return 'Won';
      case PipelineStage.lost:
        return 'Lost';
    }
  }
}

@freezed
abstract class LeadOpportunity with _$LeadOpportunity {
  const factory LeadOpportunity({
    required String id,
    required String customerId,
    String? contactId,
    required String title,
    required String description,
    required PipelineStage stage,
    required double estimatedValue,
    required double probability,
    required DateTime expectedCloseDate,
    required String owner,
    required DateTime createdAt,
    DateTime? wonAt,
  }) = _LeadOpportunity;
}
