// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_statements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomerStatementsController)
final customerStatementsControllerProvider =
    CustomerStatementsControllerProvider._();

final class CustomerStatementsControllerProvider
    extends
        $AsyncNotifierProvider<
          CustomerStatementsController,
          List<CustomerStatement>
        > {
  CustomerStatementsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerStatementsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerStatementsControllerHash();

  @$internal
  @override
  CustomerStatementsController create() => CustomerStatementsController();
}

String _$customerStatementsControllerHash() =>
    r'ef8cced798dd28454f49f112b5241b78678909e8';

abstract class _$CustomerStatementsController
    extends $AsyncNotifier<List<CustomerStatement>> {
  FutureOr<List<CustomerStatement>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CustomerStatement>>,
              List<CustomerStatement>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CustomerStatement>>,
                List<CustomerStatement>
              >,
              AsyncValue<List<CustomerStatement>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
