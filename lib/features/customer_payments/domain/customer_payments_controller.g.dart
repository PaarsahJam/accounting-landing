// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_payments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomerPaymentsController)
final customerPaymentsControllerProvider =
    CustomerPaymentsControllerProvider._();

final class CustomerPaymentsControllerProvider
    extends
        $AsyncNotifierProvider<
          CustomerPaymentsController,
          List<CustomerPayment>
        > {
  CustomerPaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerPaymentsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerPaymentsControllerHash();

  @$internal
  @override
  CustomerPaymentsController create() => CustomerPaymentsController();
}

String _$customerPaymentsControllerHash() =>
    r'cb6d457389530bba886c6316007d31163f17f6e5';

abstract class _$CustomerPaymentsController
    extends $AsyncNotifier<List<CustomerPayment>> {
  FutureOr<List<CustomerPayment>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CustomerPayment>>, List<CustomerPayment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CustomerPayment>>,
                List<CustomerPayment>
              >,
              AsyncValue<List<CustomerPayment>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
