import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/vendor_dao.dart';
import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/vendors/data/drift_vendor_repository.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:accounting_app/features/vendors/domain/vendor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const companyA = 'comp-1';
  const companyB = 'comp-2';

  Vendor vendor(String id, {String companyName = 'Test Company'}) => Vendor(
        id: id,
        companyName: companyName,
        contactName: 'John Doe',
        email: 'john@test.com',
        phone: '+1 555 0001',
        address: '123 Test St',
        taxIdentifier: 'TX-001',
        notes: 'Test vendor',
        isActive: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      );

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

  group('DriftVendorRepository (company-scoped)', () {
    late AppDatabase database;
    late DriftVendorRepository repository;

    setUp(() {
      database =
          AppDatabase.withExecutor(NativeDatabase.memory());
      repository =
          DriftVendorRepository(database: database, companyId: () => companyA);
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchVendors returns empty list when no vendors exist', () async {
      final result = await repository.fetchVendors();

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('createVendor inserts and returns the vendor', () async {
      final createResult = await repository.createVendor(vendor('VEN-2001'));
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchVendors();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.id, 'VEN-2001');
      expect(fetchResult.data!.first.companyName, 'Test Company');
      expect(fetchResult.data!.first.isActive, isTrue);
      expect(fetchResult.data!.first.createdAt, DateTime(2026, 1, 1));
    });

    test('updateVendor modifies an existing vendor', () async {
      await repository.createVendor(vendor('VEN-2002', companyName: 'Original'));

      final updated = vendor('VEN-2002').copyWith(
        companyName: 'Updated Co',
        isActive: false,
        updatedAt: DateTime(2026, 3, 1),
      );
      final updateResult = await repository.updateVendor(updated);
      expect(updateResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchVendors();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.companyName, 'Updated Co');
      expect(fetchResult.data!.first.isActive, isFalse);
    });

    test('deleteVendor removes a vendor', () async {
      await repository.createVendor(vendor('VEN-2003'));

      final deleteResult = await repository.deleteVendor('VEN-2003');
      expect(deleteResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchVendors();
      expect(fetchResult.data, isEmpty);
    });

    test('getVendorById returns the correct vendor within the company',
        () async {
      final dao = VendorDao(database);
      await dao.insertVendor(VendorsTableCompanion.insert(
        id: 'VEN-2004',
        companyId: companyA,
        companyName: 'Single Co',
        contactName: 'Alice',
        email: 'alice@single.com',
        phone: '+1 555 0004',
        address: '321 Elm St',
        taxIdentifier: 'TX-004',
        notes: '',
        isActive: true,
        createdAt: DateTime(2026, 4, 1),
        updatedAt: DateTime(2026, 4, 1),
      ));

      final entry = await dao.getVendorById('VEN-2004', companyA);
      expect(entry, isNotNull);
      expect(entry!.id, 'VEN-2004');
      expect(entry.companyName, 'Single Co');
      expect(entry.companyId, companyA);
    });

    test('domain mapping round-trips correctly', () async {
      final now = DateTime(2026, 6, 15, 10, 30, 0);
      final original = vendor('VEN-3001', companyName: 'Round Trip Co').copyWith(
        contactName: 'Charlie',
        email: 'charlie@roundtrip.com',
        phone: '+1 555 3001',
        address: '999 Main St',
        taxIdentifier: 'TX-3001',
        notes: 'Round-trip test',
        createdAt: now,
        updatedAt: now,
      );

      await repository.createVendor(original);
      final fetched = await repository.fetchVendors();
      final roundTripped = fetched.data!.first;

      expect(roundTripped.id, original.id);
      expect(roundTripped.companyName, original.companyName);
      expect(roundTripped.contactName, original.contactName);
      expect(roundTripped.email, original.email);
      expect(roundTripped.phone, original.phone);
      expect(roundTripped.address, original.address);
      expect(roundTripped.taxIdentifier, original.taxIdentifier);
      expect(roundTripped.notes, original.notes);
      expect(roundTripped.isActive, original.isActive);
      expect(roundTripped.createdAt, original.createdAt);
      expect(roundTripped.updatedAt, original.updatedAt);
    });
  });

  group('DriftVendorRepository tenant isolation', () {
    late AppDatabase database;
    late DriftVendorRepository repoA;
    late DriftVendorRepository repoB;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repoA =
          DriftVendorRepository(database: database, companyId: () => companyA);
      repoB =
          DriftVendorRepository(database: database, companyId: () => companyB);
    });

    tearDown(() async {
      await repoA.close();
    });

    test('reads only return records for the active company', () async {
      await repoA.createVendor(vendor('VEN-A1'));
      await repoB.createVendor(vendor('VEN-B1'));

      expect((await repoA.fetchVendors()).data!.map((v) => v.id), ['VEN-A1']);
      expect((await repoB.fetchVendors()).data!.map((v) => v.id), ['VEN-B1']);
    });

    test('writes persist the active company id', () async {
      await repoA.createVendor(vendor('VEN-A2'));

      final dao = VendorDao(database);
      final row = await dao.getVendorById('VEN-A2', companyA);
      expect(row!.companyId, companyA);
      expect(await dao.getVendorById('VEN-A2', companyB), isNull);
    });

    test('cross-tenant update does not touch another company row', () async {
      await repoA.createVendor(vendor('VEN-SHARED', companyName: 'Owned by A'));

      final result = await repoB
          .updateVendor(vendor('VEN-SHARED', companyName: 'Hijacked by B'));
      expect(result.isSuccess, isTrue);

      expect((await repoA.fetchVendors()).data!.single.companyName, 'Owned by A');
      expect((await repoB.fetchVendors()).data, isEmpty);
    });

    test('cross-tenant delete does not remove another company row', () async {
      await repoA.createVendor(vendor('VEN-DEL'));

      expect((await repoB.deleteVendor('VEN-DEL')).isSuccess, isTrue);
      expect((await repoA.fetchVendors()).data!.single.id, 'VEN-DEL');
    });
  });

  group('DriftVendorRepository fails closed without a company', () {
    late AppDatabase database;
    late DriftVendorRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository = DriftVendorRepository(database: database);
    });

    tearDown(() async {
      await repository.close();
    });

    test('fetchVendors fails closed with TenantContextFailure', () async {
      final result = await repository.fetchVendors();
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<TenantContextFailure>());
    });

    test('createVendor fails closed and persists nothing', () async {
      final result = await repository.createVendor(vendor('VEN-NONE'));
      expect(result.error, isA<TenantContextFailure>());

      final dao = VendorDao(database);
      expect(await dao.getAllVendors('comp-1'), isEmpty);
      expect(await dao.getAllVendors('comp-2'), isEmpty);
    });
  });
}
