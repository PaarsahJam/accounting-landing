import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/domain/attachment.dart';
import 'package:accounting_app/features/attachments/domain/attachment_file_type.dart';
import 'package:accounting_app/features/attachments/ocr/data/ocr_repository.dart';
import 'package:accounting_app/features/attachments/ocr/domain/document_classification.dart';
import 'package:accounting_app/features/attachments/ocr/domain/ocr_field.dart';
import 'package:accounting_app/features/attachments/ocr/domain/ocr_line_item.dart';
import 'package:accounting_app/features/attachments/ocr/domain/ocr_result.dart';
import 'package:accounting_app/features/attachments/ocr/services/ocr_mapper.dart';
import 'package:accounting_app/features/attachments/ocr/services/ocr_pipeline.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:flutter_test/flutter_test.dart';

// ─── Helpers ─────────────────────────────────────────────────────────────────

MockOcrRepository _makeRepo() => MockOcrRepository(
      attachmentsRepository:
          MockAttachmentsRepository(auditRepository: MockAuditTrailRepository()),
    );

Attachment _attachment({
  String id = 'ATT-TEST-001',
  String entityType = 'vendorBill',
  String entityId = 'VB-001',
  String filename = 'bill_scan.jpg',
  AttachmentFileType fileType = AttachmentFileType.image,
}) =>
    Attachment(
      id: id,
      entityType: entityType,
      entityId: entityId,
      filename: filename,
      fileType: fileType,
      fileSizeBytes: 512000,
      uploadedAt: DateTime(2026, 2, 5),
      uploadedBy: 'tester',
    );

OcrResult _makeResult({
  DocumentType type = DocumentType.vendorBill,
  List<OcrField> fields = const [],
  List<OcrLineItem> lineItems = const [],
}) =>
    OcrResult(
      attachmentId: 'ATT-001',
      status: OcrProcessingStatus.completed,
      classification: DocumentClassification(
        documentType: type,
        confidence: 0.92,
      ),
      fields: fields,
      rawText: 'raw',
      lineItems: lineItems,
      processingLog: const [],
      processedAt: DateTime(2026, 2, 5),
    );

// ─── Tests ───────────────────────────────────────────────────────────────────

void main() {
  // ─── Document Classification ────────────────────────────────────────────────

  group('MockOcrRepository.classifyDocument', () {
    late MockOcrRepository repo;
    setUp(() => repo = _makeRepo());

    test('vendorBill entity → DocumentType.vendorBill with high confidence',
        () async {
      final result = await repo.classifyDocument(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );
      expect(result.documentType, DocumentType.vendorBill);
      expect(result.confidence, greaterThanOrEqualTo(0.8));
      expect(result.isReliable, isTrue);
    });

    test('salesInvoice entity → DocumentType.invoice with high confidence',
        () async {
      final result = await repo.classifyDocument(
        _attachment(
          entityType: 'salesInvoice',
          filename: 'invoice_draft.pdf',
          fileType: AttachmentFileType.pdf,
        ),
      );
      expect(result.documentType, DocumentType.invoice);
      expect(result.confidence, greaterThanOrEqualTo(0.8));
    });

    test('image attachment with unknown entity → expenseReceipt', () async {
      final result = await repo.classifyDocument(
        _attachment(
          entityType: 'expense',
          filename: 'receipt.png',
          fileType: AttachmentFileType.image,
        ),
      );
      expect(result.documentType, DocumentType.expenseReceipt);
    });

    test('purchaseOrder entity → DocumentType.purchaseOrder', () async {
      final result = await repo.classifyDocument(
        _attachment(
          entityType: 'purchaseOrder',
          filename: 'purchase_order_001.pdf',
          fileType: AttachmentFileType.pdf,
        ),
      );
      expect(result.documentType, DocumentType.purchaseOrder);
      expect(result.confidence, greaterThanOrEqualTo(0.9));
    });

    test('alternatives list is populated for ambiguous documents', () async {
      final result = await repo.classifyDocument(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );
      expect(result.alternatives, isNotEmpty);
    });

    test('isAmbiguous is false when confidence is high', () async {
      final result = await repo.classifyDocument(
        _attachment(entityType: 'vendorBill'),
      );
      expect(result.isAmbiguous, isFalse);
    });
  });

  group('DocumentClassification helpers', () {
    test('isReliable true when confidence >= 0.8', () {
      const cls = DocumentClassification(
        documentType: DocumentType.invoice,
        confidence: 0.85,
      );
      expect(cls.isReliable, isTrue);
    });

    test('isReliable false when confidence < 0.8', () {
      const cls = DocumentClassification(
        documentType: DocumentType.other,
        confidence: 0.5,
      );
      expect(cls.isReliable, isFalse);
    });

    test('isAmbiguous true when confidence < 0.6 and multiple alternatives',
        () {
      const cls = DocumentClassification(
        documentType: DocumentType.other,
        confidence: 0.55,
        alternatives: [
          DocumentClassification(
              documentType: DocumentType.invoice, confidence: 0.50),
          DocumentClassification(
              documentType: DocumentType.vendorBill, confidence: 0.45),
        ],
      );
      expect(cls.isAmbiguous, isTrue);
    });

    test('DocumentType.targetEntityType maps correctly', () {
      expect(DocumentType.invoice.targetEntityType, 'salesInvoice');
      expect(DocumentType.vendorBill.targetEntityType, 'vendorBill');
      expect(DocumentType.purchaseOrder.targetEntityType, 'purchaseOrder');
      expect(DocumentType.contract.targetEntityType, isNull);
      expect(DocumentType.other.targetEntityType, isNull);
    });

    test('DocumentType.fromString returns other for unknown value', () {
      expect(DocumentType.fromString('nonexistent'), DocumentType.other);
    });
  });

  // ─── OCR Pipeline ───────────────────────────────────────────────────────────

  group('OcrPipeline.processAttachment', () {
    late OcrPipeline pipeline;
    setUp(() => pipeline = OcrPipeline(repository: _makeRepo()));

    test('returns completed status for vendorBill attachment', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );
      expect(result.status, OcrProcessingStatus.completed);
      expect(result.isSuccessful, isTrue);
    });

    test('extracts fields from vendorBill raw text', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );
      expect(result.fields, isNotEmpty);
      expect(result.fieldByType(OcrFieldType.vendorName), isNotNull);
      expect(result.fieldByType(OcrFieldType.totalAmount), isNotNull);
    });

    test('extracts line items from vendorBill', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );
      expect(result.hasLineItems, isTrue);
      expect(result.lineItems.first.lineNumber, 1);
    });

    test('processing log has entries for each pipeline step', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'vendorBill'),
      );
      final steps = result.processingLog.map((e) => e.step).toSet();
      expect(steps,
          containsAll(['init', 'classify', 'extract_raw_text', 'extract_fields', 'finalize']));
    });

    test('processedAt is set on success', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'salesInvoice', filename: 'invoice_draft.pdf'),
      );
      expect(result.processedAt, isNotNull);
    });

    test('rawText is non-empty on success', () async {
      final result = await pipeline.processAttachment(
        _attachment(entityType: 'salesInvoice', filename: 'invoice_draft.pdf'),
      );
      expect(result.rawText, isNotEmpty);
    });
  });

  // ─── OcrMapper ──────────────────────────────────────────────────────────────

  group('OcrMapper', () {
    const mapper = OcrMapper();

    test('mapClassification reflects documentType and confidence', () {
      final result = _makeResult(type: DocumentType.invoice);
      final cls = mapper.mapClassification(result);
      expect(cls.documentType, DocumentType.invoice);
      expect(cls.confidence, 0.92);
      expect(cls.isReliable, isTrue);
    });

    test('mapClassification counts reliable fields correctly', () {
      final result = _makeResult(
        fields: [
          const OcrField(
              type: OcrFieldType.vendorName, value: 'ACME', confidence: 0.95),
          const OcrField(
              type: OcrFieldType.totalAmount, value: '715.00', confidence: 0.4),
        ],
      );
      final cls = mapper.mapClassification(result);
      expect(cls.totalFields, 2);
      expect(cls.detectedFields, 1);
    });

    test('mapToDraftVendorBill maps vendor name and total', () {
      final result = _makeResult(
        type: DocumentType.vendorBill,
        fields: [
          const OcrField(
              type: OcrFieldType.vendorName,
              value: 'ACME Supplies',
              confidence: 0.9),
          const OcrField(
              type: OcrFieldType.totalAmount,
              value: '715.00',
              confidence: 0.92),
          const OcrField(
              type: OcrFieldType.documentDate,
              value: '2026-02-15',
              confidence: 0.88),
        ],
      );
      final draft = mapper.mapToDraftVendorBill(result);
      expect(draft['vendorName'], 'ACME Supplies');
      expect(draft['total'], 715.0);
      expect(draft['billDate'], DateTime(2026, 2, 15));
    });

    test('mapToDraftInvoice maps customer name and line items', () {
      final result = _makeResult(
        type: DocumentType.invoice,
        fields: [
          const OcrField(
              type: OcrFieldType.customerName,
              value: 'TechCorp',
              confidence: 0.9),
          const OcrField(
              type: OcrFieldType.invoiceNumber,
              value: 'INV-001',
              confidence: 0.95),
        ],
        lineItems: [
          const OcrLineItem(
            lineNumber: 1,
            description: 'Consulting',
            quantity: 10,
            unitPrice: 250.0,
            amount: 2500.0,
          ),
        ],
      );
      final draft = mapper.mapToDraftInvoice(result);
      expect(draft['customerName'], 'TechCorp');
      expect(draft['reference'], 'INV-001');
      expect((draft['lines'] as List).length, 1);
      expect((draft['lines'] as List).first['amount'], 2500.0);
    });

    test('mapToDraftExpense maps merchant and amount', () {
      final result = _makeResult(
        type: DocumentType.expenseReceipt,
        fields: [
          const OcrField(
              type: OcrFieldType.merchantName,
              value: 'WeWork',
              confidence: 0.9),
          const OcrField(
              type: OcrFieldType.totalAmount,
              value: '2000.00',
              confidence: 0.85),
        ],
      );
      final draft = mapper.mapToDraftExpense(result);
      expect(draft['merchant'], 'WeWork');
      expect(draft['amount'], 2000.0);
    });

    test('mapToDraft returns null for unsupported document types', () {
      final result = _makeResult(type: DocumentType.contract);
      expect(mapper.mapToDraft(DocumentType.contract, result), isNull);
      expect(mapper.mapToDraft(DocumentType.other, result), isNull);
    });

    test('mapToDraft dispatches to correct mapper by type', () {
      final invoiceResult = _makeResult(
        type: DocumentType.invoice,
        fields: [
          const OcrField(
              type: OcrFieldType.customerName, value: 'Corp', confidence: 0.9),
        ],
      );
      final billResult = _makeResult(
        type: DocumentType.vendorBill,
        fields: [
          const OcrField(
              type: OcrFieldType.vendorName, value: 'Vendor', confidence: 0.9),
        ],
      );
      expect(
          mapper.mapToDraft(DocumentType.invoice, invoiceResult)!['customerName'],
          'Corp');
      expect(
          mapper.mapToDraft(DocumentType.vendorBill, billResult)!['vendorName'],
          'Vendor');
    });
  });

  // ─── Full pipeline integration ───────────────────────────────────────────────

  group('OcrPipeline + OcrMapper integration', () {
    test('vendorBill attachment produces a mappable draft', () async {
      final pipeline = OcrPipeline(repository: _makeRepo());
      const mapper = OcrMapper();

      final result = await pipeline.processAttachment(
        _attachment(entityType: 'vendorBill', filename: 'bill_scan.jpg'),
      );

      expect(result.isSuccessful, isTrue);
      final draft = mapper.mapToDraft(result.classification.documentType, result);
      expect(draft, isNotNull);
      expect(draft!['vendorName'], isNotEmpty);
      expect(draft['total'], isA<double>());
    });

    test('salesInvoice attachment produces a mappable invoice draft', () async {
      final pipeline = OcrPipeline(repository: _makeRepo());
      const mapper = OcrMapper();

      final result = await pipeline.processAttachment(
        _attachment(
          entityType: 'salesInvoice',
          filename: 'invoice_draft.pdf',
          fileType: AttachmentFileType.pdf,
        ),
      );

      expect(result.isSuccessful, isTrue);
      final draft = mapper.mapToDraft(result.classification.documentType, result);
      expect(draft, isNotNull);
      expect(draft!['customerName'], isNotEmpty);
    });
  });
}
