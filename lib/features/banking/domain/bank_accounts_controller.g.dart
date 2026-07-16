// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_accounts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BankAccountsController)
final bankAccountsControllerProvider = BankAccountsControllerProvider._();

final class BankAccountsControllerProvider
    extends $AsyncNotifierProvider<BankAccountsController, List<BankAccount>> {
  BankAccountsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankAccountsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankAccountsControllerHash();

  @$internal
  @override
  BankAccountsController create() => BankAccountsController();
}

String _$bankAccountsControllerHash() =>
    r'b3d4aad0236db52d87dc39937b7da0b84c886421';

abstract class _$BankAccountsController
    extends $AsyncNotifier<List<BankAccount>> {
  FutureOr<List<BankAccount>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BankAccount>>, List<BankAccount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BankAccount>>, List<BankAccount>>,
              AsyncValue<List<BankAccount>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
