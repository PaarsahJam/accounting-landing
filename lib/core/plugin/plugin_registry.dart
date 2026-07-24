import 'plugin_action.dart';
import 'plugin_definition.dart';
import 'plugin_permission.dart';
import 'plugin_route.dart';

class PluginRegistry {
  final Map<String, PluginDefinition> _definitions = {};
  final Map<String, bool> _enabled = {};
  final Map<String, String> _errors = {};

  List<PluginDefinition> get all => _definitions.values.toList();
  List<PluginRoute> get routes => _collectRoutes();
  List<PluginPermission> get permissions => _collectPermissions();
  List<PluginAction> get actions => _collectActions();
  Map<String, bool> get enabledStates => Map.unmodifiable(_enabled);
  Map<String, String> get errors => Map.unmodifiable(_errors);

  bool isEnabled(String pluginId) => _enabled[pluginId] ?? true;
  bool isRegistered(String pluginId) => _definitions.containsKey(pluginId);
  PluginDefinition? get(String pluginId) => _definitions[pluginId];

  void register(PluginDefinition plugin) {
    final id = plugin.id;
    if (_definitions.containsKey(id)) return;

    for (final dep in plugin.dependencies) {
      if (!_definitions.containsKey(dep)) {
        _errors[id] = 'Missing dependency: $dep';
        return;
      }
    }

    _definitions[id] = plugin;
    _enabled[id] = true;
    plugin.onRegister?.call(this);
  }

  void enablePlugin(String pluginId) {
    if (_definitions.containsKey(pluginId)) {
      _enabled[pluginId] = true;
      _definitions[pluginId]?.onActivate?.call();
    }
  }

  void disablePlugin(String pluginId) {
    if (_definitions.containsKey(pluginId)) {
      _definitions[pluginId]?.onDeactivate?.call();
      _enabled[pluginId] = false;
    }
  }

  List<PluginRoute> _collectRoutes() {
    final result = <PluginRoute>[];
    for (final entry in _definitions.entries) {
      if (_enabled[entry.key] == true) {
        result.addAll(entry.value.routes);
      }
    }
    return result;
  }

  List<PluginPermission> _collectPermissions() {
    final result = <PluginPermission>[];
    for (final entry in _definitions.entries) {
      if (_enabled[entry.key] == true) {
        result.addAll(entry.value.permissions);
      }
    }
    return result;
  }

  List<PluginAction> _collectActions() {
    final result = <PluginAction>[];
    for (final entry in _definitions.entries) {
      if (_enabled[entry.key] == true) {
        result.addAll(entry.value.actions);
      }
    }
    result.sort((a, b) => a.priority.compareTo(b.priority));
    return result;
  }

  void clear() {
    _definitions.clear();
    _enabled.clear();
    _errors.clear();
  }
}
