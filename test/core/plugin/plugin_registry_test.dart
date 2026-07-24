import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/plugin/plugin_action.dart';
import 'package:accounting_app/core/plugin/plugin_definition.dart';
import 'package:accounting_app/core/plugin/plugin_permission.dart';
import 'package:accounting_app/core/plugin/plugin_registry.dart';
import 'package:accounting_app/core/plugin/plugin_route.dart';

void main() {
  late PluginRegistry registry;

  setUp(() {
    registry = PluginRegistry();
  });

  final testPlugin = PluginDefinition(
    id: 'test-plugin',
    name: 'Test Plugin',
    description: 'A test plugin',
    version: '1.0.0',
    permissions: [
      const PluginPermission(
        name: 'test_view',
        label: 'View Test',
        group: 'Test',
      ),
    ],
    routes: [
      PluginRoute(
        name: 'test-route',
        path: '/test',
        builder: (c, s) =>
            const _PlaceholderPage(label: 'Test Route'),
      ),
    ],
    actions: [
      const PluginAction(
        id: 'test-action',
        label: 'Test Action',
        icon: Icons.star,
        route: '/test',
        priority: 1,
      ),
    ],
  );

  group('registration', () {
    test('registers a plugin', () {
      registry.register(testPlugin);
      expect(registry.isRegistered('test-plugin'), isTrue);
      expect(registry.all, hasLength(1));
    });

    test('duplicate registration is idempotent', () {
      registry.register(testPlugin);
      registry.register(testPlugin);
      expect(registry.all, hasLength(1));
    });

    test('retrieves registered plugin by id', () {
      registry.register(testPlugin);
      final retrieved = registry.get('test-plugin');
      expect(retrieved, isNotNull);
      expect(retrieved!.name, equals('Test Plugin'));
    });

    test('returns null for unregistered plugin', () {
      expect(registry.get('nonexistent'), isNull);
    });
  });

  group('dependency validation', () {
    final dependentPlugin = PluginDefinition(
      id: 'dependent',
      name: 'Dependent',
      description: 'Needs base plugin',
      dependencies: ['test-plugin'],
      routes: [],
      permissions: [],
      actions: [],
    );

    test('rejects plugin with missing dependency', () {
      registry.register(dependentPlugin);
      expect(registry.isRegistered('dependent'), isFalse);
      expect(registry.errors.keys, contains('dependent'));
      expect(registry.errors['dependent'], contains('Missing dependency'));
    });

    test('accepts plugin when dependency is registered first', () {
      registry.register(testPlugin);
      registry.register(dependentPlugin);
      expect(registry.isRegistered('dependent'), isTrue);
      expect(registry.errors.keys, isNot(contains('dependent')));
    });
  });

  group('enable / disable', () {
    test('plugin is enabled by default', () {
      registry.register(testPlugin);
      expect(registry.isEnabled('test-plugin'), isTrue);
    });

    test('disablePlugin removes routes, permissions, and actions', () {
      registry.register(testPlugin);
      expect(registry.routes, hasLength(1));
      expect(registry.permissions, hasLength(1));
      expect(registry.actions, hasLength(1));

      registry.disablePlugin('test-plugin');
      expect(registry.isEnabled('test-plugin'), isFalse);
      expect(registry.routes, isEmpty);
      expect(registry.permissions, isEmpty);
      expect(registry.actions, isEmpty);
    });

    test('enablePlugin restores contributions', () {
      registry.register(testPlugin);
      registry.disablePlugin('test-plugin');
      registry.enablePlugin('test-plugin');
      expect(registry.isEnabled('test-plugin'), isTrue);
      expect(registry.routes, hasLength(1));
      expect(registry.permissions, hasLength(1));
      expect(registry.actions, hasLength(1));
    });
  });

  group('lifecycle hooks', () {
    test('onRegister is called during registration', () {
      bool called = false;
      final plugin = PluginDefinition(
        id: 'lifecycle',
        name: 'Lifecycle',
        description: 'Tests lifecycle hooks',
        onRegister: (_) => called = true,
        routes: [],
        permissions: [],
        actions: [],
      );
      registry.register(plugin);
      expect(called, isTrue);
    });

    test('onActivate is called when enabling', () {
      bool activated = false;
      final plugin = PluginDefinition(
        id: 'lifecycle-act',
        name: 'Activate',
        description: 'Tests activate',
        onActivate: () => activated = true,
        routes: [],
        permissions: [],
        actions: [],
      );
      registry.register(plugin);
      registry.enablePlugin('lifecycle-act');
      expect(activated, isTrue);
    });

    test('onDeactivate is called when disabling', () {
      bool deactivated = false;
      final plugin = PluginDefinition(
        id: 'lifecycle-deact',
        name: 'Deactivate',
        description: 'Tests deactivate',
        onDeactivate: () => deactivated = true,
        routes: [],
        permissions: [],
        actions: [],
      );
      registry.register(plugin);
      registry.disablePlugin('lifecycle-deact');
      expect(deactivated, isTrue);
    });
  });

  group('collection methods', () {
    test('routes collects from all enabled plugins', () {
      registry.register(testPlugin);
      final routes = registry.routes;
      expect(routes, hasLength(1));
      expect(routes.first.name, equals('test-route'));
    });

    test('permissions collects from all enabled plugins', () {
      registry.register(testPlugin);
      final perms = registry.permissions;
      expect(perms, hasLength(1));
      expect(perms.first.name, equals('test_view'));
    });

    test('actions are sorted by priority', () {
      final low = PluginDefinition(
        id: 'low',
        name: 'Low',
        description: 'Low priority',
        actions: [
          const PluginAction(
            id: 'low',
            label: 'Low',
            icon: Icons.ac_unit,
            route: '/low',
            priority: 10,
          ),
        ],
        routes: [],
        permissions: [],
      );
      final high = PluginDefinition(
        id: 'high',
        name: 'High',
        description: 'High priority',
        actions: [
          const PluginAction(
            id: 'high',
            label: 'High',
            icon: Icons.ac_unit,
            route: '/high',
            priority: 0,
          ),
        ],
        routes: [],
        permissions: [],
      );
      registry.register(high);
      registry.register(low);
      final actions = registry.actions;
      expect(actions, hasLength(2));
      expect(actions.first.id, equals('high'));
      expect(actions.last.id, equals('low'));
    });

    test('clear resets everything', () {
      registry.register(testPlugin);
      expect(registry.all, hasLength(1));
      registry.clear();
      expect(registry.all, isEmpty);
      expect(registry.errors, isEmpty);
    });
  });

  group('plugin route to GoRoute conversion', () {
    test('toGoRoute produces correct GoRoute', () {
      final route = PluginRoute(
        name: 'plugin-test',
        path: '/plugin/test',
        builder: (c, s) =>
            const _PlaceholderPage(label: 'Test'),
      );
      final goRoute = route.toGoRoute();
      expect(goRoute.name, equals('plugin-test'));
      expect(goRoute.path, equals('/plugin/test'));
    });
  });
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(label)), body: Center(child: Text(label)));
}
