import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../attachments/data/attachments_repository_provider.dart';
import '../../domain/attachment.dart';
import '../domain/ocr_result.dart';
import '../data/ocr_repository.dart';
import '../services/ocr_mapper.dart';
import '../services/ocr_pipeline.dart';

final ocrRepositoryProvider = Provider<OcrRepository>((ref) {
  return MockOcrRepository(
    attachmentsRepository: ref.watch(attachmentsRepositoryProvider),
  );
});

final ocrPipelineProvider = Provider<OcrPipeline>((ref) {
  return OcrPipeline(repository: ref.watch(ocrRepositoryProvider));
});

final ocrMapperProvider = Provider<OcrMapper>((ref) {
  return const OcrMapper();
});

final ocrResultProvider = FutureProvider.family<OcrResult, String>((ref, attachmentId) async {
  final repo = ref.watch(ocrRepositoryProvider);
  final pipeline = ref.watch(ocrPipelineProvider);
  final attachment = await repo.fetchAttachment(attachmentId);
  return pipeline.processAttachment(attachment);
});