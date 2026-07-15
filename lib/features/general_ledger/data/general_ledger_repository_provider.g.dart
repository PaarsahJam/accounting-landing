// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_ledger_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generalLedgerRepository)
final generalLedgerRepositoryProvider = GeneralLedgerRepositoryProvider._();

final class GeneralLedgerRepositoryProvider
    extends
        $FunctionalProvider<
          GeneralLedgerRepository,
          GeneralLedgerRepository,
          GeneralLedgerRepository
        >
    with $Provider<GeneralLedgerRepository> {
  GeneralLedgerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generalLedgerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generalLedgerRepositoryHash();

  @$internal
  @override
  $ProviderElement<GeneralLedgerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeneralLedgerRepository create(Ref ref) {
    return generalLedgerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeneralLedgerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeneralLedgerRepository>(value),
    );
  }
}

String _$generalLedgerRepositoryHash() =>
    r'1d6445aa36c6fa3aafa3acd98510906c50cabba8';
