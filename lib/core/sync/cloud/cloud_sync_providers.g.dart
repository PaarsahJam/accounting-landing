// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncQueueStorage)
final syncQueueStorageProvider = SyncQueueStorageProvider._();

final class SyncQueueStorageProvider
    extends
        $FunctionalProvider<
          SyncQueueStorage,
          SyncQueueStorage,
          SyncQueueStorage
        >
    with $Provider<SyncQueueStorage> {
  SyncQueueStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncQueueStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncQueueStorageHash();

  @$internal
  @override
  $ProviderElement<SyncQueueStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncQueueStorage create(Ref ref) {
    return syncQueueStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncQueueStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncQueueStorage>(value),
    );
  }
}

String _$syncQueueStorageHash() => r'6e80f035915817eada338b376b2fdf9bd02c2d33';

@ProviderFor(cloudSyncConfig)
final cloudSyncConfigProvider = CloudSyncConfigProvider._();

final class CloudSyncConfigProvider
    extends
        $FunctionalProvider<
          CloudSyncConfig?,
          CloudSyncConfig?,
          CloudSyncConfig?
        >
    with $Provider<CloudSyncConfig?> {
  CloudSyncConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloudSyncConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloudSyncConfigHash();

  @$internal
  @override
  $ProviderElement<CloudSyncConfig?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CloudSyncConfig? create(Ref ref) {
    return cloudSyncConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudSyncConfig? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudSyncConfig?>(value),
    );
  }
}

String _$cloudSyncConfigHash() => r'3733c8f1d54bf12c0c291efbd3b1214f41695c80';

@ProviderFor(syncTransport)
final syncTransportProvider = SyncTransportProvider._();

final class SyncTransportProvider
    extends $FunctionalProvider<SyncTransport, SyncTransport, SyncTransport>
    with $Provider<SyncTransport> {
  SyncTransportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncTransportProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncTransportHash();

  @$internal
  @override
  $ProviderElement<SyncTransport> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncTransport create(Ref ref) {
    return syncTransport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncTransport value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncTransport>(value),
    );
  }
}

String _$syncTransportHash() => r'63bd39f7fd78bc95d3ea9fdee34fdf242434f1c1';

@ProviderFor(syncOrchestrator)
final syncOrchestratorProvider = SyncOrchestratorProvider._();

final class SyncOrchestratorProvider
    extends
        $FunctionalProvider<
          SyncOrchestrator,
          SyncOrchestrator,
          SyncOrchestrator
        >
    with $Provider<SyncOrchestrator> {
  SyncOrchestratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncOrchestratorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncOrchestratorHash();

  @$internal
  @override
  $ProviderElement<SyncOrchestrator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncOrchestrator create(Ref ref) {
    return syncOrchestrator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncOrchestrator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncOrchestrator>(value),
    );
  }
}

String _$syncOrchestratorHash() => r'229d1f963bcdc22f65161c0fc3d7a66ae48f73e6';
