import 'package:flutter/material.dart';

/// A standard page scaffold with an AppBar and a safely padded body.
///
/// Use [floatingActionButton] for page-level primary actions.
/// Use [actions] for AppBar icon buttons.
class ResponsivePageScaffold extends StatelessWidget {
  const ResponsivePageScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String title;
  final List<Widget>? actions;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
