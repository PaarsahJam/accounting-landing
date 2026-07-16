// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the current search state: a list of [SearchResult] grouped results.

@ProviderFor(GlobalSearchController)
final globalSearchControllerProvider = GlobalSearchControllerProvider._();

/// Holds the current search state: a list of [SearchResult] grouped results.
final class GlobalSearchControllerProvider
    extends $AsyncNotifierProvider<GlobalSearchController, List<SearchResult>> {
  /// Holds the current search state: a list of [SearchResult] grouped results.
  GlobalSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalSearchControllerHash();

  @$internal
  @override
  GlobalSearchController create() => GlobalSearchController();
}

String _$globalSearchControllerHash() =>
    r'3c82704d3ad8350d05a3875d3e6b5fe90a108f7d';

/// Holds the current search state: a list of [SearchResult] grouped results.

abstract class _$GlobalSearchController
    extends $AsyncNotifier<List<SearchResult>> {
  FutureOr<List<SearchResult>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SearchResult>>, List<SearchResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SearchResult>>, List<SearchResult>>,
              AsyncValue<List<SearchResult>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Holds and manages the list of recent search queries.

@ProviderFor(RecentSearchesController)
final recentSearchesControllerProvider = RecentSearchesControllerProvider._();

/// Holds and manages the list of recent search queries.
final class RecentSearchesControllerProvider
    extends $AsyncNotifierProvider<RecentSearchesController, List<String>> {
  /// Holds and manages the list of recent search queries.
  RecentSearchesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentSearchesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentSearchesControllerHash();

  @$internal
  @override
  RecentSearchesController create() => RecentSearchesController();
}

String _$recentSearchesControllerHash() =>
    r'85a1748836686311d741d93e8bb26303942c27e4';

/// Holds and manages the list of recent search queries.

abstract class _$RecentSearchesController extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
