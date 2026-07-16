// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_trail_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(auditTrailRepository)
final auditTrailRepositoryProvider = AuditTrailRepositoryProvider._();

final class AuditTrailRepositoryProvider
    extends
        $FunctionalProvider<
          AuditTrailRepository,
          AuditTrailRepository,
          AuditTrailRepository
        >
    with $Provider<AuditTrailRepository> {
  AuditTrailRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditTrailRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditTrailRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuditTrailRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuditTrailRepository create(Ref ref) {
    return auditTrailRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuditTrailRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuditTrailRepository>(value),
    );
  }
}

String _$auditTrailRepositoryHash() =>
    r'c31d422553d61095426a40de42469eddcd2eaf66';
