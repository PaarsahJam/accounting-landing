import 'package:drift/drift.dart';
import 'app_database.dart';

class CompanyDao extends DatabaseAccessor<AppDatabase> {
  CompanyDao(super.db);

  $CompaniesTableTable get _companies => db.companiesTable;

  Future<List<CompaniesTableData>> getAllCompanies() =>
      (select(_companies)..where((t) => t.isActive.equals(true))).get();

  Future<CompaniesTableData?> getCompanyById(String id) =>
      (select(_companies)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertCompany(CompaniesTableCompanion company) =>
      into(_companies).insert(company);

  Future<int> updateCompany(CompaniesTableCompanion company) {
    final id = company.id.value;
    return (update(_companies)..where((t) => t.id.equals(id))).write(company);
  }
}
