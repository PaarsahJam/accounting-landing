import 'document_classification.dart';
import 'ocr_field.dart';
import 'ocr_line_item.dart';
import 'processing_log_entry.dart';

enum OcrProcessingStatus { pending, processing, completed, failed }

class OcrResult {
  const OcrResult({
    required this.attachmentId,
    required this.status,
    required this.classification,
    required this.fields,
    required this.rawText,
    required this.processingLog,
    this.lineItems = const [],
    this.processedAt,
    this.errorMessage,
  });

  final String attachmentId;
  final OcrProcessingStatus status;
  final DocumentClassification classification;
  final List<OcrField> fields;
  final String rawText;
  final List<OcrLineItem> lineItems;
  final List<ProcessingLogEntry> processingLog;
  final DateTime? processedAt;
  final String? errorMessage;

  bool get isSuccessful => status == OcrProcessingStatus.completed;
  bool get hasLineItems => lineItems.isNotEmpty;

  OcrField? fieldByType(OcrFieldType type) {
    try {
      return fields.firstWhere((f) => f.type == type);
    } catch (_) {
      return null;
    }
  }

  OcrResult copyWith({
    String? attachmentId,
    OcrProcessingStatus? status,
    DocumentClassification? classification,
    List<OcrField>? fields,
    String? rawText,
    List<OcrLineItem>? lineItems,
    List<ProcessingLogEntry>? processingLog,
    DateTime? processedAt,
    String? errorMessage,
  }) {
    return OcrResult(
      attachmentId: attachmentId ?? this.attachmentId,
      status: status ?? this.status,
      classification: classification ?? this.classification,
      fields: fields ?? this.fields,
      rawText: rawText ?? this.rawText,
      lineItems: lineItems ?? this.lineItems,
      processingLog: processingLog ?? this.processingLog,
      processedAt: processedAt ?? this.processedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
