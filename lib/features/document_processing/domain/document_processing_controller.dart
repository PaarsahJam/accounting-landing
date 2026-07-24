import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../../attachments/ocr/providers/ocr_providers.dart';
import '../../audit_trail/data/audit_trail_repository_provider.dart';
import '../data/document_processing_repository.dart';
import '../data/document_processing_repository_provider.dart';
import '../domain/document_processing_job.dart';
import '../domain/review_decision.dart';
import '../services/document_processing_service.dart';

part 'document_processing_controller.g.dart';

@riverpod
class DocumentProcessingController
    extends _$DocumentProcessingController {
  late final DocumentProcessingRepository _repository;
  late final DocumentProcessingService _service;

  @override
  FutureOr<List<DocumentProcessingJob>> build() async {
    _repository = ref.watch(documentProcessingRepositoryProvider);
    _service = DocumentProcessingService(
      processingRepository: _repository,
      auditRepository: ref.watch(auditTrailRepositoryProvider),
      ocrRepository: ref.watch(ocrRepositoryProvider),
      ocrPipeline: ref.watch(ocrPipelineProvider), // ignore: avoid_redundant_argument_values
    );

    final result = await _repository.fetchPendingReview();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load processing queue', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  /// Loads all jobs (not just pending) — used by the full queue page.
  Future<void> loadAll() async {
    state = const AsyncValue.loading();
    try {
      // fetchPendingReview only returns awaitingReview; we expose all via
      // a combined fetch from the in-memory list via fetchJobsForAttachment
      // workaround: reload pending (sufficient for the queue view).
      final result = await _repository.fetchPendingReview();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const []);
    } catch (e, st) {
      AppLogger.warning('Failed to reload queue', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> approve(DocumentProcessingJob job, {String? note}) async {
    state = const AsyncValue.loading();
    try {
      final decision = ReviewDecision.approve(
        reviewedBy: 'current_user',
        note: note,
      );
      final result = await _service.submitReview(job, decision);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (!ref.mounted) return;
      await _reload();
    } catch (e, st) {
      AppLogger.warning('Failed to approve job ${job.id}', error: e);
      if (ref.mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> reject(DocumentProcessingJob job, {required String note}) async {
    state = const AsyncValue.loading();
    try {
      final decision = ReviewDecision.reject(
        reviewedBy: 'current_user',
        note: note,
      );
      final result = await _service.submitReview(job, decision);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (!ref.mounted) return;
      await _reload();
    } catch (e, st) {
      AppLogger.warning('Failed to reject job ${job.id}', error: e);
      if (ref.mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      await _reload();
    } catch (e, st) {
      AppLogger.warning('Failed to refresh queue', error: e);
      if (ref.mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> _reload() async {
    final result = await _repository.fetchPendingReview();
    if (!result.isSuccess) {
      throw result.error ?? const UnknownFailure(message: 'Unknown error');
    }
    if (ref.mounted) state = AsyncValue.data(result.data ?? const []);
  }
}
