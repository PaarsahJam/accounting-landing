import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/ocr/data/ocr_repository.dart';
import 'package:accounting_app/features/attachments/ocr/domain/document_classification.dart';
import 'package:accounting_app/features/attachments/ocr/domain/ocr_field.dart';
import 'package:accounting_app/features/attachments/ocr/domain/ocr_result.dart';
import 'package:accounting_app/features/attachments/ocr/services/ocr_pipeline.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/document_processing/data/document_processing_repository.dart';
import 'package:accounting_app/features/document_processing/domain/document_processing_job.dart';
import 'package:accounting_app/features/document_processing/domain/extracted_document_draft.dart';
import 'package:accounting_app/features/document_processing/domain/review_decision.dart';
import 'package:accounting_app/features/document_processing/services/document_processing_service.dart';
import 'package:flutter_test/flutter_test.dart';

// ─── Helpers ─────────────────────────────────────────────────────────────────

MockOcrRepository _makeOcrRepo() => MockOcrRepository(
      attachmentsRepository:
          MockAttachmentsRepository(auditRepository: MockAuditTrailRepository()),
    );

DocumentProcessingService _makeService({
  MockAuditTrailRepository? audit,
  MockDocumentProcessingRepository? repo,
  MockOcrRepository? ocrRepo,
}) {
  final ocrRepository = ocrRepo ?? _makeOcrRepo();
  return DocumentProcessingService(
    processingRepository: repo ?? MockDocumentProcessingRepository(),
    auditRepository: audit ?? MockAuditTrailRepository(),
    ocrRepository: ocrRepository,
    ocrPipeline: OcrPipeline(repository: ocrRepository),
    performedBy: 'test-user',
  );
}

OcrResult _makeOcrResult({
  DocumentType type = DocumentType.vendorBill,
  List<OcrField> fields = const [],
  bool successful = true,
}) =>
    OcrResult(
      attachmentId: 'ATT-001',
      status: successful
          ? OcrProcessingStatus.completed
          : OcrProcessingStatus.failed,
      classification: DocumentClassification(
        documentType: type,
        confidence: 0.92,
      ),
      fields: fields,
      rawText: 'raw text',
      processingLog: const [],
      processedAt: DateTime(2026, 2, 5),
    );

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  // ─── ExtractedDocumentDraft.fromOcrResult ──────────────────────────────────

  group('ExtractedDocumentDraft.fromOcrResult', () {
    test('vendorBill OcrResult produces VendorBillDraft', () {
      final ocrResult = _makeOcrResult(
        type: DocumentType.vendorBill,
        fields: [
          const OcrField(
              type: OcrFieldType.vendorName,
              value: 'ACME Supplies',
              confidence: 0.92),
          const OcrField(
              type: OcrFieldType.totalAmount,
              value: '715.00',
              confidence: 0.90),
          const OcrField(
              type: OcrFieldType.documentDate,
              value: '2026-02-15',
              confidence: 0.88),
          const OcrField(
              type: OcrFieldType.dueDate,
              value: '2026-03-17',
              confidence: 0.85),
        ],
      );

      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);

      expect(draft, isA<VendorBillDraft>());
      final bill = draft as VendorBillDraft;
      expect(bill.vendorName.value, 'ACME Supplies');
      expect(bill.total.value, 715.0);
      expect(bill.billDate.value, DateTime(2026, 2, 15));
      expect(bill.dueDate.value, DateTime(2026, 3, 17));
      expect(bill.vendorName.tier, FieldConfidence.high);
    });

    test('invoice OcrResult produces InvoiceDraft', () {
      final ocrResult = _makeOcrResult(
        type: DocumentType.invoice,
        fields: [
          const OcrField(
              type: OcrFieldType.customerName,
              value: 'TechCorp',
              confidence: 0.94),
          const OcrField(
              type: OcrFieldType.totalAmount,
              value: '21800.00',
              confidence: 0.92),
          const OcrField(
              type: OcrFieldType.invoiceNumber,
              value: 'INV-2026-0081',
              confidence: 0.95),
        ],
      );

      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);

      expect(draft, isA<InvoiceDraft>());
      final inv = draft as InvoiceDraft;
      expect(inv.customerName.value, 'TechCorp');
      expect(inv.total.value, 21800.0);
      expect(inv.reference.value, 'INV-2026-0081');
    });

    test('expenseReceipt OcrResult produces ExpenseReceiptDraft', () {
      final ocrResult = _makeOcrResult(
        type: DocumentType.expenseReceipt,
        fields: [
          const OcrField(
              type: OcrFieldType.merchantName,
              value: 'WeWork',
              confidence: 0.90),
          const OcrField(
              type: OcrFieldType.totalAmount,
              value: '2000.00',
              confidence: 0.85),
        ],
      );

      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);

      expect(draft, isA<ExpenseReceiptDraft>());
      final exp = draft as ExpenseReceiptDraft;
      expect(exp.merchant.value, 'WeWork');
      expect(exp.amount.value, 2000.0);
    });

    test('unsupported type produces UnsupportedDocumentDraft', () {
      final ocrResult = _makeOcrResult(type: DocumentType.contract);
      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);
      expect(draft, isA<UnsupportedDocumentDraft>());
      expect(draft.isReadyForAutoCreate, isFalse);
    });

    test('bankStatement always isReadyForAutoCreate = false', () {
      final ocrResult = _makeOcrResult(type: DocumentType.bankStatement);
      final draft = ExtractedDocumentDraft.fromOcrResult(ocrResult);
      expect(draft, isA<BankStatementDraft>());
      expect(draft.isReadyForAutoCreate, isFalse);
    });

    test('VendorBillDraft isReadyForAutoCreate true when fields are reliable',
        () {
      final draft = VendorBillDraft(
        classificationConfidence: 0.92,
        extractedAt: DateTime.now(),
        lineItems: const [],
        vendorName: const ExtractedField(value: 'ACME', confidence: 0.92),
        reference: const ExtractedField(value: 'BILL-001', confidence: 0.95),
        billDate: const ExtractedField(value: null, confidence: 0.5),
        dueDate: const ExtractedField(value: null, confidence: 0.5),
        total: const ExtractedField(value: 715.0, confidence: 0.90),
      );
      expect(draft.isReadyForAutoCreate, isTrue);
    });

    test('VendorBillDraft isReadyForAutoCreate false when total is low confidence',
        () {
      final draft = VendorBillDraft(
        classificationConfidence: 0.92,
        extractedAt: DateTime.now(),
        lineItems: const [],
        vendorName: const ExtractedField(value: 'ACME', confidence: 0.92),
        reference: const ExtractedField(value: 'BILL-001', confidence: 0.95),
        billDate: const ExtractedField(value: null, confidence: 0.5),
        dueDate: const ExtractedField(value: null, confidence: 0.5),
        total: const ExtractedField(value: 715.0, confidence: 0.4),
      );
      expect(draft.isReadyForAutoCreate, isFalse);
    });

    test('FieldConfidence.fromScore maps correctly', () {
      expect(FieldConfidence.fromScore(0.9), FieldConfidence.high);
      expect(FieldConfidence.fromScore(0.8), FieldConfidence.high);
      expect(FieldConfidence.fromScore(0.79), FieldConfidence.medium);
      expect(FieldConfidence.fromScore(0.5), FieldConfidence.medium);
      expect(FieldConfidence.fromScore(0.49), FieldConfidence.low);
    });

    test('ExtractedField.withUserOverride sets confidence to 1.0', () {
      const field = ExtractedField(value: 'old', confidence: 0.4);
      final overridden = field.withUserOverride('new');
      expect(overridden.value, 'new');
      expect(overridden.confidence, 1.0);
      expect(overridden.overriddenByUser, isTrue);
    });
  });

  // ─── ReviewDecision gating ─────────────────────────────────────────────────

  group('ReviewDecision', () {
    test('approve factory sets correct outcome', () {
      final d = ReviewDecision.approve(reviewedBy: 'alice');
      expect(d.isApproved, isTrue);
      expect(d.isRejected, isFalse);
      expect(d.outcome, ReviewOutcome.approved);
    });

    test('reject factory sets correct outcome', () {
      final d = ReviewDecision.reject(
          reviewedBy: 'bob', note: 'Duplicate document');
      expect(d.isRejected, isTrue);
      expect(d.isApproved, isFalse);
      expect(d.note, 'Duplicate document');
    });

    test('approve with corrections stores field corrections', () {
      final d = ReviewDecision.approve(
        reviewedBy: 'alice',
        corrections: {'total': 800.0, 'vendorName': 'Corrected Vendor'},
      );
      expect(d.fieldCorrections['total'], 800.0);
      expect(d.fieldCorrections['vendorName'], 'Corrected Vendor');
    });
  });

  // ─── DocumentProcessingService review gate ─────────────────────────────────

  group('DocumentProcessingService review gate', () {
    test('submitReview fails when job is not awaitingReview', () async {
      final service = _makeService();
      final jobResult = await service.startProcessing('ATT-001');
      final job = jobResult.data!;
      // job is at 'uploaded', not 'awaitingReview'

      final result = await service.submitReview(
        job,
        ReviewDecision.approve(reviewedBy: 'alice'),
      );

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not awaiting review'));
    });

    test('createFinancialDocument fails when job is not reviewApproved',
        () async {
      final service = _makeService();
      final jobResult = await service.startProcessing('ATT-001');
      final job = jobResult.data!;

      final result = await service.createFinancialDocument(
        job,
        createDocument: (_, _) async => AppResult.success('DOC-001'),
      );

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not been approved'));
    });

    test('createFinancialDocument fails when no draft is present', () async {
      final repo = MockDocumentProcessingRepository();
      final service = _makeService(repo: repo);

      final jobResult = await service.startProcessing('ATT-001');
      // Manually force to reviewApproved with no draft
      final forcedJob = jobResult.data!.copyWith(
        step: ProcessingStep.reviewApproved,
        reviewDecision: ReviewDecision.approve(reviewedBy: 'alice'),
      );
      await repo.updateJob(forcedJob);

      final result = await service.createFinancialDocument(
        forcedJob,
        createDocument: (_, _) async => AppResult.success('DOC-001'),
      );

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('No draft'));
    });
  });

  // ─── Full pipeline integration ─────────────────────────────────────────────

  group('DocumentProcessingService full pipeline', () {
    test('startProcessing creates job at uploaded step', () async {
      final service = _makeService();
      final result = await service.startProcessing('ATT-2026-0004');

      expect(result.isSuccess, isTrue);
      expect(result.data!.step, ProcessingStep.uploaded);
      expect(result.data!.attachmentId, 'ATT-2026-0004');
    });

    test('startProcessing logs audit entry', () async {
      final audit = MockAuditTrailRepository();
      final service = _makeService(audit: audit);
      final result = await service.startProcessing('ATT-001');

      final entries = (await audit.fetchEntries()).data!;
      final dpjEntries = entries.where(
        (e) => e.entityType == AuditEntityType.aiAssistant,
      );
      expect(dpjEntries, isNotEmpty);
      expect(dpjEntries.first.action, AuditAction.created);
      expect(result.data!.id, isNotEmpty);
    });

    test('runPipeline advances vendorBill attachment to awaitingReview',
        () async {
      final service = _makeService();
      final jobResult = await service.startProcessing('ATT-2026-0004');
      final job = jobResult.data!;

      final pipelineResult = await service.runPipeline(job);

      expect(pipelineResult.isSuccess, isTrue);
      expect(pipelineResult.data!.step, ProcessingStep.awaitingReview);
      expect(pipelineResult.data!.classification, isNotNull);
      expect(pipelineResult.data!.ocrResult, isNotNull);
      expect(pipelineResult.data!.draft, isNotNull);
    });

    test('full pipeline: upload → pipeline → approve → create document',
        () async {
      final audit = MockAuditTrailRepository();
      final service = _makeService(audit: audit);

      // Step 1: start
      final jobResult = await service.startProcessing('ATT-2026-0004');
      expect(jobResult.isSuccess, isTrue);

      // Steps 2-4: classify + extract + queue
      final pipelineResult = await service.runPipeline(jobResult.data!);
      expect(pipelineResult.isSuccess, isTrue);
      expect(pipelineResult.data!.step, ProcessingStep.awaitingReview);

      // Step 5: human review
      final reviewResult = await service.submitReview(
        pipelineResult.data!,
        ReviewDecision.approve(
          reviewedBy: 'alice',
          note: 'Looks correct',
        ),
      );
      expect(reviewResult.isSuccess, isTrue);
      expect(reviewResult.data!.step, ProcessingStep.reviewApproved);

      // Step 6: create document (mock creation)
      final createResult = await service.createFinancialDocument(
        reviewResult.data!,
        createDocument: (draft, decision) async {
          // Verify the safety gate passed the correct draft type
          expect(draft, isA<VendorBillDraft>());
          return AppResult.success('VB-2026-TEST-001');
        },
      );
      expect(createResult.isSuccess, isTrue);
      expect(createResult.data!.step, ProcessingStep.completed);
      expect(createResult.data!.createdDocumentId, 'VB-2026-TEST-001');
      expect(createResult.data!.createdDocumentType, 'vendorBill');

      // Verify audit trail has entries for every step
      final entries = (await audit.fetchEntries()).data!;
      final dpjEntries = entries
          .where((e) => e.entityType == AuditEntityType.aiAssistant)
          .toList();
      final actions = dpjEntries.map((e) => e.action).toSet();
      expect(actions, containsAll([
        AuditAction.created,
        AuditAction.edited,
        AuditAction.approved,
      ]));
    });

    test('rejected review terminates pipeline without creating document',
        () async {
      final service = _makeService();

      final jobResult = await service.startProcessing('ATT-2026-0004');
      final pipelineResult = await service.runPipeline(jobResult.data!);

      final reviewResult = await service.submitReview(
        pipelineResult.data!,
        ReviewDecision.reject(
          reviewedBy: 'bob',
          note: 'Wrong document',
        ),
      );

      expect(reviewResult.isSuccess, isTrue);
      expect(reviewResult.data!.step, ProcessingStep.reviewRejected);
      expect(reviewResult.data!.step.isTerminal, isTrue);

      // Attempting to create after rejection must fail
      final createResult = await service.createFinancialDocument(
        reviewResult.data!,
        createDocument: (_, _) async => AppResult.success('SHOULD-NOT-EXIST'),
      );
      expect(createResult.isSuccess, isFalse);
    });

    test('fetchPendingReview returns only awaitingReview jobs', () async {
      // Use a fresh repo with no seed — create jobs manually
      final freshRepo = MockDocumentProcessingRepository();
      // Clear seeded jobs by fetching and approving them all
      final seeded = (await freshRepo.fetchPendingReview()).data!;
      for (final j in seeded) {
        await freshRepo.updateJob(j.copyWith(step: ProcessingStep.completed));
      }

      final freshService = _makeService(repo: freshRepo);
      final j1 = await freshService.startProcessing('ATT-001');
      await freshService.startProcessing('ATT-002');

      await freshService.runPipeline(j1.data!);
      // j2 stays at uploaded

      final pending = await freshRepo.fetchPendingReview();
      expect(pending.isSuccess, isTrue);
      expect(pending.data!.length, 1);
      expect(pending.data!.first.attachmentId, 'ATT-001');
    });
  });
}
