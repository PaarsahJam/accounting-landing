// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crmRepository)
final crmRepositoryProvider = CrmRepositoryProvider._();

final class CrmRepositoryProvider
    extends $FunctionalProvider<CrmRepository, CrmRepository, CrmRepository>
    with $Provider<CrmRepository> {
  CrmRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crmRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crmRepositoryHash();

  @$internal
  @override
  $ProviderElement<CrmRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CrmRepository create(Ref ref) {
    return crmRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CrmRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CrmRepository>(value),
    );
  }
}

String _$crmRepositoryHash() => r'b1d8d4a524159d95c4a09916502222220568c826';
