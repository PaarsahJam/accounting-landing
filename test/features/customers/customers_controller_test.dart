import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/customer_dao.dart';
import 'package:accounting_app/features/customers/data/customer_repository_provider.dart';
import 'package:accounting_app/features/customers/data/drift_customer_repository.dart';
import 'package:accounting_app/features/customers/domain/customers_controller.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomersController', () {
    late ProviderContainer container;
    late AppDatabase database;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      container = ProviderContainer(
        overrides: [
          customerRepositoryProvider.overrideWithValue(
            DriftCustomerRepository(database: database),
          ),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await database.close();
    });

    test('loads customers successfully', () async {
      final dao = CustomerDao(database);
      await dao.insertCustomer(CustomersTableCompanion.insert(
        id: 'CUST-1001',
        name: 'Ava Rahimi',
        company: 'Northstar Co.',
        email: 'ava@northstar.co',
        phone: '+98 912 000 0001',
        outstandingBalance: 2450000,
        status: 'Active',
        notes: 'Preferred for monthly invoicing',
      ));

      final controller = container.read(customersControllerProvider.notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.name, 'Ava Rahimi');
    });
  });
}
