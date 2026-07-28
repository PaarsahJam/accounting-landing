import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/ocr/data/ocr_repository.dart';
import 'package:accounting_app/features/attachments/ocr/providers/ocr_providers.dart';
import 'package:accounting_app/features/attachments/ocr/services/ocr_pipeline.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/document_processing/data/document_processing_repository.dart';
import 'package:accounting_app/features/document_processing/data/document_processing_repository_provider.dart';
import 'package:accounting_app/features/attachments/ocr/domain/document_classification.dart';
import 'package:accounting_app/features/document_processing/domain/document_processing_job.dart';
import 'package:accounting_app/features/document_processing/domain/review_decision.dart';
import 'package:accounting_app/features/document_processing/presentation/document_processing_queue_page.dart';
import 'package:accounting_app/features/document_processing/presentation/document_review_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// ─── Helpers ─────────────────────────────────────────────────────────────────

Widget _wrap(
  Widget child, {
  MockDocumentProcessingRepository? repo,
  MockAuditTrailRepository? audit,
}) {
  final processingRepo = repo ?? MockDocumentProcessingRepository();
  final auditRepo = audit ?? MockAuditTrailRepository();
  final attachmentsRepo = MockAttachmentsRepository(auditRepository: auditRepo);
  final ocrRepo = MockOcrRepository(attachmentsRepository: attachmentsRepo);
  final pipeline = OcrPipeline(repository: ocrRepo);

  return ProviderScope(
    overrides: [
      documentProcessingRepositoryProvider.overrideWithValue(processingRepo),
      auditTrailRepositoryProvider.overrideWithValue(auditRepo),
      ocrRepositoryProvider.overrideWithValue(ocrRepo),
      ocrPipelineProvider.overrideWithValue(pipeline),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    ),
  );
}

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  group('DocumentProcessingQueuePage', () {
    testWidgets('shows job cards after data loads', (tester) async {
      await tester.pumpWidget(_wrap(const DocumentProcessingQueuePage()));
      await tester.pumpAndSettle();

      // Seeded repo has 2 awaitingReview jobs
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('shows attachment IDs in job cards', (tester) async {
      await tester.pumpWidget(_wrap(const DocumentProcessingQueuePage()));
      await tester.pumpAndSettle();

      expect(find.text('ATT-2026-0004'), findsOneWidget);
      expect(find.text('ATT-2026-0003'), findsOneWidget);
    });

    testWidgets('shows empty state when queue is empty', (tester) async {
      // Use a fresh repo with no seeded data and manually clear it
      final emptyRepo = _EmptyMockRepo();
      await tester.pumpWidget(_wrap(
        const DocumentProcessingQueuePage(),
        repo: emptyRepo,
      ));
      await tester.pumpAndSettle();

      expect(find.text('Queue is clear'), findsOneWidget);
    });

    testWidgets('shows page title', (tester) async {
      await tester.pumpWidget(_wrap(const DocumentProcessingQueuePage()));
      await tester.pumpAndSettle();

      expect(find.text('Document Processing Queue'), findsOneWidget);
    });
  });

  group('DocumentReviewPage', () {
    DocumentProcessingJob awaitingJob() => DocumentProcessingJob(
          id: 'DPJ-TEST-001',
          attachmentId: 'ATT-2026-0004',
          step: ProcessingStep.awaitingReview,
          createdAt: DateTime(2026, 2, 10),
          updatedAt: DateTime(2026, 2, 10),
          classification: const DocumentClassification(
            documentType: DocumentType.vendorBill,
            confidence: 0.92,
          ),
        );

    testWidgets('shows job id and attachment id', (tester) async {
      await tester.pumpWidget(_wrap(DocumentReviewPage(job: awaitingJob())));
      await tester.pumpAndSettle();

      expect(find.text('DPJ-TEST-001'), findsOneWidget);
      expect(find.text('ATT-2026-0004'), findsOneWidget);
    });

    testWidgets('shows Approve and Reject buttons for awaitingReview job',
        (tester) async {
      await tester.pumpWidget(_wrap(DocumentReviewPage(job: awaitingJob())));
      await tester.pumpAndSettle();

      expect(find.text('Approve'), findsOneWidget);
      expect(find.text('Reject'), findsOneWidget);
    });

    testWidgets('does not show action buttons for completed job',
        (tester) async {
      final completedJob = DocumentProcessingJob(
        id: 'DPJ-TEST-002',
        attachmentId: 'ATT-2026-0001',
        step: ProcessingStep.completed,
        createdAt: DateTime(2026, 2, 9),
        updatedAt: DateTime(2026, 2, 9),
      );

      await tester.pumpWidget(_wrap(DocumentReviewPage(job: completedJob)));
      await tester.pumpAndSettle();

      expect(find.text('Approve'), findsNothing);
      expect(find.text('Reject'), findsNothing);
    });

    testWidgets('shows review decision section for rejected job',
        (tester) async {
      final rejectedJob = DocumentProcessingJob(
        id: 'DPJ-TEST-003',
        attachmentId: 'ATT-2026-0005',
        step: ProcessingStep.reviewRejected,
        createdAt: DateTime(2026, 2, 8),
        updatedAt: DateTime(2026, 2, 8),
        reviewDecision: ReviewDecision.reject(
          reviewedBy: 'alice',
          note: 'Duplicate bill',
        ),
      );

      await tester.pumpWidget(_wrap(DocumentReviewPage(job: rejectedJob)));
      await tester.pumpAndSettle();

      expect(find.text('Review decision'), findsOneWidget);
      expect(find.text('alice'), findsOneWidget);
    });

    testWidgets('tapping Reject opens dialog', (tester) async {
      await tester.pumpWidget(_wrap(DocumentReviewPage(job: awaitingJob())));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reject'));
      await tester.pumpAndSettle();

      expect(find.text('Reject document'), findsOneWidget);
      expect(find.text('Reason for rejection'), findsOneWidget);
    });

    testWidgets('reject dialog Cancel dismisses without action', (tester) async {
      await tester.pumpWidget(_wrap(DocumentReviewPage(job: awaitingJob())));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reject'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Dialog dismissed, still on review page
      expect(find.text('Document Review'), findsOneWidget);
      expect(find.text('Reject document'), findsNothing);
    });
  });
}

// ─── Test doubles ─────────────────────────────────────────────────────────────

class _EmptyMockRepo extends MockDocumentProcessingRepository {
  @override
  Future<AppResult<List<DocumentProcessingJob>>> fetchPendingReview() async {
    return AppResult.success(const []);
  }
}
