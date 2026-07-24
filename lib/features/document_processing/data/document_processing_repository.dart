import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../attachments/ocr/domain/document_classification.dart';
import '../domain/document_processing_job.dart';
import '../domain/review_decision.dart';

abstract class DocumentProcessingRepository {
  Future<AppResult<DocumentProcessingJob>> createJob(String attachmentId);
  Future<AppResult<DocumentProcessingJob>> updateJob(DocumentProcessingJob job);
  Future<AppResult<DocumentProcessingJob>> fetchJob(String jobId);
  Future<AppResult<List<DocumentProcessingJob>>> fetchJobsForAttachment(
      String attachmentId);
  Future<AppResult<List<DocumentProcessingJob>>> fetchPendingReview();
}

class MockDocumentProcessingRepository
    implements DocumentProcessingRepository {
  final List<DocumentProcessingJob> _jobs = [];
  int _seq = 1;

  MockDocumentProcessingRepository() {
    _seed();
  }

  void _seed() {
    final base = DateTime(2026, 2, 10);
    _jobs.addAll([
      DocumentProcessingJob(
        id: 'DPJ-2026-0001',
        attachmentId: 'ATT-2026-0004',
        step: ProcessingStep.awaitingReview,
        createdAt: base,
        updatedAt: base.add(const Duration(minutes: 3)),
        classification: const DocumentClassification(
          documentType: DocumentType.vendorBill,
          confidence: 0.92,
        ),
      ),
      DocumentProcessingJob(
        id: 'DPJ-2026-0002',
        attachmentId: 'ATT-2026-0003',
        step: ProcessingStep.awaitingReview,
        createdAt: base.add(const Duration(hours: 2)),
        updatedAt: base.add(const Duration(hours: 2, minutes: 4)),
        classification: const DocumentClassification(
          documentType: DocumentType.invoice,
          confidence: 0.94,
        ),
      ),
      DocumentProcessingJob(
        id: 'DPJ-2026-0003',
        attachmentId: 'ATT-2026-0001',
        step: ProcessingStep.completed,
        createdAt: base.subtract(const Duration(days: 1)),
        updatedAt: base.subtract(const Duration(days: 1, minutes: -10)),
        classification: const DocumentClassification(
          documentType: DocumentType.purchaseOrder,
          confidence: 0.95,
        ),
        createdDocumentId: 'PO-2026-000001',
        createdDocumentType: 'purchaseOrder',
      ),
      DocumentProcessingJob(
        id: 'DPJ-2026-0004',
        attachmentId: 'ATT-2026-0005',
        step: ProcessingStep.reviewRejected,
        createdAt: base.subtract(const Duration(days: 2)),
        updatedAt: base.subtract(const Duration(days: 2, minutes: -15)),
        classification: const DocumentClassification(
          documentType: DocumentType.vendorBill,
          confidence: 0.71,
        ),
        reviewDecision: ReviewDecision.reject(
          reviewedBy: 'alice',
          note: 'Duplicate bill — already entered manually',
        ),
      ),
    ]);
    _seq = 5;
  }

  String _nextId() =>
      'DPJ-${DateTime.now().year}-${(_seq++).toString().padLeft(4, '0')}';

  @override
  Future<AppResult<DocumentProcessingJob>> createJob(
      String attachmentId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final job = DocumentProcessingJob(
      id: _nextId(),
      attachmentId: attachmentId,
      step: ProcessingStep.uploaded,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _jobs.add(job);
    return AppResult.success(job);
  }

  @override
  Future<AppResult<DocumentProcessingJob>> updateJob(
      DocumentProcessingJob job) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final idx = _jobs.indexWhere((j) => j.id == job.id);
    if (idx < 0) {
      return AppResult.failure(
          const UnknownFailure(message: 'Job not found'));
    }
    _jobs[idx] = job;
    return AppResult.success(job);
  }

  @override
  Future<AppResult<DocumentProcessingJob>> fetchJob(String jobId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    try {
      return AppResult.success(_jobs.firstWhere((j) => j.id == jobId));
    } catch (_) {
      return AppResult.failure(
          const UnknownFailure(message: 'Job not found'));
    }
  }

  @override
  Future<AppResult<List<DocumentProcessingJob>>> fetchJobsForAttachment(
      String attachmentId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return AppResult.success(
        _jobs.where((j) => j.attachmentId == attachmentId).toList());
  }

  @override
  Future<AppResult<List<DocumentProcessingJob>>> fetchPendingReview() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return AppResult.success(
        _jobs.where((j) => j.step == ProcessingStep.awaitingReview).toList());
  }
}
