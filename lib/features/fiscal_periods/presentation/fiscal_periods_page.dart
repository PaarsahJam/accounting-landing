// lib/features/fiscal_periods/presentation/fiscal_periods_page.dart

import 'package:accounting_app/features/fiscal_periods/domain/fiscal_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/fiscal_period_controller.dart';

class FiscalPeriodsPage extends ConsumerWidget {
  final int fiscalYearId;

  FiscalPeriodsPage({required this.fiscalYearId});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final fiscalPeriodController = watch(fiscalPeriodControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Fiscal Periods')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add new fiscal period logic here.
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<FiscalPeriod>>(
        future: fiscalPeriodController.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading fiscal periods.'));
          } else {
            final fiscalPeriods = snapshot.data!;
            return ListView.builder(
              itemCount: fiscalPeriods.length,
              itemBuilder: (context, index) {
                final fiscalPeriod = fiscalPeriods[index];
                return ListTile(
                  title: Text(fiscalPeriod.periodNumber.toString()),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Year-End Closing page.
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}