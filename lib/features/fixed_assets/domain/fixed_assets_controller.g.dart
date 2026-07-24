// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_assets_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FixedAssetsController)
final fixedAssetsControllerProvider = FixedAssetsControllerProvider._();

final class FixedAssetsControllerProvider
    extends $AsyncNotifierProvider<FixedAssetsController, List<FixedAsset>> {
  FixedAssetsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fixedAssetsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fixedAssetsControllerHash();

  @$internal
  @override
  FixedAssetsController create() => FixedAssetsController();
}

String _$fixedAssetsControllerHash() =>
    r'e062deb46b3d084cfa7bb1d14d2bbe48a02a87f5';

abstract class _$FixedAssetsController
    extends $AsyncNotifier<List<FixedAsset>> {
  FutureOr<List<FixedAsset>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FixedAsset>>, List<FixedAsset>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FixedAsset>>, List<FixedAsset>>,
              AsyncValue<List<FixedAsset>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
