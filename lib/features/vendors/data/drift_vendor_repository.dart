import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/vendor_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/vendor.dart';
import 'vendor_repository.dart';

/// Tenant-scoped Drift implementation of [VendorRepository]. See
/// [DriftCustomerRepository] for the resolver / fail-closed contract.
class DriftVendorRepository implements VendorRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final VendorDao _dao;

  DriftVendorRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = VendorDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<Vendor>>> fetchVendors() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllVendors(companyId);
      return AppResult.success(entries.map(_toDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> createVendor(Vendor vendor) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertVendor(_toCompanion(vendor, companyId));
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> updateVendor(Vendor vendor) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateVendor(_toCompanion(vendor, companyId), companyId);
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteVendor(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteVendor(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  Vendor _toDomain(VendorsTableData entry) {
    return Vendor(
      id: entry.id,
      companyName: entry.companyName,
      contactName: entry.contactName,
      email: entry.email,
      phone: entry.phone,
      address: entry.address,
      taxIdentifier: entry.taxIdentifier,
      notes: entry.notes,
      isActive: entry.isActive,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }

  VendorsTableCompanion _toCompanion(Vendor vendor, String companyId) {
    return VendorsTableCompanion.insert(
      id: vendor.id,
      companyId: companyId,
      companyName: vendor.companyName,
      contactName: vendor.contactName,
      email: vendor.email,
      phone: vendor.phone,
      address: vendor.address,
      taxIdentifier: vendor.taxIdentifier,
      notes: vendor.notes,
      isActive: vendor.isActive,
      createdAt: vendor.createdAt,
      updatedAt: vendor.updatedAt,
    );
  }
}
