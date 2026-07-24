import 'package:flutter/widgets.dart';

class PluginAction {
  const PluginAction({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
    this.requiredPermission,
    this.group,
    this.priority = 0,
  });

  final String id;
  final String label;
  final IconData icon;
  final String route;
  final String? requiredPermission;
  final String? group;
  final int priority;
}
