import 'dart:async';

import '../../domain/attachment.dart';
import '../data/ocr_repository.dart';
import '../domain/document_classification.dart';
import '../domain/ocr_field.dart';
import '../domain/ocr_line_item.dart';
import '../domain/ocr_result.dart';
import '../domain/processing_log_entry.dart';

class OcrPipeline {
  OcrPipeline({
    required OcrRepository repository,
  }) : _repo = repository;

  final OcrRepository _repo;

  Future<OcrResult> processAttachment(Attachment attachment) async {
    final log = <ProcessingLogEntry>[];
    final startedAt = DateTime.now();

    void logInfo(String step, String message, {Map<String, dynamic>? details}) {
      log.add(ProcessingLogEntry(
        timestamp: DateTime.now(),
        step: step,
        message: message,
        details: details,
      ));
    }

    void logWarning(String step, String message, {Map<String, dynamic>? details}) {
      log.add(ProcessingLogEntry(
        timestamp: DateTime.now(),
        step: step,
        message: message,
        severity: ProcessingLogSeverity.warning,
        details: details,
      ));
    }

    void logError(String step, String message, {Map<String, dynamic>? details}) {
      log.add(ProcessingLogEntry(
        timestamp: DateTime.now(),
        step: step,
        message: message,
        severity: ProcessingLogSeverity.error,
        details: details,
      ));
    }

    logInfo('init',
      'Starting OCR pipeline for attachment ${attachment.id} '
      '(${attachment.filename}, ${attachment.fileType.label})',
      details: {
        'entityType': attachment.entityType,
        'entityId': attachment.entityId,
        'fileSizeBytes': attachment.fileSizeBytes,
      },
    );

    DocumentClassification classification;
    try {
      classification = await _repo.classifyDocument(attachment);
      logInfo('classify',
        'Document classified as ${classification.documentType.label} '
        '(confidence: ${(classification.confidence * 100).toStringAsFixed(0)}%)',
        details: {
          'documentType': classification.documentType.name,
          'confidence': classification.confidence,
          'alternatives': classification.alternatives
              .map((a) => '${a.documentType.name} (${a.confidence})')
              .toList(),
        },
      );
      if (!classification.isReliable) {
        logWarning('classify',
          'Low classification confidence (${(classification.confidence * 100).toStringAsFixed(0)}%)',
        );
      }
      if (classification.isAmbiguous) {
        logWarning('classify',
          'Ambiguous classification — ${classification.alternatives.length} alternatives',
        );
      }
    } catch (e) {
      logError('classify', 'Classification failed: $e');
      return OcrResult(
        attachmentId: attachment.id,
        status: OcrProcessingStatus.failed,
        classification: const DocumentClassification(
          documentType: DocumentType.other, confidence: 0,
        ),
        fields: [],
        rawText: '',
        processingLog: log,
        errorMessage: 'Classification failed: $e',
      );
    }

    String rawText;
    try {
      rawText = await _repo.extractRawText(attachment);
      logInfo('extract_raw_text',
        'Extracted ${rawText.length} characters of raw text',
        details: {'charCount': rawText.length},
      );
    } catch (e) {
      logError('extract_raw_text', 'Text extraction failed: $e');
      return OcrResult(
        attachmentId: attachment.id,
        status: OcrProcessingStatus.failed,
        classification: classification,
        fields: [],
        rawText: '',
        processingLog: log,
        errorMessage: 'Text extraction failed: $e',
      );
    }

    List<OcrField> fields;
    try {
      fields = await _repo.extractFields(rawText);
      logInfo('extract_fields',
        'Extracted ${fields.length} structured fields',
        details: {
          'fieldCount': fields.length,
          'reliableFields': fields.where((f) => f.isReliable).length,
          'fieldTypes': fields.map((f) => f.type.name).toList(),
        },
      );
    } catch (e) {
      logError('extract_fields', 'Field extraction failed: $e');
      return OcrResult(
        attachmentId: attachment.id,
        status: OcrProcessingStatus.failed,
        classification: classification,
        fields: [],
        rawText: rawText,
        processingLog: log,
        errorMessage: 'Field extraction failed: $e',
      );
    }

    List<OcrLineItem> lineItems;
    try {
      lineItems = await _repo.extractLineItems(rawText);
      if (lineItems.isNotEmpty) {
        logInfo('extract_line_items',
          'Extracted ${lineItems.length} line items',
          details: {
            'lineCount': lineItems.length,
            'reliableItems': lineItems.where((i) => i.isReliable).length,
          },
        );
      } else {
        logInfo('extract_line_items',
          'No line items found in document',
        );
      }
    } catch (e) {
      logError('extract_line_items', 'Line item extraction failed: $e');
      lineItems = [];
    }

    final completedAt = DateTime.now();
    final duration = completedAt.difference(startedAt);
    logInfo('finalize',
      'Pipeline completed in ${duration.inMilliseconds}ms',
      details: {
        'durationMs': duration.inMilliseconds,
        'totalLogEntries': log.length + 1,
      },
    );

    return OcrResult(
      attachmentId: attachment.id,
      status: OcrProcessingStatus.completed,
      classification: classification,
      fields: fields,
      rawText: rawText,
      lineItems: lineItems,
      processingLog: log,
      processedAt: completedAt,
    );
  }
}
