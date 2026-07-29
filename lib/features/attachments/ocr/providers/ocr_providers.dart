import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../attachments/data/attachments_repository_provider.dart';
import '../data/ocr_repository.dart';
import '../data/real_ocr_repository.dart';
import '../domain/ocr_controller.dart';
import '../domain/ocr_result.dart';
import '../services/ocr_mapper.dart';
import '../services/ocr_pipeline.dart';

export '../domain/ocr_controller.dart' show OcrController;

final ocrRepositoryProvider = Provider<OcrRepository>((ref) {
  final attachmentsRepo = ref.watch(attachmentsRepositoryProvider);
  if (kReleaseMode) {
    return RealOcrRepository(attachmentsRepository: attachmentsRepo);
  }
  return MockOcrRepository(attachmentsRepository: attachmentsRepo);
});

final ocrPipelineProvider = Provider<OcrPipeline>((ref) {
  return OcrPipeline(repository: ref.watch(ocrRepositoryProvider));
});

final ocrMapperProvider = Provider<OcrMapper>((ref) {
  return const OcrMapper();
});

/// Stateful controller — use [runOcr()] to trigger processing.
/// State is [AsyncValue<OcrResult?>]: starts as data(null) (idle).
final ocrControllerProvider = StateNotifierProvider.autoDispose
    .family<OcrController, AsyncValue<OcrResult?>, String>(
  (ref, attachmentId) => OcrController(
    attachmentId,
    ref.watch(ocrRepositoryProvider),
    ref.watch(ocrPipelineProvider),
  ),
);

/// Read-only pipeline result — use when you only need the result, not the trigger.
final ocrResultProvider =
    FutureProvider.family<OcrResult, String>((ref, attachmentId) async {
  final repo = ref.watch(ocrRepositoryProvider);
  final pipeline = ref.watch(ocrPipelineProvider);
  final attachment = await repo.fetchAttachment(attachmentId);
  return pipeline.processAttachment(attachment);
});
