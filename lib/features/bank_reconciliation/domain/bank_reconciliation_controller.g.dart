// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_reconciliation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BankReconciliationController)
final bankReconciliationControllerProvider =
    BankReconciliationControllerProvider._();

final class BankReconciliationControllerProvider
    extends
        $AsyncNotifierProvider<
          BankReconciliationController,
          Map<String, dynamic>
        > {
  BankReconciliationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankReconciliationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankReconciliationControllerHash();

  @$internal
  @override
  BankReconciliationController create() => BankReconciliationController();
}

String _$bankReconciliationControllerHash() =>
    r'7028fa31b4bfb4f67680061f22b3cdb96b147697';

abstract class _$BankReconciliationController
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
