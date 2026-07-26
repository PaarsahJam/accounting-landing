import '../../../core/database/app_database.dart';
import '../../../core/database/vendor_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/vendor.dart';
import 'vendor_repository.dart';

class DriftVendorRepository implements VendorRepository {
  final AppDatabase _database;
  late final VendorDao _dao;

  DriftVendorRepository({AppDatabase? database})
      : _database = database ?? AppDatabase() {
    _dao = VendorDao(_database);
  }

  @override
  Future<AppResult<List<Vendor>>> fetchVendors() async {
    try {
      final entries = await _dao.getAllVendors();
      return AppResult.success(entries.map(_toDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> createVendor(Vendor vendor) async {
    try {
      final companion = _toCompanion(vendor);
      await _dao.insertVendor(companion);
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> updateVendor(Vendor vendor) async {
    try {
      final companion = _toCompanion(vendor);
      await _dao.updateVendor(companion);
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteVendor(String id) async {
    try {
      await _dao.deleteVendor(id);
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

  VendorsTableCompanion _toCompanion(Vendor vendor) {
    return VendorsTableCompanion.insert(
      id: vendor.id,
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