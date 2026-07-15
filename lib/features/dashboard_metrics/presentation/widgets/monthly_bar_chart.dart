import 'package:flutter/material.dart';

import '../../domain/financial_dashboard.dart';

class MonthlyBarChart extends StatelessWidget {
  const MonthlyBarChart({
    super.key,
    required this.data,
    required this.barColor,
    this.height = 180,
  });

  final List<MonthlyDataPoint> data;
  final Color barColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('—')),
      );
    }

    final maxAmount = data
        .map((point) => point.amount)
        .fold<double>(0, (current, value) => value > current ? value : current);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _MonthlyBarChartPainter(
          data: data,
          barColor: barColor,
          maxAmount: maxAmount <= 0 ? 1 : maxAmount,
          labelStyle: Theme.of(context).textTheme.labelSmall,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _MonthlyBarChartPainter extends CustomPainter {
  _MonthlyBarChartPainter({
    required this.data,
    required this.barColor,
    required this.maxAmount,
    this.labelStyle,
  });

  final List<MonthlyDataPoint> data;
  final Color barColor;
  final double maxAmount;
  final TextStyle? labelStyle;

  static const _monthLabels = [
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / data.length * 0.55;
    final gap = size.width / data.length;
    final chartHeight = size.height - 24;

    for (var i = 0; i < data.length; i++) {
      final point = data[i];
      final barHeight = (point.amount / maxAmount) * chartHeight;
      final left = gap * i + (gap - barWidth) / 2;
      final top = chartHeight - barHeight;

      final barRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(
        barRect,
        Paint()
          ..color = barColor.withValues(alpha: point.amount > 0 ? 1 : 0.25),
      );

      final label = _monthLabels[point.month - 1];
      final textPainter = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(left + (barWidth - textPainter.width) / 2, chartHeight + 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MonthlyBarChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.barColor != barColor ||
        oldDelegate.maxAmount != maxAmount;
  }
}
