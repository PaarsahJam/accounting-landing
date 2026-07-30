import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/company_dao.dart';
import '../errors/app_failure.dart';
import '../errors/app_result.dart';
import '../storage/secure_storage.dart';
import 'company.dart';
import 'company_repository.dart';

class DriftCompanyRepository implements CompanyRepository {
  final AppDatabase _database;
  final SecureStorage _secureStorage;
  late final CompanyDao _dao;

  static const _activeCompanyKey = 'active_company_id';

  DriftCompanyRepository({
    AppDatabase? database,
    SecureStorage? secureStorage,
  })  : _database = database ?? AppDatabase(),
        _secureStorage = secureStorage ?? SecureStorage.instance {
    _dao = CompanyDao(_database);
  }

  @override
  Future<AppResult<List<Company>>> fetchCompanies() async {
    try {
      final entries = await _dao.getAllCompanies();
      return AppResult.success(entries.map(_toCompany).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Company>> fetchCompany(String id) async {
    try {
      final entry = await _dao.getCompanyById(id);
      if (entry == null) {
        return AppResult.failure(
          UnknownFailure(message: 'Company not found: $id'),
        );
      }
      return AppResult.success(_toCompany(entry));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Company>> createCompany(Company company) async {
    try {
      await _dao.insertCompany(CompaniesTableCompanion.insert(
        id: company.id,
        name: company.name,
        legalName: Value(company.legalName),
        taxId: Value(company.taxId),
        currency: Value(company.currency),
        fiscalYearStartMonth: Value(company.fiscalYearStartMonth),
        isActive: true,
        createdAt: DateTime.now(),
      ));
      await _secureStorage.write(_activeCompanyKey, company.id);
      return AppResult.success(company);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> saveActiveCompanyId(String companyId) async {
    try {
      await _secureStorage.write(_activeCompanyKey, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<String?>> getActiveCompanyId() async {
    try {
      final id = await _secureStorage.read(_activeCompanyKey);
      return AppResult.success(id);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Company _toCompany(CompaniesTableData data) => Company(
        id: data.id,
        name: data.name,
        legalName: data.legalName,
        taxId: data.taxId,
        currency: data.currency,
        fiscalYearStartMonth: data.fiscalYearStartMonth,
        isActive: data.isActive,
      );
}
