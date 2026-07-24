import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/company/company.dart';
import 'package:accounting_app/core/company/company_repository.dart';

void main() {
  group('Company model', () {
    test('creates default instance', () {
      final company = Company(id: 'c1', name: 'TestCo');
      expect(company.id, 'c1');
      expect(company.name, 'TestCo');
      expect(company.isActive, true);
    });

    test('initials from single word', () {
      final company = Company(id: 'c1', name: 'Test');
      expect(company.initials, 'T');
    });

    test('initials from two words', () {
      final company = Company(id: 'c1', name: 'NorthStar Solutions');
      expect(company.initials, 'NS');
    });

    test('initials from multi word', () {
      final company = Company(id: 'c1', name: 'Bright Labs Inc');
      expect(company.initials, 'BL');
    });

    test('copyWith overrides fields', () {
      final original = Company(id: 'c1', name: 'Old', isActive: false);
      final updated = original.copyWith(name: 'New', isActive: true);
      expect(updated.name, 'New');
      expect(updated.isActive, true);
      expect(updated.id, 'c1');
    });

    test('equality based on id', () {
      final a = Company(id: 'c1', name: 'A');
      final b = Company(id: 'c1', name: 'B');
      expect(a, b);
    });

    test('equality differs for different ids', () {
      final a = Company(id: 'c1', name: 'A');
      final b = Company(id: 'c2', name: 'A');
      expect(a, isNot(b));
    });
  });

  group('MockCompanyRepository', () {
    late MockCompanyRepository repo;

    setUp(() {
      repo = MockCompanyRepository();
    });

    test('fetchCompanies returns seeded data', () async {
      final result = await repo.fetchCompanies();
      expect(result.isSuccess, true);
      expect(result.data!.length, 3);
    });

    test('fetchCompany returns correct company', () async {
      final result = await repo.fetchCompany('c1');
      expect(result.isSuccess, true);
      expect(result.data!.name, 'NorthStar Solutions');
    });

    test('fetchCompany returns failure for unknown id', () async {
      final result = await repo.fetchCompany('unknown');
      expect(result.isSuccess, false);
    });

    test('only active companies are returned', () async {
      final companies = await repo.fetchCompanies();
      final active = companies.data!.where((c) => c.isActive);
      expect(active.length, 2);
    });

    test('save and get active company id round-trips', () async {
      final saveResult = await repo.saveActiveCompanyId('c2');
      expect(saveResult.isSuccess, true);
      final getResult = await repo.getActiveCompanyId();
      expect(getResult.data, 'c2');
    });
  });
}
