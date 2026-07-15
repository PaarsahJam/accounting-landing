import 'package:flutter/material.dart';

class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCountBuilder,
    this.childAspectRatio = 1.6,
    this.padding = const EdgeInsets.all(16),
  });

  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final int Function(BuildContext context, BoxConstraints constraints)?
  crossAxisCountBuilder;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
            crossAxisCountBuilder?.call(context, constraints) ?? 1;
        return GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
