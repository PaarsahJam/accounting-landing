import 'package:accounting_app/features/dashboard_metrics/presentation/widgets/monthly_bar_chart.dart';
import 'package:accounting_app/features/dashboard_metrics/domain/financial_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('monthly bar chart renders for data points', (tester) async {
    const data = [
      MonthlyDataPoint(year: 2024, month: 1, amount: 100),
      MonthlyDataPoint(year: 2024, month: 2, amount: 200),
      MonthlyDataPoint(year: 2024, month: 3, amount: 50),
    ];

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MonthlyBarChart(data: data, barColor: Colors.green),
        ),
      ),
    );

    expect(find.byType(MonthlyBarChart), findsOneWidget);
    expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
  });
}
