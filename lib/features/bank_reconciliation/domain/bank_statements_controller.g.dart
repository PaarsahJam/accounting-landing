// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_statements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BankStatementsController)
final bankStatementsControllerProvider = BankStatementsControllerProvider._();

final class BankStatementsControllerProvider
    extends
        $AsyncNotifierProvider<BankStatementsController, List<BankStatement>> {
  BankStatementsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankStatementsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankStatementsControllerHash();

  @$internal
  @override
  BankStatementsController create() => BankStatementsController();
}

String _$bankStatementsControllerHash() =>
    r'd9d30fb31561daf76330e6fd56740316d64b7de2';

abstract class _$BankStatementsController
    extends $AsyncNotifier<List<BankStatement>> {
  FutureOr<List<BankStatement>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BankStatement>>, List<BankStatement>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BankStatement>>, List<BankStatement>>,
              AsyncValue<List<BankStatement>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
