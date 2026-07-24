import 'package:flutter/material.dart';

import '../../../core/plugin/plugin_action.dart';
import '../../../core/plugin/plugin_definition.dart';
import '../../../core/plugin/plugin_permission.dart';
import '../../../core/plugin/plugin_route.dart';

final PluginDefinition invoicingPlugin = PluginDefinition(
  id: 'invoicing',
  name: 'Invoicing',
  description: 'Sales invoices and vendor bills management',
  version: '1.0.0',
  dependencies: [],
  permissions: [
    const PluginPermission(
      name: 'view_invoices',
      label: 'View Invoices',
      group: 'Invoicing',
      description: 'View sales invoices and vendor bills',
    ),
  ],
  routes: [
    PluginRoute(
      name: 'plugin-invoices',
      path: '/plugin/invoices',
      builder: (c, s) => const PlaceholderPage(label: 'Plugin: Invoices'),
      requiredPermission: 'view_invoices',
    ),
  ],
  actions: [
    const PluginAction(
      id: 'plugin-invoices',
      label: 'Plugin Invoices',
      icon: Icons.receipt_long,
      route: '/plugin/invoices',
      group: 'invoicing',
      priority: 10,
    ),
  ],
);

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(label)),
        body: Center(child: Text(label)),
      );
}
