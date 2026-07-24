import '../../attachments/ocr/domain/document_classification.dart';
import '../../attachments/ocr/domain/ocr_result.dart';
import 'extracted_document_draft.dart';
import 'review_decision.dart';

/// Every discrete step in the pipeline.
enum ProcessingStep {
  uploaded,
  classifying,
  classified,
  extracting,
  extracted,
  awaitingReview,
  reviewApproved,
  reviewRejected,
  creatingDocument,
  completed,
  failed;

  String get label {
    switch (this) {
      case ProcessingStep.uploaded:
        return 'Uploaded';
      case ProcessingStep.classifying:
        return 'Classifying';
      case ProcessingStep.classified:
        return 'Classified';
      case ProcessingStep.extracting:
        return 'Extracting';
      case ProcessingStep.extracted:
        return 'Extracted';
      case ProcessingStep.awaitingReview:
        return 'Awaiting Review';
      case ProcessingStep.reviewApproved:
        return 'Review Approved';
      case ProcessingStep.reviewRejected:
        return 'Review Rejected';
      case ProcessingStep.creatingDocument:
        return 'Creating Document';
      case ProcessingStep.completed:
        return 'Completed';
      case ProcessingStep.failed:
        return 'Failed';
    }
  }

  bool get isTerminal =>
      this == ProcessingStep.completed ||
      this == ProcessingStep.failed ||
      this == ProcessingStep.reviewRejected;

  bool get requiresHumanAction => this == ProcessingStep.awaitingReview;
}

/// Immutable snapshot of a document processing job.
class DocumentProcessingJob {
  const DocumentProcessingJob({
    required this.id,
    required this.attachmentId,
    required this.step,
    required this.createdAt,
    required this.updatedAt,
    this.classification,
    this.ocrResult,
    this.draft,
    this.reviewDecision,
    this.createdDocumentId,
    this.createdDocumentType,
    this.errorMessage,
  });

  final String id;
  final String attachmentId;
  final ProcessingStep step;
  final DateTime createdAt;
  final DateTime updatedAt;

  final DocumentClassification? classification;
  final OcrResult? ocrResult;
  final ExtractedDocumentDraft? draft;
  final ReviewDecision? reviewDecision;
  final String? createdDocumentId;
  final String? createdDocumentType;
  final String? errorMessage;

  bool get isSuccessful => step == ProcessingStep.completed;
  bool get hasFailed => step == ProcessingStep.failed;
  bool get needsReview => step == ProcessingStep.awaitingReview;

  DocumentProcessingJob copyWith({
    ProcessingStep? step,
    DateTime? updatedAt,
    DocumentClassification? classification,
    OcrResult? ocrResult,
    ExtractedDocumentDraft? draft,
    ReviewDecision? reviewDecision,
    String? createdDocumentId,
    String? createdDocumentType,
    String? errorMessage,
  }) =>
      DocumentProcessingJob(
        id: id,
        attachmentId: attachmentId,
        step: step ?? this.step,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        classification: classification ?? this.classification,
        ocrResult: ocrResult ?? this.ocrResult,
        draft: draft ?? this.draft,
        reviewDecision: reviewDecision ?? this.reviewDecision,
        createdDocumentId: createdDocumentId ?? this.createdDocumentId,
        createdDocumentType: createdDocumentType ?? this.createdDocumentType,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
