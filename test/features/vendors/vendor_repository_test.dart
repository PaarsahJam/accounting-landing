import 'package:accounting_app/core/database/app_database.dart';
import 'package:accounting_app/core/database/vendor_dao.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/vendors/data/drift_vendor_repository.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:accounting_app/features/vendors/domain/vendor.dart';
import 'package:drift/native.dart';
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

  group('DriftVendorRepository', () {
    late AppDatabase database;
    late DriftVendorRepository repository;

    setUp(() {
      database = AppDatabase.withExecutor(NativeDatabase.memory());
      repository = DriftVendorRepository(database: database);
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
      final vendor = Vendor(
        id: 'VEN-2001',
        companyName: 'Test Company',
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

      final createResult = await repository.createVendor(vendor);
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchVendors();
      expect(fetchResult.data!.length, 1);
      expect(fetchResult.data!.first.id, 'VEN-2001');
      expect(fetchResult.data!.first.companyName, 'Test Company');
      expect(fetchResult.data!.first.isActive, isTrue);
      expect(fetchResult.data!.first.createdAt, vendor.createdAt);
    });

    test('updateVendor modifies an existing vendor', () async {
      final vendor = Vendor(
        id: 'VEN-2002',
        companyName: 'Original Co',
        contactName: 'Jane Smith',
        email: 'jane@original.com',
        phone: '+1 555 0002',
        address: '456 Oak Ave',
        taxIdentifier: 'TX-002',
        notes: 'Original',
        isActive: true,
        createdAt: DateTime(2026, 2, 1),
        updatedAt: DateTime(2026, 2, 1),
      );
      await repository.createVendor(vendor);

      final updated = vendor.copyWith(
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
      final vendor = Vendor(
        id: 'VEN-2003',
        companyName: 'Delete Me',
        contactName: 'Bob',
        email: 'bob@delete.com',
        phone: '+1 555 0003',
        address: '789 Pine Rd',
        taxIdentifier: 'TX-003',
        notes: '',
        isActive: true,
        createdAt: DateTime(2026, 3, 1),
        updatedAt: DateTime(2026, 3, 1),
      );
      await repository.createVendor(vendor);

      final deleteResult = await repository.deleteVendor('VEN-2003');
      expect(deleteResult.isSuccess, isTrue);

      final fetchResult = await repository.fetchVendors();
      expect(fetchResult.data, isEmpty);
    });

    test('getVendorById returns the correct vendor', () async {
      final dao = VendorDao(database);
      await dao.insertVendor(VendorsTableCompanion.insert(
        id: 'VEN-2004',
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

      final entries = await dao.getAllVendors();
      expect(entries.length, 1);
      expect(entries.first.id, 'VEN-2004');
      expect(entries.first.companyName, 'Single Co');
      expect(entries.first.isActive, isTrue);
    });

    test('domain mapping round-trips correctly', () async {
      final now = DateTime(2026, 6, 15, 10, 30, 0);
      final original = Vendor(
        id: 'VEN-3001',
        companyName: 'Round Trip Co',
        contactName: 'Charlie',
        email: 'charlie@roundtrip.com',
        phone: '+1 555 3001',
        address: '999 Main St',
        taxIdentifier: 'TX-3001',
        notes: 'Round-trip test',
        isActive: true,
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
}
