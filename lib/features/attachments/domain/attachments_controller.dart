import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/attachments_repository_provider.dart';
import '../domain/attachment.dart';

part 'attachments_controller.g.dart';

/// Parameters that identify the owning entity.
class AttachmentsParams {
  const AttachmentsParams({required this.entityType, required this.entityId});

  final String entityType;
  final String entityId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentsParams &&
          entityType == other.entityType &&
          entityId == other.entityId;

  @override
  int get hashCode => Object.hash(entityType, entityId);
}

@riverpod
class AttachmentsController extends _$AttachmentsController {
  @override
  FutureOr<List<Attachment>> build(AttachmentsParams params) async {
    final repo = ref.watch(attachmentsRepositoryProvider);
    final result = await repo.fetchAttachments(
      entityType: params.entityType,
      entityId: params.entityId,
    );
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load attachments', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<Attachment>?> addAttachment(Attachment attachment) async {
    try {
      final repo = ref.read(attachmentsRepositoryProvider);
      final result = await repo.addAttachment(attachment);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to add attachment', error: result.error);
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([result.data!, ...current]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error adding attachment', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> removeAttachment(String id) async {
    try {
      final repo = ref.read(attachmentsRepositoryProvider);
      final result = await repo.removeAttachment(id);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to remove attachment', error: result.error);
        return false;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data(current.where((a) => a.id != id).toList());
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error removing attachment', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> renameAttachment(String id, String newFilename) async {
    try {
      final repo = ref.read(attachmentsRepositoryProvider);
      final result = await repo.renameAttachment(id, newFilename);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to rename attachment', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error renaming attachment', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> updateNotes(String id, String notes) async {
    try {
      final repo = ref.read(attachmentsRepositoryProvider);
      final result = await repo.updateNotes(id, notes);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to update notes', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error updating notes', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(attachmentsRepositoryProvider);
      final result = await repo.fetchAttachments(
        entityType: params.entityType,
        entityId: params.entityId,
      );
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const []);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh attachments', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  void _replaceInState(Attachment updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((a) => a.id == updated.id ? updated : a).toList(),
    );
  }
}
