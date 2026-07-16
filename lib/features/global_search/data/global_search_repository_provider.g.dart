// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_search_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(globalSearchRepository)
final globalSearchRepositoryProvider = GlobalSearchRepositoryProvider._();

final class GlobalSearchRepositoryProvider
    extends
        $FunctionalProvider<
          GlobalSearchRepository,
          GlobalSearchRepository,
          GlobalSearchRepository
        >
    with $Provider<GlobalSearchRepository> {
  GlobalSearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalSearchRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalSearchRepositoryHash();

  @$internal
  @override
  $ProviderElement<GlobalSearchRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GlobalSearchRepository create(Ref ref) {
    return globalSearchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalSearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalSearchRepository>(value),
    );
  }
}

String _$globalSearchRepositoryHash() =>
    r'55f917dda77280fd52f33dc222ac89dbaee94e45';
