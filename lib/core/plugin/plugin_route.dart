import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PluginRoute {
  const PluginRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requiredPermission,
    this.requiresCompany = true,
  });

  final String name;
  final String path;
  final Widget Function(BuildContext, GoRouterState) builder;
  final String? requiredPermission;
  final bool requiresCompany;

  GoRoute toGoRoute() => GoRoute(
        name: name,
        path: path,
        builder: builder,
      );
}
