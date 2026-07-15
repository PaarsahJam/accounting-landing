import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository.dart';
import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository_provider.dart';
import 'package:accounting_app/features/vendor_statements/domain/vendor_statements_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VendorStatementsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          vendorStatementsRepositoryProvider.overrideWithValue(
            MockVendorStatementsRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads vendor statements successfully', () async {
      final controller = container.read(
        vendorStatementsControllerProvider.notifier,
      );
      final statements = await controller.future;

      expect(statements, isNotEmpty);
      expect(statements.first.vendorName, isNotEmpty);
    });
  });
}
