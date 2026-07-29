// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_statement_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bankStatementRepository)
final bankStatementRepositoryProvider = BankStatementRepositoryProvider._();

final class BankStatementRepositoryProvider
    extends
        $FunctionalProvider<
          BankStatementRepository,
          BankStatementRepository,
          BankStatementRepository
        >
    with $Provider<BankStatementRepository> {
  BankStatementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankStatementRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankStatementRepositoryHash();

  @$internal
  @override
  $ProviderElement<BankStatementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BankStatementRepository create(Ref ref) {
    return bankStatementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BankStatementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BankStatementRepository>(value),
    );
  }
}

String _$bankStatementRepositoryHash() =>
    r'0b40eb1cc92a817a57c3021768cceb36bfd5ba16';
