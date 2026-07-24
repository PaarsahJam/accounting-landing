import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'plugin_action.dart';
import 'plugin_registrar.dart';
import 'plugin_registry.dart';
import 'plugin_route.dart';

part 'plugin_providers.g.dart';

PluginRegistry _createRegistry() {
  final registry = PluginRegistry();
  registerAllPlugins(registry);
  return registry;
}

@riverpod
PluginRegistry pluginRegistry(Ref ref) => _createRegistry();

@riverpod
List<PluginRoute> pluginRoutes(Ref ref) {
  final registry = ref.watch(pluginRegistryProvider);
  return registry.routes;
}

@riverpod
List<PluginAction> pluginActions(Ref ref) {
  final registry = ref.watch(pluginRegistryProvider);
  return registry.actions;
}

@riverpod
bool pluginEnabled(Ref ref, String pluginId) {
  final registry = ref.watch(pluginRegistryProvider);
  return registry.isEnabled(pluginId);
}
