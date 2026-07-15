// lib/features/fiscal_periods/controller/fiscal_year_controller_test.dart

import 'package:accounting_app/features/fiscal_periods/controller/fiscal_year_controller.dart';
import 'package:accounting_app/features/fiscal_periods/fiscal_year.dart';
import 'package:accounting_app/features/fiscal_periods/repository/fiscal_year_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FiscalYearController', () {
    test('should load fiscal years', () async {
      final repository = FiscalYearRepository();
      final controller = FiscalYearController(repository);
      await controller.load();
      expect(controller.state, isEmpty);
    });

    test('should add a new fiscal year', () async {
      final repository = FiscalYearRepository();
      final controller = FiscalYearController(repository);
      await controller.add(FiscalYear(id: 1, year: 2023, status: FiscalYearStatus.active, startDate: DateTime(2023, 1, 1), endDate: DateTime(2023, 12, 31)));
      final result = await repository.getFiscalYears();
      expect(result.length, 1);
    });
  });
}