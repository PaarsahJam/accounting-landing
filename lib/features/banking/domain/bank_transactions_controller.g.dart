// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_transactions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BankTransactionsController)
final bankTransactionsControllerProvider = BankTransactionsControllerFamily._();

final class BankTransactionsControllerProvider
    extends
        $AsyncNotifierProvider<
          BankTransactionsController,
          BankTransactionsState
        > {
  BankTransactionsControllerProvider._({
    required BankTransactionsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bankTransactionsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bankTransactionsControllerHash();

  @override
  String toString() {
    return r'bankTransactionsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BankTransactionsController create() => BankTransactionsController();

  @override
  bool operator ==(Object other) {
    return other is BankTransactionsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bankTransactionsControllerHash() =>
    r'48bc57b09eb4351bd96da73faaf7a844bc0455ac';

final class BankTransactionsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BankTransactionsController,
          AsyncValue<BankTransactionsState>,
          BankTransactionsState,
          FutureOr<BankTransactionsState>,
          String
        > {
  BankTransactionsControllerFamily._()
    : super(
        retry: null,
        name: r'bankTransactionsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BankTransactionsControllerProvider call(String accountId) =>
      BankTransactionsControllerProvider._(argument: accountId, from: this);

  @override
  String toString() => r'bankTransactionsControllerProvider';
}

abstract class _$BankTransactionsController
    extends $AsyncNotifier<BankTransactionsState> {
  late final _$args = ref.$arg as String;
  String get accountId => _$args;

  FutureOr<BankTransactionsState> build(String accountId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<BankTransactionsState>, BankTransactionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<BankTransactionsState>,
                BankTransactionsState
              >,
              AsyncValue<BankTransactionsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
