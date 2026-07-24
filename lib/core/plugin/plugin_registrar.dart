import '../../features/invoicing/plugin/invoicing_plugin.dart';
import 'plugin_registry.dart';

/// Entry point that imports and registers all built-in plugins.
///
/// Future third-party plugins register themselves through the same
/// mechanism — the host app imports the plugin's registrar function
/// and calls it here.
void registerAllPlugins(PluginRegistry registry) {
  registry.register(invoicingPlugin);
}
