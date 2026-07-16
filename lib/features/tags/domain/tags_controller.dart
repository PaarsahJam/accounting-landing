import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/tags_repository_provider.dart';
import 'tag.dart';

part 'tags_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Params for the entity-scoped family provider
// ─────────────────────────────────────────────────────────────────────────────

class EntityTagsParams {
  const EntityTagsParams({required this.entityType, required this.entityId});

  final String entityType;
  final String entityId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityTagsParams &&
          entityType == other.entityType &&
          entityId == other.entityId;

  @override
  int get hashCode => Object.hash(entityType, entityId);
}

// ─────────────────────────────────────────────────────────────────────────────
// Global tags controller — manages all tags (CRUD)
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class TagsController extends _$TagsController {
  @override
  FutureOr<List<Tag>> build() async {
    final repo = ref.watch(tagsRepositoryProvider);
    final result = await repo.fetchTags();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load tags', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<Tag>?> createTag(Tag tag) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.createTag(tag);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to create tag', error: result.error);
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([...current, result.data!]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error creating tag', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> renameTag(String id, String newName) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.renameTag(id, newName);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to rename tag', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error renaming tag', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> changeColor(String id, String newColor) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.changeColor(id, newColor);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to change tag color', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error changing tag color', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteTag(String id) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.deleteTag(id);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to delete tag', error: result.error);
        return false;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data(current.where((t) => t.id != id).toList());
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error deleting tag', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void _replaceInState(Tag updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((t) => t.id == updated.id ? updated : t).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Entity-scoped tags controller — manages tags for one entity
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class EntityTagsController extends _$EntityTagsController {
  @override
  FutureOr<List<Tag>> build(EntityTagsParams params) async {
    final repo = ref.watch(tagsRepositoryProvider);
    final result = await repo.fetchTagsForEntity(
      entityType: params.entityType,
      entityId: params.entityId,
    );
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load entity tags', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<bool> assignTag(String tagId) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.assignTag(
        entityType: params.entityType,
        entityId: params.entityId,
        tagId: tagId,
      );
      if (!result.isSuccess) {
        AppLogger.warning('Failed to assign tag', error: result.error);
        return false;
      }
      // Reload to pick up the newly assigned tag
      ref.invalidateSelf();
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error assigning tag', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> removeTag(String tagId) async {
    try {
      final repo = ref.read(tagsRepositoryProvider);
      final result = await repo.removeTagFromEntity(
        entityType: params.entityType,
        entityId: params.entityId,
        tagId: tagId,
      );
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to remove tag from entity',
          error: result.error,
        );
        return false;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data(current.where((t) => t.id != tagId).toList());
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error removing tag from entity', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}
