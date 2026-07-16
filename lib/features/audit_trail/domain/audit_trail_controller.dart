// lib/features/audit_trail/domain/audit_trail_controller.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/audit_trail_repository.dart';
import '../data/audit_trail_repository_provider.dart';
import 'audit_entry.dart';
import 'audit_entity_type.dart';
import 'audit_filter.dart';

part 'audit_trail_controller.g.dart';

/// Global audit trail — loads all entries, supports filtering.
@riverpod
class AuditTrailController extends _$AuditTrailController {
  late final AuditTrailRepository _repository;

  @override
  FutureOr<List<AuditEntry>> build() async {
    _repository = ref.watch(auditTrailRepositoryProvider);
    final result = await _repository.fetchEntries();
    if (result.isSuccess) {
      return result.data ?? const <AuditEntry>[];
    }
    AppLogger.warning('Failed to load audit trail', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  /// Returns entries matching [filter] from [entries].
  ///
  /// This is a pure utility — it does not read Riverpod state so it is
  /// safe to call from outside without worrying about the provider lifecycle.
  List<AuditEntry> applyFilter(List<AuditEntry> entries, AuditFilter filter) {
    if (filter.isEmpty) return entries;
    return entries.where(filter.matches).toList();
  }

  /// Appends a new [entry] and updates state.
  Future<void> addEntry(AuditEntry entry) async {
    final result = await _repository.addEntry(entry);
    if (!result.isSuccess) {
      AppLogger.warning('Failed to add audit entry', error: result.error);
      return;
    }
    if (!ref.mounted) return;
    final current = state.value ?? const <AuditEntry>[];
    state = AsyncValue.data([result.data!, ...current]);
  }

  Future<void> refresh() async {
    if (!ref.mounted) return;
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchEntries();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (!ref.mounted) return;
      state = AsyncValue.data(result.data ?? const <AuditEntry>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh audit trail', error: e);
      if (!ref.mounted) return;
      state = AsyncValue.error(e, st);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Per-entity scoped controller — shows the trail for one document/entity.
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class EntityAuditTrailController extends _$EntityAuditTrailController {
  late final AuditTrailRepository _repository;

  @override
  FutureOr<List<AuditEntry>> build(
    AuditEntityType entityType,
    String entityId,
  ) async {
    _repository = ref.watch(auditTrailRepositoryProvider);
    final result = await _repository.fetchEntriesForEntity(
      entityType,
      entityId,
    );
    if (result.isSuccess) {
      return result.data ?? const <AuditEntry>[];
    }
    AppLogger.warning(
      'Failed to load audit trail for $entityType/$entityId',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }
}
