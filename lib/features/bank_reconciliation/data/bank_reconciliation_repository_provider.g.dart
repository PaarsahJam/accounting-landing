// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_reconciliation_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bankReconciliationRepository)
final bankReconciliationRepositoryProvider =
    BankReconciliationRepositoryProvider._();

final class BankReconciliationRepositoryProvider
    extends
        $FunctionalProvider<
          BankReconciliationRepository,
          BankReconciliationRepository,
          BankReconciliationRepository
        >
    with $Provider<BankReconciliationRepository> {
  BankReconciliationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankReconciliationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankReconciliationRepositoryHash();

  @$internal
  @override
  $ProviderElement<BankReconciliationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BankReconciliationRepository create(Ref ref) {
    return bankReconciliationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BankReconciliationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BankReconciliationRepository>(value),
    );
  }
}

String _$bankReconciliationRepositoryHash() =>
    r'1020f90e98c3bb36de1be02ceab2d75f2a022cd3';
