// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_statements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorStatementsController)
final vendorStatementsControllerProvider =
    VendorStatementsControllerProvider._();

final class VendorStatementsControllerProvider
    extends
        $AsyncNotifierProvider<
          VendorStatementsController,
          List<VendorStatement>
        > {
  VendorStatementsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorStatementsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorStatementsControllerHash();

  @$internal
  @override
  VendorStatementsController create() => VendorStatementsController();
}

String _$vendorStatementsControllerHash() =>
    r'1e4d5cf4be618a34e8ad3bb06003a8881df264d2';

abstract class _$VendorStatementsController
    extends $AsyncNotifier<List<VendorStatement>> {
  FutureOr<List<VendorStatement>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<VendorStatement>>, List<VendorStatement>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<VendorStatement>>,
                List<VendorStatement>
              >,
              AsyncValue<List<VendorStatement>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
