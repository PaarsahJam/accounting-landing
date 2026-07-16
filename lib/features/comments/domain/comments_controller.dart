import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/comments_repository_provider.dart';
import '../domain/comment.dart';

part 'comments_controller.g.dart';

/// Parameters that identify the owning entity for the comments provider family.
class CommentsParams {
  const CommentsParams({required this.entityType, required this.entityId});

  final String entityType;
  final String entityId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsParams &&
          entityType == other.entityType &&
          entityId == other.entityId;

  @override
  int get hashCode => Object.hash(entityType, entityId);
}

@riverpod
class CommentsController extends _$CommentsController {
  @override
  FutureOr<List<Comment>> build(CommentsParams params) async {
    final repo = ref.watch(commentsRepositoryProvider);
    final result = await repo.fetchComments(
      entityType: params.entityType,
      entityId: params.entityId,
    );
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load comments', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<Comment>?> addComment(Comment comment) async {
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final result = await repo.addComment(comment);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to add comment', error: result.error);
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([...current, result.data!]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error adding comment', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> editComment(String id, String newMessage) async {
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final result = await repo.editComment(id, newMessage);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to edit comment', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error editing comment', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteComment(String id) async {
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final result = await repo.deleteComment(id);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to delete comment', error: result.error);
        return false;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data(current.where((c) => c.id != id).toList());
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error deleting comment', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(commentsRepositoryProvider);
      final result = await repo.fetchComments(
        entityType: params.entityType,
        entityId: params.entityId,
      );
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const []);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh comments', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  void _replaceInState(Comment updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((c) => c.id == updated.id ? updated : c).toList(),
    );
  }
}
