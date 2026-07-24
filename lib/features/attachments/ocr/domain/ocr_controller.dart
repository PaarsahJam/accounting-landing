import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/logging/app_logger.dart';
import '../data/ocr_repository.dart';
import '../services/ocr_pipeline.dart';
import 'ocr_result.dart';

/// Drives the OCR pipeline for a single attachment.
///
/// State transitions: idle (null) → loading → data(result) | error.
/// Registered via [ocrControllerProvider] in ocr_providers.dart.
class OcrController extends StateNotifier<AsyncValue<OcrResult?>> {
  OcrController(this._attachmentId, this._repo, this._pipeline)
      : super(const AsyncValue.data(null));

  final String _attachmentId;
  final OcrRepository _repo;
  final OcrPipeline _pipeline;

  Future<void> runOcr() async {
    state = const AsyncValue.loading();
    try {
      final attachment = await _repo.fetchAttachment(_attachmentId);
      final result = await _pipeline.processAttachment(attachment);
      AppLogger.info(
        'OCR completed for $_attachmentId: '
        '${result.classification.documentType.label} '
        '(${result.fields.length} fields, ${result.lineItems.length} lines)',
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      AppLogger.warning('OCR failed for $_attachmentId', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
