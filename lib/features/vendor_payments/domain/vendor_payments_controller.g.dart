// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_payments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VendorPaymentsController)
final vendorPaymentsControllerProvider = VendorPaymentsControllerProvider._();

final class VendorPaymentsControllerProvider
    extends
        $AsyncNotifierProvider<VendorPaymentsController, List<VendorPayment>> {
  VendorPaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorPaymentsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorPaymentsControllerHash();

  @$internal
  @override
  VendorPaymentsController create() => VendorPaymentsController();
}

String _$vendorPaymentsControllerHash() =>
    r'ac6aa24e6213b1002b49e94e7adf0039bc947519';

abstract class _$VendorPaymentsController
    extends $AsyncNotifier<List<VendorPayment>> {
  FutureOr<List<VendorPayment>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VendorPayment>>, List<VendorPayment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VendorPayment>>, List<VendorPayment>>,
              AsyncValue<List<VendorPayment>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
