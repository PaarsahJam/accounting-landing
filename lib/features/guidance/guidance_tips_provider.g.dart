// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidance_tips_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton controller shared by the tip trigger and the tip overlay.

@ProviderFor(contextualTipController)
final contextualTipControllerProvider = ContextualTipControllerProvider._();

/// Singleton controller shared by the tip trigger and the tip overlay.

final class ContextualTipControllerProvider
    extends
        $FunctionalProvider<
          ContextualTipController,
          ContextualTipController,
          ContextualTipController
        >
    with $Provider<ContextualTipController> {
  /// Singleton controller shared by the tip trigger and the tip overlay.
  ContextualTipControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contextualTipControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contextualTipControllerHash();

  @$internal
  @override
  $ProviderElement<ContextualTipController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContextualTipController create(Ref ref) {
    return contextualTipController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContextualTipController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContextualTipController>(value),
    );
  }
}

String _$contextualTipControllerHash() =>
    r'ed428430d623dc8e62bad0e717c94583874d21eb';

/// Tracks which contextual tips the user has dismissed.
///
/// Persisted in secure storage so a dismissed tip stays hidden across app
/// launches. Persistence is best-effort: storage failures are ignored.

@ProviderFor(DismissedTips)
final dismissedTipsProvider = DismissedTipsProvider._();

/// Tracks which contextual tips the user has dismissed.
///
/// Persisted in secure storage so a dismissed tip stays hidden across app
/// launches. Persistence is best-effort: storage failures are ignored.
final class DismissedTipsProvider
    extends $NotifierProvider<DismissedTips, Set<String>> {
  /// Tracks which contextual tips the user has dismissed.
  ///
  /// Persisted in secure storage so a dismissed tip stays hidden across app
  /// launches. Persistence is best-effort: storage failures are ignored.
  DismissedTipsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dismissedTipsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dismissedTipsHash();

  @$internal
  @override
  DismissedTips create() => DismissedTips();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$dismissedTipsHash() => r'38939322b7d4f0b040b0bbe6ed4f3b295ff1a1ca';

/// Tracks which contextual tips the user has dismissed.
///
/// Persisted in secure storage so a dismissed tip stays hidden across app
/// launches. Persistence is best-effort: storage failures are ignored.

abstract class _$DismissedTips extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
