import '../../../attachments/data/attachments_repository.dart';
import '../../../attachments/domain/attachment.dart';
import '../../../attachments/domain/attachment_file_type.dart';
import '../domain/document_classification.dart';
import '../domain/ocr_field.dart';
import '../domain/ocr_line_item.dart';

abstract class OcrRepository {
  Future<Attachment> fetchAttachment(String attachmentId);

  Future<DocumentClassification> classifyDocument(Attachment attachment);

  Future<String> extractRawText(Attachment attachment);

  Future<List<OcrField>> extractFields(String rawText);

  Future<List<OcrLineItem>> extractLineItems(String rawText);
}

class MockOcrRepository implements OcrRepository {
  MockOcrRepository({
    required AttachmentsRepository attachmentsRepository,
    this.classificationDelay = const Duration(milliseconds: 100),
    this.extractionDelay = const Duration(milliseconds: 150),
  });

  final Duration classificationDelay;
  final Duration extractionDelay;

  @override
  Future<Attachment> fetchAttachment(String attachmentId) async {
    // In a real implementation, this would query by ID
    // For mock, return a representative attachment based on the ID pattern
    if (attachmentId.startsWith('ATT-')) {
      return _mockAttachmentForId(attachmentId);
    }
    return Attachment(
      id: attachmentId,
      entityType: 'vendorBill',
      entityId: 'VB-2026-000001',
      filename: 'bill_scan.jpg',
      fileType: AttachmentFileType.image,
      fileSizeBytes: 512000,
      uploadedAt: DateTime.now(),
      uploadedBy: 'test',
    );
  }

  @override
  Future<DocumentClassification> classifyDocument(Attachment attachment) async {
    await Future<void>.delayed(classificationDelay);
    final ext = attachment.filename.contains('.')
        ? attachment.filename.split('.').last.toLowerCase()
        : '';

    if (attachment.entityType == 'vendorBill' || (ext == 'pdf' && _looksLikeBill(attachment.filename))) {
      return const DocumentClassification(
        documentType: DocumentType.vendorBill,
        confidence: 0.92,
        alternatives: [
          DocumentClassification(
            documentType: DocumentType.invoice, confidence: 0.35,
          ),
        ],
      );
    }
    if (attachment.entityType == 'salesInvoice' || _looksLikeInvoice(attachment.filename)) {
      return const DocumentClassification(
        documentType: DocumentType.invoice,
        confidence: 0.94,
        alternatives: [
          DocumentClassification(
            documentType: DocumentType.vendorBill, confidence: 0.30,
          ),
        ],
      );
    }
    if (ext == 'jpg' || ext == 'jpeg' || ext == 'png') {
      return const DocumentClassification(
        documentType: DocumentType.expenseReceipt,
        confidence: 0.78,
        alternatives: [
          DocumentClassification(
            documentType: DocumentType.invoice, confidence: 0.45,
          ),
        ],
      );
    }
    if (attachment.entityType == 'purchaseOrder') {
      return const DocumentClassification(
        documentType: DocumentType.purchaseOrder,
        confidence: 0.95,
      );
    }
    return const DocumentClassification(
      documentType: DocumentType.other,
      confidence: 0.50,
    );
  }

  @override
  Future<String> extractRawText(Attachment attachment) async {
    await Future<void>.delayed(extractionDelay);
    return _mockRawText(attachment);
  }

  @override
  Future<List<OcrField>> extractFields(String rawText) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return _parseFields(rawText);
  }

  @override
  Future<List<OcrLineItem>> extractLineItems(String rawText) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return _parseLineItems(rawText);
  }

  Attachment _mockAttachmentForId(String id) {
    if (id.contains('0003') || id.contains('0004') || id.contains('0005')) {
      // Vendor bill attachments
      return Attachment(
        id: id,
        entityType: 'vendorBill',
        entityId: 'VB-2026-000001',
        filename: id.contains('0004') ? 'bill_scan.jpg' : 'delivery_note.pdf',
        fileType: id.contains('0004') ? AttachmentFileType.image : AttachmentFileType.pdf,
        fileSizeBytes: id.contains('0004') ? 512000 : 92160,
        uploadedAt: DateTime(2026, 2, 5),
        uploadedBy: 'carol',
      );
    }
    if (id.contains('0001') || id.contains('0002')) {
      // Purchase order attachments
      return Attachment(
        id: id,
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        filename: id.contains('0001') ? 'purchase_order_001.pdf' : 'vendor_quote.xlsx',
        fileType: id.contains('0001') ? AttachmentFileType.pdf : AttachmentFileType.spreadsheet,
        fileSizeBytes: id.contains('0001') ? 245120 : 48640,
        uploadedAt: DateTime(2026, 1, 15),
        uploadedBy: 'alice',
      );
    }
    // Default to vendor bill
    return Attachment(
      id: id,
      entityType: 'vendorBill',
      entityId: 'VB-2026-000001',
      filename: 'bill_scan.jpg',
      fileType: AttachmentFileType.image,
      fileSizeBytes: 512000,
      uploadedAt: DateTime.now(),
      uploadedBy: 'test',
    );
  }

  bool _looksLikeBill(String filename) {
    final lower = filename.toLowerCase();
    return lower.contains('bill') || lower.contains('vendor') || lower.contains('supplier');
  }

  bool _looksLikeInvoice(String filename) {
    final lower = filename.toLowerCase();
    return lower.contains('invoice') || lower.contains('inv-');
  }

  String _mockRawText(Attachment attachment) {
    if (attachment.entityType == 'vendorBill') {
      return 'VENDOR BILL\n'
          'Vendor: ACME Supplies Ltd\n'
          'Bill #: BILL-2026-0042\n'
          'Date: 2026-02-15\n'
          'Due: 2026-03-17\n'
          'Item    Qty   Unit Price   Amount\n'
          'Paper   10    25.00        250.00\n'
          'Toner    5    80.00        400.00\n'
          'Subtotal: 650.00\n'
          'Tax (10%): 65.00\n'
          'Total: 715.00';
    }
    if (attachment.entityType == 'salesInvoice') {
      return 'INVOICE\n'
          'Customer: TechCorp Inc\n'
          'Invoice #: INV-2026-0081\n'
          'Date: 2026-02-01\n'
          'Due: 2026-03-03\n'
          'Item         Qty   Unit Price   Amount\n'
          'Consulting    40    250.00       10000.00\n'
          'Software       2    5000.00      10000.00\n'
          'Subtotal: 20000.00\n'
          'Tax (9%): 1800.00\n'
          'Total: 21800.00';
    }
    if (attachment.entityType == 'expense') {
      return 'EXPENSE RECEIPT\n'
          'Merchant: WeWork\n'
          'Date: 2026-02-03\n'
          'Amount: 2000.00\n'
          'Category: Rent\n'
          'Description: Office rent Feb 2026';
    }
    if (attachment.entityType == 'purchaseOrder') {
      return 'PURCHASE ORDER\n'
          'PO #: PO-2026-0012\n'
          'Vendor: OfficeMart\n'
          'Date: 2026-01-20\n'
          'Item       Qty   Unit Price   Amount\n'
          'Desk Chairs 5    350.00       1750.00\n'
          'Desk Lamps  8     45.00         360.00\n'
          'Total: 2110.00';
    }
    return 'Document Text\nNo structured data found.';
  }

  List<OcrField> _parseFields(String rawText) {
    final fields = <OcrField>[];
    final lines = rawText.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('Customer:')) {
        fields.add(OcrField(
          type: OcrFieldType.customerName,
          value: trimmed.substring(9).trim(),
          confidence: 0.90,
        ));
      } else if (trimmed.startsWith('Vendor:')) {
        fields.add(OcrField(
          type: OcrFieldType.vendorName,
          value: trimmed.substring(7).trim(),
          confidence: 0.90,
        ));
      } else if (trimmed.startsWith('Merchant:')) {
        fields.add(OcrField(
          type: OcrFieldType.merchantName,
          value: trimmed.substring(9).trim(),
          confidence: 0.90,
        ));
      } else if (trimmed.startsWith('Invoice #:') || trimmed.startsWith('Bill #:')) {
        fields.add(OcrField(
          type: OcrFieldType.invoiceNumber,
          value: trimmed.split(':').last.trim(),
          confidence: 0.95,
        ));
      } else if (trimmed.startsWith('PO #:')) {
        fields.add(OcrField(
          type: OcrFieldType.purchaseOrderNumber,
          value: trimmed.substring(5).trim(),
          confidence: 0.95,
        ));
      } else if (trimmed.startsWith('Date:') && !trimmed.startsWith('Due:')) {
        fields.add(OcrField(
          type: OcrFieldType.documentDate,
          value: trimmed.substring(5).trim(),
          confidence: 0.88,
        ));
      } else if (trimmed.startsWith('Due:')) {
        fields.add(OcrField(
          type: OcrFieldType.dueDate,
          value: trimmed.substring(4).trim(),
          confidence: 0.85,
        ));
      } else if (trimmed.startsWith('Total:')) {
        fields.add(OcrField(
          type: OcrFieldType.totalAmount,
          value: trimmed.substring(6).trim(),
          confidence: 0.92,
        ));
      } else if (trimmed.startsWith('Subtotal:')) {
        fields.add(OcrField(
          type: OcrFieldType.subtotal,
          value: trimmed.substring(9).trim(),
          confidence: 0.88,
        ));
      } else if (trimmed.startsWith('Amount:')) {
        fields.add(OcrField(
          type: OcrFieldType.totalAmount,
          value: trimmed.substring(7).trim(),
          confidence: 0.85,
        ));
      } else if (trimmed.startsWith('Tax')) {
        final parts = trimmed.split(':');
        if (parts.length == 2) {
          fields.add(OcrField(
            type: OcrFieldType.taxAmount,
            value: parts[1].trim(),
            confidence: 0.82,
          ));
        }
      } else if (trimmed.startsWith('Category:')) {
        fields.add(OcrField(
          type: OcrFieldType.description,
          value: trimmed.substring(9).trim(),
          confidence: 0.80,
        ));
      }
    }
    return fields;
  }

  List<OcrLineItem> _parseLineItems(String rawText) {
    final lines = rawText.split('\n');
    final items = <OcrLineItem>[];
    var itemSection = false;
    var lineNumber = 0;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('Item') && trimmed.contains('Qty')) {
        itemSection = true;
        continue;
      }
      if (!itemSection) continue;
      if (trimmed.isEmpty) continue;
      if (trimmed.startsWith('Subtotal:') || trimmed.startsWith('Total:') || trimmed.startsWith('Tax')) {
        continue;
      }

      final parts = trimmed.split(RegExp(r'\s{2,}'));
      if (parts.length >= 2) {
        lineNumber++;
        final description = parts[0];
        final rest = parts.sublist(1);
        double? qty;
        double? unitPrice;
        double? amount;

        if (rest.length >= 2) {
          qty = double.tryParse(rest[0]);
          unitPrice = double.tryParse(rest[1]);
        }
        if (rest.length >= 3) {
          amount = double.tryParse(rest[2]);
        } else if (qty != null && unitPrice != null) {
          amount = qty * unitPrice;
        }

        items.add(OcrLineItem(
          lineNumber: lineNumber,
          description: description,
          quantity: qty,
          unitPrice: unitPrice,
          amount: amount,
          confidence: 0.85,
        ));
      }
    }
    return items;
  }
}