import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../attachments/data/attachments_repository.dart';
import '../../../attachments/domain/attachment.dart';
import '../../../attachments/domain/attachment_file_type.dart';
import '../domain/document_classification.dart';
import '../domain/ocr_field.dart';
import '../domain/ocr_line_item.dart';
import 'ocr_repository.dart';

class RealOcrRepository implements OcrRepository {
  RealOcrRepository({
    required AttachmentsRepository attachmentsRepository,
  }) : _attachmentsRepository = attachmentsRepository;

  final AttachmentsRepository _attachmentsRepository;

  @override
  Future<Attachment> fetchAttachment(String attachmentId) async {
    final result = await _attachmentsRepository.getAttachment(attachmentId);
    if (!result.isSuccess || result.data == null) {
      throw Exception(
        result.error?.message ?? 'Failed to fetch attachment',
      );
    }
    return result.data!;
  }

  @override
  Future<DocumentClassification> classifyDocument(
    Attachment attachment,
  ) async {
    final bytes = await _downloadBytes(attachment.id);
    final rawText = await _recognizeText(bytes, attachment.fileType);
    final fields = await extractFields(rawText);
    return _classifyFromFields(fields, rawText);
  }

  @override
  Future<String> extractRawText(Attachment attachment) async {
    final bytes = await _downloadBytes(attachment.id);
    return _recognizeText(bytes, attachment.fileType);
  }

  @override
  Future<List<OcrField>> extractFields(String rawText) async {
    final fields = <OcrField>[];
    final lines = rawText.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (!trimmed.contains(':') || trimmed.split(':').length < 2) continue;
      final colonIdx = trimmed.indexOf(':');
      final key = trimmed.substring(0, colonIdx).trim().toLowerCase();
      final value = trimmed.substring(colonIdx + 1).trim();
      final fieldType = _mapKeyToFieldType(key);
      if (fieldType != null) {
        fields.add(OcrField(
          type: fieldType,
          value: value,
          confidence: 0.85,
        ));
      }
    }
    return fields;
  }

  @override
  Future<List<OcrLineItem>> extractLineItems(String rawText) async {
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
      if (trimmed.startsWith('Subtotal:') ||
          trimmed.startsWith('Total:') ||
          trimmed.startsWith('Tax')) {
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

  Future<Uint8List> _downloadBytes(String attachmentId) async {
    final result =
        await _attachmentsRepository.downloadAttachment(attachmentId);
    if (!result.isSuccess || result.data == null) {
      return Uint8List(0);
    }
    return result.data!;
  }

  Future<String> _recognizeText(
    Uint8List imageBytes,
    AttachmentFileType fileType,
  ) async {
    if (!kReleaseMode) {
      return _mockOcr(imageBytes);
    }
    try {
      return await _mlKitTextRecognition(imageBytes);
    } catch (e) {
      debugPrint('ML Kit OCR failed, falling back to mock: $e');
      return _mockOcr(imageBytes);
    }
  }

  Future<String> _mlKitTextRecognition(Uint8List imageBytes) async {
    final InputImage inputImage = InputImage.fromBytes(
      bytes: imageBytes,
      metadata: InputImageMetadata(
        size: const Size(0, 0),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.bgra8888,
        bytesPerRow: 0,
      ),
    );
    final textRecognizer = TextRecognizer();
    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } finally {
      textRecognizer.close();
    }
  }

  String _mockOcr(Uint8List bytes) {
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

  DocumentClassification _classifyFromFields(
    List<OcrField> fields,
    String rawText,
  ) {
    final textLower = rawText.toLowerCase();
    if (textLower.contains('vendor') ||
        textLower.contains('supplier') ||
        textLower.contains('bill #') ||
        fields.any((f) => f.type == OcrFieldType.vendorName)) {
      return const DocumentClassification(
        documentType: DocumentType.vendorBill,
        confidence: 0.85,
      );
    }
    if (textLower.contains('customer') ||
        textLower.contains('invoice #') ||
        textLower.contains('client') ||
        fields.any((f) => f.type == OcrFieldType.customerName)) {
      return const DocumentClassification(
        documentType: DocumentType.invoice,
        confidence: 0.85,
      );
    }
    if (textLower.contains('receipt') ||
        textLower.contains('merchant') ||
        textLower.contains('expense')) {
      return const DocumentClassification(
        documentType: DocumentType.expenseReceipt,
        confidence: 0.75,
      );
    }
    if (textLower.contains('purchase order') || textLower.contains('po #')) {
      return const DocumentClassification(
        documentType: DocumentType.purchaseOrder,
        confidence: 0.85,
      );
    }
    return const DocumentClassification(
      documentType: DocumentType.other,
      confidence: 0.50,
    );
  }

  OcrFieldType? _mapKeyToFieldType(String key) {
    if (key == 'customer' || key == 'customer name') {
      return OcrFieldType.customerName;
    }
    if (key == 'vendor' || key == 'vendor name' || key == 'supplier') {
      return OcrFieldType.vendorName;
    }
    if (key == 'merchant' || key == 'merchant name') {
      return OcrFieldType.merchantName;
    }
    if (key == 'invoice #' ||
        key == 'invoice number' ||
        key == 'bill #' ||
        key == 'bill number') {
      return OcrFieldType.invoiceNumber;
    }
    if (key == 'po #' ||
        key == 'purchase order #' ||
        key == 'purchase order number') {
      return OcrFieldType.purchaseOrderNumber;
    }
    if (key == 'date' || key == 'document date') {
      return OcrFieldType.documentDate;
    }
    if (key == 'due' || key == 'due date') {
      return OcrFieldType.dueDate;
    }
    if (key == 'total' || key == 'total amount') {
      return OcrFieldType.totalAmount;
    }
    if (key == 'subtotal') {
      return OcrFieldType.subtotal;
    }
    if (key == 'tax' ||
        key == 'tax amount' ||
        key == 'vat' ||
        key == 'vat amount') {
      return OcrFieldType.taxAmount;
    }
    if (key == 'description' || key == 'category') {
      return OcrFieldType.description;
    }
    return null;
  }
}
