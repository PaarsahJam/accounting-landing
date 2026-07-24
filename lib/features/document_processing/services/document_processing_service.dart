import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../../attachments/ocr/data/ocr_repository.dart';
import '../../attachments/ocr/domain/document_classification.dart';
import '../../attachments/ocr/services/ocr_pipeline.dart';
import '../../audit_trail/data/audit_trail_repository.dart';
import '../../audit_trail/domain/audit_action.dart';
import '../../audit_trail/domain/audit_entity_type.dart';
import '../../audit_trail/domain/audit_entry.dart';
import '../data/document_processing_repository.dart';
import '../domain/document_processing_job.dart';
import '../domain/extracted_document_draft.dart';
import '../domain/review_decision.dart';

/// Orchestrates the full document processing pipeline.
///
/// Every step is:
/// 1. Persisted to [DocumentProcessingRepository]
/// 2. Logged to [AuditTrailRepository]
/// 3. Returned as an [AppResult] — callers decide what to do on failure
///
/// Financial documents are NEVER created without an explicit [ReviewDecision]
/// with [ReviewOutcome.approved].
class DocumentProcessingService {
  DocumentProcessingService({
    required DocumentProcessingRepository processingRepository,
    required AuditTrailRepository auditRepository,
    required OcrRepository ocrRepository,
    required OcrPipeline ocrPipeline,
    this.performedBy = 'system',
  })  : _repo = processingRepository,
        _audit = auditRepository,
        _ocrRepo = ocrRepository,
        _pipeline = ocrPipeline;

  final DocumentProcessingRepository _repo;
  final AuditTrailRepository _audit;
  final OcrRepository _ocrRepo;
  final OcrPipeline _pipeline;
  final String performedBy;

  // ─── Step 1: Upload ────────────────────────────────────────────────────────

  /// Creates a new job for [attachmentId] and logs the upload event.
  Future<AppResult<DocumentProcessingJob>> startProcessing(
      String attachmentId) async {
    final result = await _repo.createJob(attachmentId);
    if (!result.isSuccess) return result;

    final job = result.data!;
    await _log(job, AuditAction.created,
        note: 'Document processing started for attachment $attachmentId');
    AppLogger.info('DocumentProcessing: job ${job.id} created');
    return AppResult.success(job);
  }

  // ─── Step 2: Classify ──────────────────────────────────────────────────────

  /// Runs document classification and advances the job to [ProcessingStep.classified].
  Future<AppResult<DocumentProcessingJob>> classify(
      DocumentProcessingJob job) async {
    final updated = await _advance(job, ProcessingStep.classifying);
    if (!updated.isSuccess) return updated;

    try {
      final attachment = await _ocrRepo.fetchAttachment(job.attachmentId);
      final classification = await _ocrRepo.classifyDocument(attachment);

      final classified = updated.data!.copyWith(
        step: ProcessingStep.classified,
        classification: classification,
      );
      final saved = await _repo.updateJob(classified);
      if (!saved.isSuccess) return saved;

      await _log(
        saved.data!,
        AuditAction.edited,
        note: 'Classified as ${classification.documentType.label} '
            '(confidence: ${(classification.confidence * 100).toStringAsFixed(0)}%)',
      );
      AppLogger.info(
          'DocumentProcessing: ${job.id} classified as '
          '${classification.documentType.label}');
      return saved;
    } catch (e) {
      return _fail(updated.data!, 'Classification failed: $e');
    }
  }

  // ─── Step 3: OCR + Extract ─────────────────────────────────────────────────

  /// Runs OCR and structured extraction, advancing to [ProcessingStep.extracted].
  Future<AppResult<DocumentProcessingJob>> extract(
      DocumentProcessingJob job) async {
    final updated = await _advance(job, ProcessingStep.extracting);
    if (!updated.isSuccess) return updated;

    try {
      final attachment = await _ocrRepo.fetchAttachment(job.attachmentId);
      final ocrResult = await _pipeline.processAttachment(attachment);

      if (!ocrResult.isSuccessful) {
        return _fail(updated.data!,
            'OCR failed: ${ocrResult.errorMessage ?? 'unknown error'}');
      }

      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);
      final extracted = updated.data!.copyWith(
        step: ProcessingStep.extracted,
        ocrResult: ocrResult,
        draft: draft,
      );
      final saved = await _repo.updateJob(extracted);
      if (!saved.isSuccess) return saved;

      await _log(
        saved.data!,
        AuditAction.edited,
        note: 'Extracted ${ocrResult.fields.length} fields, '
            '${ocrResult.lineItems.length} line items. '
            'Ready for review: ${draft.isReadyForAutoCreate}',
      );
      AppLogger.info('DocumentProcessing: ${job.id} extraction complete');
      return saved;
    } catch (e) {
      return _fail(updated.data!, 'Extraction failed: $e');
    }
  }

  // ─── Step 4: Queue for review ──────────────────────────────────────────────

  /// Moves the job to [ProcessingStep.awaitingReview].
  /// This is always called after extraction — no document is created without review.
  Future<AppResult<DocumentProcessingJob>> queueForReview(
      DocumentProcessingJob job) async {
    final queued = job.copyWith(step: ProcessingStep.awaitingReview);
    final saved = await _repo.updateJob(queued);
    if (!saved.isSuccess) return saved;

    await _log(saved.data!, AuditAction.edited,
        note: 'Queued for human review');
    return saved;
  }

  // ─── Step 5: Human review ──────────────────────────────────────────────────

  /// Records the reviewer's [decision].
  ///
  /// - [ReviewOutcome.approved] → advances to [ProcessingStep.reviewApproved]
  /// - [ReviewOutcome.rejected] → advances to [ProcessingStep.reviewRejected] (terminal)
  /// - [ReviewOutcome.manualEntry] → advances to [ProcessingStep.reviewRejected]
  ///   (caller handles manual creation)
  Future<AppResult<DocumentProcessingJob>> submitReview(
    DocumentProcessingJob job,
    ReviewDecision decision,
  ) async {
    if (job.step != ProcessingStep.awaitingReview) {
      return AppResult.failure(ValidationFailure(
          message: 'Job ${job.id} is not awaiting review '
              '(current step: ${job.step.label})'));
    }

    final nextStep = decision.isApproved
        ? ProcessingStep.reviewApproved
        : ProcessingStep.reviewRejected;

    final reviewed = job.copyWith(
      step: nextStep,
      reviewDecision: decision,
    );
    final saved = await _repo.updateJob(reviewed);
    if (!saved.isSuccess) return saved;

    final action = decision.isApproved
        ? AuditAction.approved
        : AuditAction.rejected;
    await _log(
      saved.data!,
      action,
      note: 'Review by ${decision.reviewedBy}: ${decision.outcome.name}'
          '${decision.note != null ? ' — ${decision.note}' : ''}'
          '${decision.fieldCorrections.isNotEmpty ? ' (${decision.fieldCorrections.length} corrections)' : ''}',
    );
    AppLogger.info(
        'DocumentProcessing: ${job.id} review ${decision.outcome.name} '
        'by ${decision.reviewedBy}');
    return saved;
  }

  // ─── Step 6: Create financial document ────────────────────────────────────

  /// Creates the financial document from the approved draft.
  ///
  /// SAFETY GATE: only proceeds if [job.step] == [ProcessingStep.reviewApproved].
  /// Returns a failure if called on any other step.
  ///
  /// The actual document creation is delegated to [createDocument] callback
  /// so this service stays decoupled from specific feature repositories.
  Future<AppResult<DocumentProcessingJob>> createFinancialDocument(
    DocumentProcessingJob job, {
    required Future<AppResult<String>> Function(
            ExtractedDocumentDraft draft, ReviewDecision decision)
        createDocument,
  }) async {
    if (job.step != ProcessingStep.reviewApproved) {
      return AppResult.failure(ValidationFailure(
          message: 'Cannot create document: job ${job.id} '
              'has not been approved (step: ${job.step.label})'));
    }
    if (job.draft == null) {
      return AppResult.failure(
          const ValidationFailure(message: 'No draft available'));
    }

    final creating = job.copyWith(step: ProcessingStep.creatingDocument);
    await _repo.updateJob(creating);

    try {
      final docResult =
          await createDocument(job.draft!, job.reviewDecision!);
      if (!docResult.isSuccess) {
        return _fail(creating, 'Document creation failed: '
            '${docResult.error?.message}');
      }

      final completed = creating.copyWith(
        step: ProcessingStep.completed,
        createdDocumentId: docResult.data,
        createdDocumentType:
            job.draft!.documentType.targetEntityType ?? 'unknown',
      );
      final saved = await _repo.updateJob(completed);
      if (!saved.isSuccess) return saved;

      await _log(
        saved.data!,
        AuditAction.created,
        note: 'Financial document created: ${docResult.data} '
            '(type: ${job.draft!.documentType.label})',
      );
      AppLogger.info(
          'DocumentProcessing: ${job.id} completed → ${docResult.data}');
      return saved;
    } catch (e) {
      return _fail(creating, 'Document creation threw: $e');
    }
  }

  // ─── Convenience: run classify + extract + queue in one call ──────────────

  /// Runs steps 2–4 sequentially. Stops and returns on first failure.
  Future<AppResult<DocumentProcessingJob>> runPipeline(
      DocumentProcessingJob job) async {
    var current = job;

    final classified = await classify(current);
    if (!classified.isSuccess) return classified;
    current = classified.data!;

    // Skip unsupported document types early
    if (current.classification?.documentType == DocumentType.other ||
        current.classification?.documentType == DocumentType.contract ||
        current.classification?.documentType == DocumentType.taxDocument) {
      return _fail(current,
          'Document type ${current.classification!.documentType.label} '
          'is not supported for automated processing');
    }

    final extracted = await extract(current);
    if (!extracted.isSuccess) return extracted;
    current = extracted.data!;

    return queueForReview(current);
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Future<AppResult<DocumentProcessingJob>> _advance(
      DocumentProcessingJob job, ProcessingStep step) async {
    final next = job.copyWith(step: step);
    return _repo.updateJob(next);
  }

  Future<AppResult<DocumentProcessingJob>> _fail(
      DocumentProcessingJob job, String message) async {
    AppLogger.warning('DocumentProcessing: ${job.id} failed — $message');
    final failed = job.copyWith(
      step: ProcessingStep.failed,
      errorMessage: message,
    );
    final saved = await _repo.updateJob(failed);
    await _log(
      failed,
      AuditAction.cancelled,
      note: 'Processing failed: $message',
    );
    return saved.isSuccess
        ? AppResult.failure(UnknownFailure(message: message))
        : saved;
  }

  Future<void> _log(
    DocumentProcessingJob job,
    AuditAction action, {
    String? note,
  }) async {
    await _audit.addEntry(AuditEntry(
      id: 'DPJ-AUD-${job.id}-${DateTime.now().microsecondsSinceEpoch}',
      entityType: AuditEntityType.aiAssistant,
      entityId: job.id,
      entityLabel: 'Document Processing Job ${job.id}',
      action: action,
      performedAt: DateTime.now(),
      performedBy: performedBy,
      note: note,
      newValue: job.step.label,
    ));
  }
}
