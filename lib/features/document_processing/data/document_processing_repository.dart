import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
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
