// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pluginRegistry)
final pluginRegistryProvider = PluginRegistryProvider._();

final class PluginRegistryProvider
    extends $FunctionalProvider<PluginRegistry, PluginRegistry, PluginRegistry>
    with $Provider<PluginRegistry> {
  PluginRegistryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginRegistryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginRegistryHash();

  @$internal
  @override
  $ProviderElement<PluginRegistry> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PluginRegistry create(Ref ref) {
    return pluginRegistry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PluginRegistry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PluginRegistry>(value),
    );
  }
}

String _$pluginRegistryHash() => r'da05f796e034e72a43b0b985f39c5dfad867bef2';

@ProviderFor(pluginRoutes)
final pluginRoutesProvider = PluginRoutesProvider._();

final class PluginRoutesProvider
    extends
        $FunctionalProvider<
          List<PluginRoute>,
          List<PluginRoute>,
          List<PluginRoute>
        >
    with $Provider<List<PluginRoute>> {
  PluginRoutesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginRoutesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginRoutesHash();

  @$internal
  @override
  $ProviderElement<List<PluginRoute>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PluginRoute> create(Ref ref) {
    return pluginRoutes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PluginRoute> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PluginRoute>>(value),
    );
  }
}

String _$pluginRoutesHash() => r'9631ec5e116af8568f5e381671c78a39c855ac54';

@ProviderFor(pluginActions)
final pluginActionsProvider = PluginActionsProvider._();

final class PluginActionsProvider
    extends
        $FunctionalProvider<
          List<PluginAction>,
          List<PluginAction>,
          List<PluginAction>
        >
    with $Provider<List<PluginAction>> {
  PluginActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pluginActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pluginActionsHash();

  @$internal
  @override
  $ProviderElement<List<PluginAction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PluginAction> create(Ref ref) {
    return pluginActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PluginAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PluginAction>>(value),
    );
  }
}

String _$pluginActionsHash() => r'ecc79700dfbe1bd78677d218e62e806afbc1409d';

@ProviderFor(pluginEnabled)
final pluginEnabledProvider = PluginEnabledFamily._();

final class PluginEnabledProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  PluginEnabledProvider._({
    required PluginEnabledFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pluginEnabledProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pluginEnabledHash();

  @override
  String toString() {
    return r'pluginEnabledProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return pluginEnabled(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PluginEnabledProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pluginEnabledHash() => r'a62d114e2970d9e4ba18fbe41bccfa66b6f2d74a';

final class PluginEnabledFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  PluginEnabledFamily._()
    : super(
        retry: null,
        name: r'pluginEnabledProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PluginEnabledProvider call(String pluginId) =>
      PluginEnabledProvider._(argument: pluginId, from: this);

  @override
  String toString() => r'pluginEnabledProvider';
}
