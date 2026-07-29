import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/customer_dao.dart';
import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/customers/data/drift_customer_repository.dart';
import 'package:accounting_app/features/customers/domain/customer.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const companyA = 'comp-1';
  const companyB = 'comp-2';

  Customer customer(String id, {String name = 'Test Customer'}) => Customer(
        id: id,
        name: name,
        company: 'Acme Co.',
        email: 'test@acme.co',
        phone: '+1 555 0001',
        outstandingBalance: 1000,
        status: 'Active',
        notes: 'Test customer',
      );

  group('MockCustomerRepository', () {
    test('returns seeded customers', () async {
      final result = await MockCustomerRepository().fetchCustomers();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });
  });

  group('DriftCustomerRepository (company-scoped)', () {
    late AppDatabase database;
    late DriftCustomerRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository = DriftCustomerRepository(
        database: database,
        companyId: () => companyA,
      );
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchCustomers returns empty list when none exist', () async {
      final result = await repository.fetchCustomers();

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('createCustomer inserts and returns the customer', () async {
      final createResult = await repository.createCustomer(customer('CUST-1'));
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchCustomers();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.id, 'CUST-1');
      expect(fetchResult.data!.first.name, 'Test Customer');
    });

    test('updateCustomer modifies an existing customer', () async {
      await repository.createCustomer(customer('CUST-2', name: 'Original'));

      final updateResult =
          await repository.updateCustomer(customer('CUST-2', name: 'Updated'));
      expect(updateResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchCustomers();
      expect(fetchResult.data!.single.name, 'Updated');
    });

    test('deleteCustomer removes a customer', () async {
      await repository.createCustomer(customer('CUST-3'));

      final deleteResult = await repository.deleteCustomer('CUST-3');
      expect(deleteResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchCustomers();
      expect(fetchResult.data, isEmpty);
    });

    test('domain mapping round-trips correctly', () async {
      final original = customer('CUST-4', name: 'Round Trip');

      await repository.createCustomer(original);
      final roundTripped = (await repository.fetchCustomers()).data!.single;

      expect(roundTripped.id, original.id);
      expect(roundTripped.name, original.name);
      expect(roundTripped.company, original.company);
      expect(roundTripped.email, original.email);
      expect(roundTripped.phone, original.phone);
      expect(roundTripped.outstandingBalance, original.outstandingBalance);
      expect(roundTripped.status, original.status);
      expect(roundTripped.notes, original.notes);
    });
  });

  group('DriftCustomerRepository tenant isolation', () {
    late AppDatabase database;
    late DriftCustomerRepository repoA;
    late DriftCustomerRepository repoB;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repoA = DriftCustomerRepository(
        database: database,
        companyId: () => companyA,
      );
      repoB = DriftCustomerRepository(
        database: database,
        companyId: () => companyB,
      );
    });

    tearDown(() async {
      await repoA.close();
    });

    test('reads only return records for the active company', () async {
      await repoA.createCustomer(customer('CUST-A1'));
      await repoB.createCustomer(customer('CUST-B1'));

      expect((await repoA.fetchCustomers()).data!.map((c) => c.id),
          ['CUST-A1']);
      expect((await repoB.fetchCustomers()).data!.map((c) => c.id),
          ['CUST-B1']);
    });

    test('writes persist the active company id', () async {
      await repoA.createCustomer(customer('CUST-A2'));

      final dao = CustomerDao(database);
      final row = await dao.getCustomerById('CUST-A2', companyA);
      expect(row!.companyId, companyA);
      expect(await dao.getCustomerById('CUST-A2', companyB), isNull);
    });

    test('cross-tenant update does not touch another company row', () async {
      await repoA.createCustomer(customer('CUST-SHARED', name: 'Owned by A'));

      final result = await repoB
          .updateCustomer(customer('CUST-SHARED', name: 'Hijacked by B'));
      expect(result.isSuccess, isTrue);

      expect((await repoA.fetchCustomers()).data!.single.name, 'Owned by A');
      expect((await repoB.fetchCustomers()).data, isEmpty);
    });

    test('cross-tenant delete does not remove another company row', () async {
      await repoA.createCustomer(customer('CUST-DEL'));

      expect((await repoB.deleteCustomer('CUST-DEL')).isSuccess, isTrue);
      expect((await repoA.fetchCustomers()).data!.single.id, 'CUST-DEL');
    });
  });

  group('DriftCustomerRepository fails closed without a company', () {
    late AppDatabase database;
    late DriftCustomerRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository = DriftCustomerRepository(database: database);
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchCustomers fails closed with TenantContextFailure', () async {
      final result = await repository.fetchCustomers();
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<TenantContextFailure>());
    });

    test('createCustomer fails closed and persists nothing', () async {
      final result = await repository.createCustomer(customer('CUST-NONE'));
      expect(result.error, isA<TenantContextFailure>());

      final dao = CustomerDao(database);
      expect(await dao.getAllCustomers('comp-1'), isEmpty);
      expect(await dao.getAllCustomers('comp-2'), isEmpty);
    });

    test('blank company id also fails closed', () async {
      final blank =
          DriftCustomerRepository(database: database, companyId: () => '');
      final result = await blank.fetchCustomers();
      expect(result.error, isA<TenantContextFailure>());
    });
  });
}
