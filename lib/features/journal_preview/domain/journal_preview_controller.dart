import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/journal_preview_repository.dart';
import '../data/journal_preview_repository_provider.dart';
import 'journal_preview.dart';

part 'journal_preview_controller.g.dart';

@riverpod
class JournalPreviewController extends _$JournalPreviewController {
  late final JournalPreviewRepository _repository;

  @override
  FutureOr<JournalPreview?> build(
    String documentType,
    String documentId,
  ) async {
    _repository = ref.watch(journalPreviewRepositoryProvider);
    return loadPreview(documentType, documentId);
  }

  Future<JournalPreview?> loadPreview(
    String documentType,
    String documentId,
  ) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchJournalPreview(
        documentType,
        documentId,
      );
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final preview = result.data;
      if (ref.mounted) {
        state = AsyncValue.data(preview);
      }
      return preview;
    } catch (e, st) {
      AppLogger.warning('Failed to load journal preview', error: e);
      if (ref.mounted) {
        state = AsyncValue.error(e, st);
      }
      return null;
    }
  }
}
