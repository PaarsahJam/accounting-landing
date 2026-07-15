// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorsController)
final vendorsControllerProvider = VendorsControllerProvider._();

final class VendorsControllerProvider
    extends $AsyncNotifierProvider<VendorsController, List<Vendor>> {
  VendorsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorsControllerHash();

  @$internal
  @override
  VendorsController create() => VendorsController();
}

String _$vendorsControllerHash() => r'904fc83b37c23e885dbd021f20d4b61bf53a187d';

abstract class _$VendorsController extends $AsyncNotifier<List<Vendor>> {
  FutureOr<List<Vendor>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Vendor>>, List<Vendor>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Vendor>>, List<Vendor>>,
              AsyncValue<List<Vendor>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
