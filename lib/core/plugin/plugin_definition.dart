import 'plugin_action.dart';
import 'plugin_permission.dart';
import 'plugin_registry.dart';
import 'plugin_route.dart';

class PluginDefinition {
  const PluginDefinition({
    required this.id,
    required this.name,
    required this.description,
    this.version = '1.0.0',
    this.dependencies = const [],
    this.routes = const [],
    this.permissions = const [],
    this.actions = const [],
    this.onRegister,
    this.onActivate,
    this.onDeactivate,
  });

  final String id;
  final String name;
  final String description;
  final String version;
  final List<String> dependencies;
  final List<PluginRoute> routes;
  final List<PluginPermission> permissions;
  final List<PluginAction> actions;
  final void Function(PluginRegistry registry)? onRegister;
  final void Function()? onActivate;
  final void Function()? onDeactivate;

  bool get hasLifecycle =>
      onRegister != null || onActivate != null || onDeactivate != null;
}
