// test/features/fixed_assets/fixed_assets_repository_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/fixed_assets/data/fixed_assets_repository.dart';
import 'package:accounting_app/features/fixed_assets/domain/fixed_asset.dart';
import 'package:flutter_test/flutter_test.dart';

MockFixedAssetsRepository _makeRepo() =>
    MockFixedAssetsRepository(auditRepository: MockAuditTrailRepository());

final _purchaseDate = DateTime(2022, 1, 1);

void main() {
  group('MockFixedAssetsRepository', () {
    test('fetchAssets returns 5 seeded assets', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAssets();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(5));
    });

    test('seeded assets include Office Computer', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAssets();
      expect(
        result.data!.any((a) => a.assetName == 'Office Computer'),
        isTrue,
      );
    });

    test('4 active and 1 disposed in seed', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAssets();
      expect(result.data!.where((a) => a.isActive).length, equals(4));
      expect(result.data!.where((a) => !a.isActive).length, equals(1));
    });

    test('createAsset adds asset and assigns id', () async {
      final repo = _makeRepo();
      final asset = FixedAsset(
        id: '',
        assetCode: '',
        assetName: 'Test Asset',
        category: 'Equipment',
        purchaseDate: _purchaseDate,
        purchaseCost: 500.0,
        salvageValue: 50.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
      );
      final result = await repo.createAsset(asset);
      expect(result.isSuccess, isTrue);
      expect(result.data!.id, isNotEmpty);
      expect(result.data!.assetName, equals('Test Asset'));

      final all = (await repo.fetchAssets()).data!;
      expect(all.length, equals(6));
    });

    test('updateAsset persists changes', () async {
      final repo = _makeRepo();
      final orig = (await repo.fetchAssets()).data!.first;
      final updated = orig.copyWith(assetName: 'Renamed Asset');

      final result = await repo.updateAsset(updated);
      expect(result.isSuccess, isTrue);

      final after = (await repo.fetchAssets()).data!;
      expect(
        after.firstWhere((a) => a.id == orig.id).assetName,
        equals('Renamed Asset'),
      );
    });

    test('updateAsset fails for unknown id', () async {
      final repo = _makeRepo();
      final fake = FixedAsset(
        id: 'NO-SUCH',
        assetCode: 'x',
        assetName: 'x',
        category: 'x',
        purchaseDate: _purchaseDate,
        purchaseCost: 1.0,
        salvageValue: 0.0,
        usefulLifeYears: 1,
        depreciationMethod: DepreciationMethod.straightLine,
      );
      final result = await repo.updateAsset(fake);
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('disposeAsset sets isActive to false', () async {
      final repo = _makeRepo();
      final result = await repo.disposeAsset('FA-001');
      expect(result.isSuccess, isTrue);
      expect(result.data!.isActive, isFalse);
    });

    test('disposeAsset fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.disposeAsset('NO-SUCH');
      expect(result.isSuccess, isFalse);
    });

    test('calculateDepreciation increases accumulatedDepreciation', () async {
      final repo = _makeRepo();
      final before =
          (await repo.fetchAssets()).data!.firstWhere((a) => a.id == 'FA-005');
      expect(before.accumulatedDepreciation, equals(0.0));

      final result = await repo.calculateDepreciation('FA-005');
      expect(result.isSuccess, isTrue);
      expect(result.data!.accumulatedDepreciation, greaterThan(0.0));
    });

    test('calculateDepreciation fails for disposed asset', () async {
      final repo = _makeRepo();
      // FA-004 is seeded as inactive/disposed
      final result = await repo.calculateDepreciation('FA-004');
      expect(result.isSuccess, isFalse);
    });

    test('fetchDepreciationSchedule returns schedule with correct year count',
        () async {
      final repo = _makeRepo();
      final result = await repo.fetchDepreciationSchedule('FA-001');
      expect(result.isSuccess, isTrue);
      expect(result.data!, isNotEmpty);
      expect(result.data!.first.year, equals(1));
    });

    test('straight-line schedule has equal annual charges', () async {
      final repo = _makeRepo();
      // FA-005: SL, cost=2000, salvage=200, life=5 → charge=360/yr
      final result = await repo.fetchDepreciationSchedule('FA-005');
      final entries = result.data!;
      expect(entries.length, equals(5));
      for (final e in entries) {
        expect(e.depreciationCharge, closeTo(360.0, 0.01));
      }
    });
  });

  group('FixedAsset model', () {
    test('bookValue = purchaseCost - accumulatedDepreciation', () {
      final asset = FixedAsset(
        id: 'FA-T',
        assetCode: 'FA-T',
        assetName: 'Test',
        category: 'X',
        purchaseDate: _purchaseDate,
        purchaseCost: 1000.0,
        salvageValue: 100.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
        accumulatedDepreciation: 400.0,
      );
      expect(asset.bookValue, equals(600.0));
    });

    test('annualDepreciation is straight-line amount', () {
      final asset = FixedAsset(
        id: 'FA-T',
        assetCode: 'FA-T',
        assetName: 'Test',
        category: 'X',
        purchaseDate: _purchaseDate,
        purchaseCost: 1000.0,
        salvageValue: 0.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
      );
      expect(asset.annualDepreciation, equals(200.0));
    });

    test('equality is by id', () {
      final a = FixedAsset(
        id: 'FA-1',
        assetCode: 'FA-1',
        assetName: 'A',
        category: 'X',
        purchaseDate: _purchaseDate,
        purchaseCost: 1.0,
        salvageValue: 0.0,
        usefulLifeYears: 1,
        depreciationMethod: DepreciationMethod.straightLine,
      );
      final b = FixedAsset(
        id: 'FA-1',
        assetCode: 'FA-1',
        assetName: 'B',
        category: 'Y',
        purchaseDate: _purchaseDate,
        purchaseCost: 2.0,
        salvageValue: 0.0,
        usefulLifeYears: 2,
        depreciationMethod: DepreciationMethod.decliningBalance,
      );
      expect(a, equals(b));
    });

    test('copyWith preserves unchanged fields', () {
      final orig = FixedAsset(
        id: 'FA-1',
        assetCode: 'FA-1',
        assetName: 'Original',
        category: 'Equipment',
        purchaseDate: _purchaseDate,
        purchaseCost: 500.0,
        salvageValue: 50.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
        isActive: true,
      );
      final copy = orig.copyWith(isActive: false);
      expect(copy.assetName, equals('Original'));
      expect(copy.purchaseCost, equals(500.0));
      expect(copy.isActive, isFalse);
    });
  });

  group('DepreciationMethod', () {
    test('all values have non-empty labels', () {
      for (final m in DepreciationMethod.values) {
        expect(m.label, isNotEmpty);
      }
    });
  });
}
