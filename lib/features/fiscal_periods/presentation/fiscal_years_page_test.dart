// lib/features/fiscal_periods/presentation/fiscal_years_page_test.dart

import 'package:accounting_app/features/fiscal_periods/controller/fiscal_year_controller.dart';
import 'package:accounting_app/features/fiscal_periods/domain/fiscal_year.dart';
import 'package:accounting_app/features/fiscal_periods/presentation/fiscal_years_page.dart';
// import 'package:accounting_app/features/fiscal_periods/repository/fiscal_year_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display fiscal years', (WidgetTester tester) async {
    // final repository = FiscalYearRepository();
    await tester.pumpWidget(MaterialApp(
      home: Consumer(
        builder: (context, ref, child) {
          final controller = ref.watch(fiscalYearControllerProvider.notifier);
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