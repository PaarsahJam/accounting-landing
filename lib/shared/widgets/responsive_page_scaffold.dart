import 'package:flutter/material.dart';

class ResponsivePageScaffold extends StatelessWidget {
  const ResponsivePageScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final String title;
  final List<Widget>? actions;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
