import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/vendor.dart';

abstract class VendorRepository {
  Future<AppResult<List<Vendor>>> fetchVendors();
  Future<AppResult<Vendor>> createVendor(Vendor vendor);
  Future<AppResult<Vendor>> updateVendor(Vendor vendor);
  Future<AppResult<void>> deleteVendor(String id);
}

class MockVendorRepository implements VendorRepository {
  final List<Vendor> _vendors = [
    Vendor(
      id: 'VEN-1001',
      companyName: 'Northwind Supplies',
      contactName: 'Leila Farhadi',
      email: 'leila@northwind.example',
      phone: '+98 912 111 2233',
      address: 'Tehran, Iran',
      taxIdentifier: '124-456-789',
      notes: 'Preferred supplier for office materials',
      isActive: true,
      createdAt: DateTime(2026, 5, 12, 8, 30),
      updatedAt: DateTime(2026, 6, 2, 10, 15),
    ),
    Vendor(
      id: 'VEN-1002',
      companyName: 'Blue Harbor Services',
      contactName: 'Arman Keshavarz',
      email: 'arman@blueharbor.example',
      phone: '+98 913 222 3344',
      address: 'Isfahan, Iran',
      taxIdentifier: '987-654-321',
      notes: 'Consulting vendor',
      isActive: true,
      createdAt: DateTime(2026, 5, 25, 14, 0),
      updatedAt: DateTime(2026, 6, 10, 9, 45),
    ),
  ];

  @override
  Future<AppResult<List<Vendor>>> fetchVendors() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return AppResult.success(List<Vendor>.from(_vendors));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> createVendor(Vendor vendor) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _vendors.add(vendor);
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Vendor>> updateVendor(Vendor vendor) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _vendors.indexWhere((item) => item.id == vendor.id);
      if (index >= 0) {
        _vendors[index] = vendor;
      } else {
        _vendors.add(vendor);
      }
      return AppResult.success(vendor);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteVendor(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _vendors.removeWhere((item) => item.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
