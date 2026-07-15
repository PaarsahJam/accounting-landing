import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository_provider.dart';
import 'package:accounting_app/features/vendors/domain/vendors_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VendorsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          vendorRepositoryProvider.overrideWithValue(MockVendorRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads vendors successfully', () async {
      final controller = container.read(vendorsControllerProvider.notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.companyName, isNotEmpty);
    });
  });
}
