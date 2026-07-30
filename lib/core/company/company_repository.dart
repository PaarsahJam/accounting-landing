import '../errors/app_failure.dart';
import '../errors/app_result.dart';
import 'company.dart';

abstract class CompanyRepository {
  Future<AppResult<List<Company>>> fetchCompanies();

  Future<AppResult<Company>> fetchCompany(String id);

  Future<AppResult<Company>> createCompany(Company company);

  Future<AppResult<void>> saveActiveCompanyId(String companyId);

  Future<AppResult<String?>> getActiveCompanyId();
}

class MockCompanyRepository implements CompanyRepository {
  final List<Company> _companies = [
    const Company(
      id: 'comp-1',
      name: 'NorthStar Solutions',
      legalName: 'NorthStar Solutions Ltd.',
      taxId: 'IR-123456789',
      currency: 'IRR',
      fiscalYearStartMonth: '3',
      isActive: true,
    ),
    const Company(
      id: 'comp-2',
      name: 'Bright Labs',
      legalName: 'Bright Laboratories Inc.',
      taxId: 'IR-987654321',
      currency: 'IRR',
      fiscalYearStartMonth: '1',
      isActive: true,
    ),
    const Company(
      id: 'comp-3',
      name: 'Aria Tech',
      legalName: 'Aria Technology Group',
      taxId: 'IR-456789123',
      currency: 'USD',
      fiscalYearStartMonth: '4',
      isActive: false,
    ),
  ];

  String? _activeCompanyId;

  @override
  Future<AppResult<List<Company>>> fetchCompanies() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return AppResult.success(
        _companies.where((c) => c.isActive).toList(),
      );
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<Company>> fetchCompany(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final company = _companies.firstWhere(
        (c) => c.id == id,
        orElse: () => throw Exception('Company not found: $id'),
      );
      return AppResult.success(company);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<Company>> createCompany(Company company) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _companies.add(company);
      _activeCompanyId = company.id;
      return AppResult.success(company);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<void>> saveActiveCompanyId(String companyId) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _activeCompanyId = companyId;
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<AppResult<String?>> getActiveCompanyId() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return AppResult.success(_activeCompanyId);
    } catch (error) {
      return AppResult.failure(
        UnknownFailure(message: error.toString()),
      );
    }
  }
}
