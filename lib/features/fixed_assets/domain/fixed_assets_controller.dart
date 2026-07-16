// lib/features/fixed_assets/domain/fixed_assets_controller.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/fixed_assets_repository_provider.dart';
import 'fixed_asset.dart';

part 'fixed_assets_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Assets list controller
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class FixedAssetsController extends _$FixedAssetsController {
  @override
  FutureOr<List<FixedAsset>> build() async {
    final repo = ref.watch(fixedAssetsRepositoryProvider);
    final result = await repo.fetchAssets();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load fixed assets', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<FixedAsset>?> createAsset(FixedAsset asset) async {
    try {
      final repo = ref.read(fixedAssetsRepositoryProvider);
      final result = await repo.createAsset(asset);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to create fixed asset', error: result.error);
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([...current, result.data!]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error creating fixed asset', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<AppResult<FixedAsset>?> updateAsset(FixedAsset asset) async {
    try {
      final repo = ref.read(fixedAssetsRepositoryProvider);
      final result = await repo.updateAsset(asset);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to update fixed asset', error: result.error);
        return result;
      }
      _replaceInState(result.data!);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error updating fixed asset', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> disposeAsset(String id) async {
    try {
      final repo = ref.read(fixedAssetsRepositoryProvider);
      final result = await repo.disposeAsset(id);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to dispose fixed asset', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error disposing fixed asset', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> calculateDepreciation(String id) async {
    try {
      final repo = ref.read(fixedAssetsRepositoryProvider);
      final result = await repo.calculateDepreciation(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to calculate depreciation',
          error: result.error,
        );
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error calculating depreciation',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void _replaceInState(FixedAsset updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((a) => a.id == updated.id ? updated : a).toList(),
    );
  }
}
