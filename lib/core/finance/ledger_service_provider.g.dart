// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ledgerRepository)
final ledgerRepositoryProvider = LedgerRepositoryProvider._();

final class LedgerRepositoryProvider
    extends
        $FunctionalProvider<
          LedgerRepository,
          LedgerRepository,
          LedgerRepository
        >
    with $Provider<LedgerRepository> {
  LedgerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ledgerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ledgerRepositoryHash();

  @$internal
  @override
  $ProviderElement<LedgerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LedgerRepository create(Ref ref) {
    return ledgerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LedgerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LedgerRepository>(value),
    );
  }
}

String _$ledgerRepositoryHash() => r'35140aab93bb469322839a2d7e6ea1b878a57a7a';

@ProviderFor(ledgerService)
final ledgerServiceProvider = LedgerServiceProvider._();

final class LedgerServiceProvider
    extends $FunctionalProvider<LedgerService, LedgerService, LedgerService>
    with $Provider<LedgerService> {
  LedgerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ledgerServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ledgerServiceHash();

  @$internal
  @override
  $ProviderElement<LedgerService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LedgerService create(Ref ref) {
    return ledgerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LedgerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LedgerService>(value),
    );
  }
}

String _$ledgerServiceHash() => r'ca8553c1ba47ad262a788fbeec3c3ab9f2cb5fe1';
