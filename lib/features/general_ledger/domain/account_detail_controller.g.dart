// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountDetailController)
final accountDetailControllerProvider = AccountDetailControllerFamily._();

final class AccountDetailControllerProvider
    extends
        $AsyncNotifierProvider<AccountDetailController, AccountDetailViewData> {
  AccountDetailControllerProvider._({
    required AccountDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accountDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountDetailControllerHash();

  @override
  String toString() {
    return r'accountDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AccountDetailController create() => AccountDetailController();

  @override
  bool operator ==(Object other) {
    return other is AccountDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountDetailControllerHash() =>
    r'3419c1594517101aa26c9299bdc95f5acc4dc5fb';

final class AccountDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AccountDetailController,
          AsyncValue<AccountDetailViewData>,
          AccountDetailViewData,
          FutureOr<AccountDetailViewData>,
          String
        > {
  AccountDetailControllerFamily._()
    : super(
        retry: null,
        name: r'accountDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AccountDetailControllerProvider call(String accountId) =>
      AccountDetailControllerProvider._(argument: accountId, from: this);

  @override
  String toString() => r'accountDetailControllerProvider';
}

abstract class _$AccountDetailController
    extends $AsyncNotifier<AccountDetailViewData> {
  late final _$args = ref.$arg as String;
  String get accountId => _$args;

  FutureOr<AccountDetailViewData> build(String accountId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<AccountDetailViewData>, AccountDetailViewData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AccountDetailViewData>,
                AccountDetailViewData
              >,
              AsyncValue<AccountDetailViewData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
