// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banking_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bankingRepository)
final bankingRepositoryProvider = BankingRepositoryProvider._();

final class BankingRepositoryProvider
    extends
        $FunctionalProvider<
          BankingRepository,
          BankingRepository,
          BankingRepository
        >
    with $Provider<BankingRepository> {
  BankingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BankingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BankingRepository create(Ref ref) {
    return bankingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BankingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BankingRepository>(value),
    );
  }
}

String _$bankingRepositoryHash() => r'c3020b1a03ab2dfe276d87cbd24bc5f6209f4a69';
