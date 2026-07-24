import 'package:accounting_app/features/document_processing/data/document_processing_repository.dart';
import 'package:accounting_app/features/document_processing/domain/document_processing_job.dart';
import 'package:accounting_app/features/document_processing/domain/review_decision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ─── MockDocumentProcessingRepository seed data ───────────────────────────

  group('MockDocumentProcessingRepository seed data', () {
    late MockDocumentProcessingRepository repo;

    setUp(() => repo = MockDocumentProcessingRepository());

    test('fetchPendingReview returns only awaitingReview seeded jobs', () async {
      final result = await repo.fetchPendingReview();
      expect(result.isSuccess, isTrue);
      final jobs = result.data!;
      expect(jobs.every((j) => j.step == ProcessingStep.awaitingReview), isTrue);
      expect(jobs.length, 2); // DPJ-2026-0001 and DPJ-2026-0002
    });

    test('seeded jobs have expected attachment IDs', () async {
      final result = await repo.fetchPendingReview();
      final ids = result.data!.map((j) => j.attachmentId).toSet();
      expect(ids, containsAll(['ATT-2026-0004', 'ATT-2026-0003']));
    });

    test('fetchJob returns correct seeded job', () async {
      final result = await repo.fetchJob('DPJ-2026-0001');
      expect(result.isSuccess, isTrue);
      expect(result.data!.attachmentId, 'ATT-2026-0004');
      expect(result.data!.step, ProcessingStep.awaitingReview);
    });

    test('fetchJob returns failure for unknown id', () async {
      final result = await repo.fetchJob('DOES-NOT-EXIST');
      expect(result.isSuccess, isFalse);
    });

    test('updateJob persists step change', () async {
      final fetchResult = await repo.fetchJob('DPJ-2026-0001');
      final job = fetchResult.data!;
      final updated = job.copyWith(step: ProcessingStep.reviewApproved);

      final updateResult = await repo.updateJob(updated);
      expect(updateResult.isSuccess, isTrue);

      final refetch = await repo.fetchJob('DPJ-2026-0001');
      expect(refetch.data!.step, ProcessingStep.reviewApproved);
    });

    test('updateJob returns failure for unknown job', () async {
      final ghost = DocumentProcessingJob(
        id: 'GHOST-001',
        attachmentId: 'ATT-X',
        step: ProcessingStep.uploaded,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final result = await repo.updateJob(ghost);
      expect(result.isSuccess, isFalse);
    });

    test('createJob adds new job and returns it', () async {
      final result = await repo.createJob('ATT-NEW-001');
      expect(result.isSuccess, isTrue);
      expect(result.data!.attachmentId, 'ATT-NEW-001');
      expect(result.data!.step, ProcessingStep.uploaded);

      final fetch = await repo.fetchJob(result.data!.id);
      expect(fetch.isSuccess, isTrue);
    });

    test('fetchJobsForAttachment returns jobs for that attachment only',
        () async {
      final result = await repo.fetchJobsForAttachment('ATT-2026-0004');
      expect(result.isSuccess, isTrue);
      expect(result.data!.every((j) => j.attachmentId == 'ATT-2026-0004'),
          isTrue);
    });

    test('rejected seeded job has review decision', () async {
      final result = await repo.fetchJob('DPJ-2026-0004');
      expect(result.isSuccess, isTrue);
      final job = result.data!;
      expect(job.step, ProcessingStep.reviewRejected);
      expect(job.reviewDecision, isNotNull);
      expect(job.reviewDecision!.isRejected, isTrue);
      expect(job.reviewDecision!.reviewedBy, 'alice');
    });

    test('completed seeded job has createdDocumentId', () async {
      final result = await repo.fetchJob('DPJ-2026-0003');
      expect(result.isSuccess, isTrue);
      final job = result.data!;
      expect(job.step, ProcessingStep.completed);
      expect(job.createdDocumentId, 'PO-2026-000001');
    });
  });

  // ─── ReviewDecision integration with repository ───────────────────────────

  group('ReviewDecision stored in repository', () {
    test('approve decision is persisted via updateJob', () async {
      final repo = MockDocumentProcessingRepository();
      final fetchResult = await repo.fetchJob('DPJ-2026-0001');
      final job = fetchResult.data!;

      final decision = ReviewDecision.approve(
        reviewedBy: 'reviewer_1',
        note: 'All fields verified',
      );
      final updated = job.copyWith(
        step: ProcessingStep.reviewApproved,
        reviewDecision: decision,
      );
      await repo.updateJob(updated);

      final refetch = await repo.fetchJob('DPJ-2026-0001');
      expect(refetch.data!.reviewDecision!.reviewedBy, 'reviewer_1');
      expect(refetch.data!.reviewDecision!.note, 'All fields verified');
      expect(refetch.data!.reviewDecision!.isApproved, isTrue);
    });

    test('after approval, job no longer appears in fetchPendingReview',
        () async {
      final repo = MockDocumentProcessingRepository();
      final fetchResult = await repo.fetchJob('DPJ-2026-0001');
      final updated = fetchResult.data!.copyWith(
        step: ProcessingStep.reviewApproved,
      );
      await repo.updateJob(updated);

      final pending = await repo.fetchPendingReview();
      final ids = pending.data!.map((j) => j.id).toList();
      expect(ids, isNot(contains('DPJ-2026-0001')));
    });
  });

  // ─── ProcessingStep helpers ───────────────────────────────────────────────

  group('ProcessingStep', () {
    test('isTerminal is true for completed, failed, reviewRejected', () {
      expect(ProcessingStep.completed.isTerminal, isTrue);
      expect(ProcessingStep.failed.isTerminal, isTrue);
      expect(ProcessingStep.reviewRejected.isTerminal, isTrue);
    });

    test('isTerminal is false for non-terminal steps', () {
      expect(ProcessingStep.uploaded.isTerminal, isFalse);
      expect(ProcessingStep.awaitingReview.isTerminal, isFalse);
      expect(ProcessingStep.reviewApproved.isTerminal, isFalse);
    });

    test('requiresHumanAction is true only for awaitingReview', () {
      expect(ProcessingStep.awaitingReview.requiresHumanAction, isTrue);
      for (final step in ProcessingStep.values) {
        if (step != ProcessingStep.awaitingReview) {
          expect(step.requiresHumanAction, isFalse,
              reason: '${step.name} should not require human action');
        }
      }
    });

    test('every step has a non-empty label', () {
      for (final step in ProcessingStep.values) {
        expect(step.label, isNotEmpty,
            reason: '${step.name} label must not be empty');
      }
    });
  });
}
