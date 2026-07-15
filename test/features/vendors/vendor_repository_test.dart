import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:accounting_app/features/vendors/domain/vendor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockVendorRepository', () {
    late VendorRepository repository;

    setUp(() {
      repository = MockVendorRepository();
    });

    test('returns a successful result with vendor data', () async {
      final result = await repository.fetchVendors();

      expect(result, isA<AppResult<List<Vendor>>>());
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.error, isNull);
      expect(result.data!.first.companyName, isNotEmpty);
      expect(result.data!.first.createdAt, isA<DateTime>());
      expect(result.data!.first.updatedAt, isA<DateTime>());
    });
  });
}
