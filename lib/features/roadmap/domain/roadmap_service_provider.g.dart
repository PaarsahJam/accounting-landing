// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(roadmapMutationService)
final roadmapMutationServiceProvider = RoadmapMutationServiceProvider._();

final class RoadmapMutationServiceProvider
    extends
        $FunctionalProvider<
          RoadmapMutationService,
          RoadmapMutationService,
          RoadmapMutationService
        >
    with $Provider<RoadmapMutationService> {
  RoadmapMutationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roadmapMutationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roadmapMutationServiceHash();

  @$internal
  @override
  $ProviderElement<RoadmapMutationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoadmapMutationService create(Ref ref) {
    return roadmapMutationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoadmapMutationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoadmapMutationService>(value),
    );
  }
}

String _$roadmapMutationServiceHash() =>
    r'0a6e9f3fccf1f8b404d4c72d67e6e9b6f0e748a3';
