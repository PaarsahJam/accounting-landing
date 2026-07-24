import 'package:flutter/material.dart';

import '../extensions/responsive_breakpoint.dart';
import 'app_shell.dart';

class ResponsivePageScaffold extends StatelessWidget {
  const ResponsivePageScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.leading,
  });

  final String title;
  final List<Widget>? actions;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final showMenu = context.isPhone && leading == null;
    return Scaffold(
      appBar: AppBar(
        leading: showMenu
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => AppShell.openDrawer(context),
                tooltip: 'Menu',
              )
            : leading,
        title: Text(title),
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
