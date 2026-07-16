// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_reconciliation_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BankReconciliationDetailController)
final bankReconciliationDetailControllerProvider =
    BankReconciliationDetailControllerFamily._();

final class BankReconciliationDetailControllerProvider
    extends
        $AsyncNotifierProvider<
          BankReconciliationDetailController,
          ReconciliationDetailState
        > {
  BankReconciliationDetailControllerProvider._({
    required BankReconciliationDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bankReconciliationDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$bankReconciliationDetailControllerHash();

  @override
  String toString() {
    return r'bankReconciliationDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BankReconciliationDetailController create() =>
      BankReconciliationDetailController();

  @override
  bool operator ==(Object other) {
    return other is BankReconciliationDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bankReconciliationDetailControllerHash() =>
    r'8720b9d3fc4c7c1509e335dd73a679066e75bb3d';

final class BankReconciliationDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BankReconciliationDetailController,
          AsyncValue<ReconciliationDetailState>,
          ReconciliationDetailState,
          FutureOr<ReconciliationDetailState>,
          String
        > {
  BankReconciliationDetailControllerFamily._()
    : super(
        retry: null,
        name: r'bankReconciliationDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BankReconciliationDetailControllerProvider call(String statementId) =>
      BankReconciliationDetailControllerProvider._(
        argument: statementId,
        from: this,
      );

  @override
  String toString() => r'bankReconciliationDetailControllerProvider';
}

abstract class _$BankReconciliationDetailController
    extends $AsyncNotifier<ReconciliationDetailState> {
  late final _$args = ref.$arg as String;
  String get statementId => _$args;

  FutureOr<ReconciliationDetailState> build(String statementId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ReconciliationDetailState>,
              ReconciliationDetailState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ReconciliationDetailState>,
                ReconciliationDetailState
              >,
              AsyncValue<ReconciliationDetailState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
