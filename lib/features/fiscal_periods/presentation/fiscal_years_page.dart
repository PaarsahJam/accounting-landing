// lib/features/fiscal_periods/presentation/fiscal_years_page.dart

import 'package:accounting_app/features/fiscal_periods/domain/fiscal_year.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/fiscal_year_controller.dart';

class FiscalYearsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fiscalYearController = ref.watch(
      fiscalYearControllerProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Fiscal Years')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add new fiscal year logic here.
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<FiscalYear>>(
        future: fiscalYearController.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading fiscal years.'));
          } else {
            final fiscalYears = snapshot.data!;
            return ListView.builder(
              itemCount: fiscalYears.length,
              itemBuilder: (context, index) {
                final fiscalYear = fiscalYears[index];
                return ListTile(
                  title: Text(fiscalYear.year.toString()),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to Fiscal Periods page.
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
