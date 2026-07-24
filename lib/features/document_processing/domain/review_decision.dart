/// The outcome of a human review step.
enum ReviewOutcome {
  approved, // proceed to document creation
  rejected, // discard — do not create any document
  manualEntry, // reviewer wants to create the document manually
}

/// Immutable record of a human review decision.
class ReviewDecision {
  const ReviewDecision({
    required this.outcome,
    required this.reviewedBy,
    required this.reviewedAt,
    this.note,
    this.fieldCorrections = const {},
  });

  final ReviewOutcome outcome;
  final String reviewedBy;
  final DateTime reviewedAt;

  /// Optional note explaining the decision.
  final String? note;

  /// Key → corrected value pairs for fields the reviewer changed.
  /// Keys match the field names used in [ExtractedDocumentDraft].
  final Map<String, dynamic> fieldCorrections;

  bool get isApproved => outcome == ReviewOutcome.approved;
  bool get isRejected => outcome == ReviewOutcome.rejected;

  static ReviewDecision approve({
    required String reviewedBy,
    Map<String, dynamic> corrections = const {},
    String? note,
  }) =>
      ReviewDecision(
        outcome: ReviewOutcome.approved,
        reviewedBy: reviewedBy,
        reviewedAt: DateTime.now(),
        note: note,
        fieldCorrections: corrections,
      );

  static ReviewDecision reject({
    required String reviewedBy,
    required String note,
  }) =>
      ReviewDecision(
        outcome: ReviewOutcome.rejected,
        reviewedBy: reviewedBy,
        reviewedAt: DateTime.now(),
        note: note,
      );

  static ReviewDecision manualEntry({required String reviewedBy}) =>
      ReviewDecision(
        outcome: ReviewOutcome.manualEntry,
        reviewedBy: reviewedBy,
        reviewedAt: DateTime.now(),
      );
}
