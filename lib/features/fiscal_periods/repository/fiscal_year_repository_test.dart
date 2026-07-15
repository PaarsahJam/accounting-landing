// lib/features/fiscal_periods/repository/fiscal_year_repository_test.dart

import 'package:accounting_app/features/fiscal_periods/domain/fiscal_year.dart';
import 'package:accounting_app/features/fiscal_periods/repository/fiscal_year_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FiscalYearRepository', () {
    test('should return a list of fiscal years', () async {
      final repository = FiscalYearRepository();
      final result = await repository.getFiscalYears();
      expect(result, isEmpty);
    });

    test('should add a new fiscal year', () async {
      final repository = FiscalYearRepository();
      await repository.add(FiscalYear(id: 1, year: 2023, status: FiscalYearStatus.active, startDate: DateTime(2023, 1, 1), endDate: DateTime(2023, 12, 31)));
      final result = await repository.getFiscalYears();
      expect(result.length, 1);
    });
  });
}