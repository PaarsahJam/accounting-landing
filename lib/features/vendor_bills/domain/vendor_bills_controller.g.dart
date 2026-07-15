// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_bills_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorBillsController)
final vendorBillsControllerProvider = VendorBillsControllerProvider._();

final class VendorBillsControllerProvider
    extends $AsyncNotifierProvider<VendorBillsController, List<VendorBill>> {
  VendorBillsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorBillsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorBillsControllerHash();

  @$internal
  @override
  VendorBillsController create() => VendorBillsController();
}

String _$vendorBillsControllerHash() =>
    r'49a47a8547ac5eee418055633636cb031611166c';

abstract class _$VendorBillsController
    extends $AsyncNotifier<List<VendorBill>> {
  FutureOr<List<VendorBill>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VendorBill>>, List<VendorBill>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VendorBill>>, List<VendorBill>>,
              AsyncValue<List<VendorBill>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
