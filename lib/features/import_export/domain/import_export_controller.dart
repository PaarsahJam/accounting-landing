// lib/features/import_export/domain/import_export_controller.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../../user_roles/domain/authorization.dart';
import '../../user_roles/domain/permission.dart';
import '../data/import_export_repository_provider.dart';
import 'import_export_job.dart';

part 'import_export_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Jobs list controller
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class ImportExportController extends _$ImportExportController {
  @override
  FutureOr<List<ImportExportJob>> build() async {
    final repo = ref.watch(importExportRepositoryProvider);
    final result = await repo.listJobs();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load import/export jobs', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<ImportExportJob>?> exportCsv(
    ExportEntityType entityType,
  ) async {
    final denied =
        ref.checkPermission(Permission.manageSettings, action: 'export data');
    if (denied != null) return AppResult.failure(denied);
    try {
      final repo = ref.read(importExportRepositoryProvider);
      final result = await repo.exportCsv(entityType);
      if (!result.isSuccess) {
        AppLogger.warning('Export failed', error: result.error);
        return result;
      }
      _prependJob(result.data!);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error during export', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<AppResult<ImportExportJob>?> importCsv(
    ExportEntityType entityType,
  ) async {
    final denied =
        ref.checkPermission(Permission.manageSettings, action: 'import data');
    if (denied != null) return AppResult.failure(denied);
    try {
      final repo = ref.read(importExportRepositoryProvider);
      final result = await repo.importCsv(entityType);
      if (!result.isSuccess) {
        AppLogger.warning('Import failed', error: result.error);
        return result;
      }
      _prependJob(result.data!);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error during import', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  void _prependJob(ImportExportJob job) {
    final current = state.value ?? const [];
    state = AsyncValue.data([job, ...current]);
  }
}
