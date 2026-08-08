// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidance_tour_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton tour controller shared by the trigger and the overlay.

@ProviderFor(guidanceTourController)
final guidanceTourControllerProvider = GuidanceTourControllerProvider._();

/// Singleton tour controller shared by the trigger and the overlay.

final class GuidanceTourControllerProvider
    extends
        $FunctionalProvider<
          GuidanceTourController,
          GuidanceTourController,
          GuidanceTourController
        >
    with $Provider<GuidanceTourController> {
  /// Singleton tour controller shared by the trigger and the overlay.
  GuidanceTourControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guidanceTourControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guidanceTourControllerHash();

  @$internal
  @override
  $ProviderElement<GuidanceTourController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GuidanceTourController create(Ref ref) {
    return guidanceTourController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuidanceTourController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuidanceTourController>(value),
    );
  }
}

String _$guidanceTourControllerHash() =>
    r'5c854548428c39ebf6c7c22a4c0ee2c2b2f23851';

/// Whether the user has already completed or skipped the guidance tour.
///
/// Stored in secure storage so it only shows once per device.

@ProviderFor(guidanceTourSeen)
final guidanceTourSeenProvider = GuidanceTourSeenProvider._();

/// Whether the user has already completed or skipped the guidance tour.
///
/// Stored in secure storage so it only shows once per device.

final class GuidanceTourSeenProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Whether the user has already completed or skipped the guidance tour.
  ///
  /// Stored in secure storage so it only shows once per device.
  GuidanceTourSeenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guidanceTourSeenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guidanceTourSeenHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return guidanceTourSeen(ref);
  }
}

String _$guidanceTourSeenHash() => r'd5b018b39809a629cb79242316928dd33e3fa0e9';
