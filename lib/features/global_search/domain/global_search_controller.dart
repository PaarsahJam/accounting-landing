import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../../../features/fiscal_periods/repository/fiscal_period_repository.dart';
import '../data/global_search_repository_provider.dart';
import '../domain/search_result.dart';

part 'global_search_controller.g.dart';

/// Holds the current search state: a list of [SearchResult] grouped results.
@riverpod
class GlobalSearchController extends _$GlobalSearchController {
  @override
  FutureOr<List<SearchResult>> build() async {
    return const [];
  }

  /// Executes a search for [query]. Saves query to recent history on success.
  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(globalSearchRepositoryProvider);
      final fiscalPeriods = ref.read(fiscalPeriodRepositoryProvider);
      final result = await repo.search(query, fiscalPeriods: fiscalPeriods);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Search failed');
      }
      state = AsyncValue.data(result.data ?? const []);
      if (query.trim().isNotEmpty) {
        await repo.saveRecentSearch(query.trim());
      }
    } catch (e, st) {
      AppLogger.warning('Search error', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  /// Clears the current results.
  void clearResults() {
    state = const AsyncValue.data([]);
  }
}

/// Holds and manages the list of recent search queries.
@riverpod
class RecentSearchesController extends _$RecentSearchesController {
  @override
  FutureOr<List<String>> build() async {
    final repo = ref.watch(globalSearchRepositoryProvider);
    final result = await repo.fetchRecentSearches();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load recent searches', error: result.error);
    return const [];
  }

  Future<void> save(String query) async {
    try {
      final repo = ref.read(globalSearchRepositoryProvider);
      await repo.saveRecentSearch(query);
      ref.invalidateSelf();
    } catch (e) {
      AppLogger.warning('Failed to save recent search', error: e);
    }
  }

  Future<void> clear() async {
    try {
      final repo = ref.read(globalSearchRepositoryProvider);
      await repo.clearRecentSearches();
      state = const AsyncValue.data([]);
    } catch (e) {
      AppLogger.warning('Failed to clear recent searches', error: e);
    }
  }
}
