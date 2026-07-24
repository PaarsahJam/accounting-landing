// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncQueue)
final syncQueueProvider = SyncQueueProvider._();

final class SyncQueueProvider
    extends $FunctionalProvider<SyncQueue, SyncQueue, SyncQueue>
    with $Provider<SyncQueue> {
  SyncQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncQueueHash();

  @$internal
  @override
  $ProviderElement<SyncQueue> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncQueue create(Ref ref) {
    return syncQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncQueue value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncQueue>(value),
    );
  }
}

String _$syncQueueHash() => r'a57cad328308184003daa1298449d25539a55256';

@ProviderFor(conflictDetector)
final conflictDetectorProvider = ConflictDetectorProvider._();

final class ConflictDetectorProvider
    extends
        $FunctionalProvider<
          ConflictDetector,
          ConflictDetector,
          ConflictDetector
        >
    with $Provider<ConflictDetector> {
  ConflictDetectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conflictDetectorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conflictDetectorHash();

  @$internal
  @override
  $ProviderElement<ConflictDetector> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ConflictDetector create(Ref ref) {
    return conflictDetector(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConflictDetector value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConflictDetector>(value),
    );
  }
}

String _$conflictDetectorHash() => r'c8c1debb2ed072d2fcfe8e940961800d5702a10e';

@ProviderFor(syncEngine)
final syncEngineProvider = SyncEngineProvider._();

final class SyncEngineProvider
    extends $FunctionalProvider<SyncEngine, SyncEngine, SyncEngine>
    with $Provider<SyncEngine> {
  SyncEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncEngineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncEngineHash();

  @$internal
  @override
  $ProviderElement<SyncEngine> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncEngine create(Ref ref) {
    return syncEngine(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncEngine value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncEngine>(value),
    );
  }
}

String _$syncEngineHash() => r'57dbaab10a1453849ce4810c290f6a3747b00f66';
