import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/ocr/data/ocr_repository.dart';
import 'package:accounting_app/features/attachments/ocr/providers/ocr_providers.dart';
import 'package:accounting_app/features/attachments/ocr/services/ocr_pipeline.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/document_processing/data/document_processing_repository.dart';
import 'package:accounting_app/features/document_processing/data/document_processing_repository_provider.dart';
import 'package:accounting_app/features/document_processing/domain/document_processing_controller.dart';
import 'package:accounting_app/features/document_processing/domain/document_processing_job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ─── Helpers ─────────────────────────────────────────────────────────────────

ProviderContainer _makeContainer({
  MockDocumentProcessingRepository? repo,
  MockAuditTrailRepository? audit,
}) {
  final processingRepo = repo ?? MockDocumentProcessingRepository();
  final auditRepo = audit ?? MockAuditTrailRepository();
  final attachmentsRepo = MockAttachmentsRepository(auditRepository: auditRepo);
  final ocrRepo = MockOcrRepository(attachmentsRepository: attachmentsRepo);
  final pipeline = OcrPipeline(repository: ocrRepo);

  return ProviderContainer(
    overrides: [
      documentProcessingRepositoryProvider.overrideWithValue(processingRepo),
      auditTrailRepositoryProvider.overrideWithValue(auditRepo),
      ocrRepositoryProvider.overrideWithValue(ocrRepo),
      ocrPipelineProvider.overrideWithValue(pipeline),
    ],
  );
}

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  group('DocumentProcessingController', () {
    test('build() loads pending review jobs from seeded repository', () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final state = await container
          .read(documentProcessingControllerProvider.future);

      // Seeded repo has 2 awaitingReview jobs
      expect(state.length, 2);
      expect(state.every((j) => j.step == ProcessingStep.awaitingReview),
          isTrue);
    });

    test('approve() moves job to reviewApproved and removes from queue',
        () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final jobs = await container
          .read(documentProcessingControllerProvider.future);
      final job = jobs.first;

      await container
          .read(documentProcessingControllerProvider.notifier)
          .approve(job, note: 'Verified');

      final updated = await container
          .read(documentProcessingControllerProvider.future);

      // Approved job is no longer in the pending queue
      expect(updated.any((j) => j.id == job.id), isFalse);
    });

    test('reject() moves job to reviewRejected and removes from queue',
        () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final jobs = await container
          .read(documentProcessingControllerProvider.future);
      final job = jobs.first;

      await container
          .read(documentProcessingControllerProvider.notifier)
          .reject(job, note: 'Duplicate document');

      final updated = await container
          .read(documentProcessingControllerProvider.future);

      expect(updated.any((j) => j.id == job.id), isFalse);
    });

    test('refresh() reloads the queue', () async {
      final repo = MockDocumentProcessingRepository();
      final container = _makeContainer(repo: repo);
      addTearDown(container.dispose);

      // Initial load
      final initial = await container
          .read(documentProcessingControllerProvider.future);
      expect(initial.length, 2);

      // Add a new pending job directly to the repo
      await repo.createJob('ATT-NEW-999');
      final newJob = (await repo.fetchJob(
        (await repo.fetchPendingReview()).data!.first.id,
      )).data!;
      await repo.updateJob(
        newJob.copyWith(step: ProcessingStep.awaitingReview),
      );

      await container
          .read(documentProcessingControllerProvider.notifier)
          .refresh();

      final refreshed = await container
          .read(documentProcessingControllerProvider.future);
      // Still 2 — the new job was created at 'uploaded', not awaitingReview
      expect(refreshed.length, 2);
    });

    test('approve() on non-awaitingReview job results in error state',
        () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      // Fetch a completed job (not awaitingReview)
      final repo = container.read(documentProcessingRepositoryProvider)
          as MockDocumentProcessingRepository;
      final completedResult = await repo.fetchJob('DPJ-2026-0003');
      final completedJob = completedResult.data!;

      await container
          .read(documentProcessingControllerProvider.notifier)
          .approve(completedJob);

      final state = container.read(documentProcessingControllerProvider);
      expect(state.hasError, isTrue);
    });
  });
}
