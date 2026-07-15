// lib/features/fiscal_periods/presentation/fiscal_years_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fiscal_years_page.dart';

void main() {
  testWidgets('should display fiscal years', (WidgetTester tester) async {
    final repository = FiscalYearRepository();
    await tester.pumpWidget(MaterialApp(
      home: Consumer(
        builder: (context, watch, child) {
          final controller = watch(fiscalYearControllerProvider.notifier);
          return FutureBuilder<List<FiscalYear>>(
            future: controller.load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FiscalYearsPage();
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.text('Fiscal Years'), findsOneWidget);
  });
}