// lib/features/document_numbering/domain/approval_workflow_controller.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/approval_workflow_repository.dart';
import '../data/approval_workflow_repository_provider.dart';
import '../document_record.dart';
import '../document_status.dart';

part 'approval_workflow_controller.g.dart';

@riverpod
class ApprovalWorkflowController extends _$ApprovalWorkflowController {
  late final ApprovalWorkflowRepository _repository;

  @override
  FutureOr<List<DocumentRecord>> build() async {
    _repository = ref.watch(approvalWorkflowRepositoryProvider);
    final result = await _repository.fetchDocuments();
    if (result.isSuccess) {
      return result.data ?? const <DocumentRecord>[];
    }
    AppLogger.warning('Failed to load documents', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  /// Attempts to transition document [id] to [target] status.
  ///
  /// Returns the updated [DocumentRecord] on success.
  Future<DocumentRecord> transitionDocument(
    String id,
    DocumentStatus target,
  ) async {
    final result = await _repository.transition(id, target);
    if (!result.isSuccess) {
      AppLogger.warning(
        'Failed to transition document $id to $target',
        error: result.error,
      );
      throw result.error ?? const UnknownFailure(message: 'Unknown error');
    }
    final updated = result.data!;
    if (!ref.mounted) return updated;
    final current = state.value ?? const <DocumentRecord>[];
    state = AsyncValue.data(
      current.map((doc) => doc.id == updated.id ? updated : doc).toList(),
    );
    return updated;
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchDocuments();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (!ref.mounted) return;
      state = AsyncValue.data(result.data ?? const <DocumentRecord>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh documents', error: e);
      if (!ref.mounted) return;
      state = AsyncValue.error(e, st);
    }
  }
}
