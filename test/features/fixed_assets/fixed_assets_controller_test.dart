// test/features/fixed_assets/fixed_assets_controller_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/fixed_assets/data/fixed_assets_repository.dart';
import 'package:accounting_app/features/fixed_assets/data/fixed_assets_repository_provider.dart';
import 'package:accounting_app/features/fixed_assets/domain/fixed_asset.dart';
import 'package:accounting_app/features/fixed_assets/domain/fixed_assets_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    fixedAssetsRepositoryProvider.overrideWithValue(
      MockFixedAssetsRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

final _purchaseDate = DateTime(2022, 1, 1);

void main() {
  group('FixedAssetsController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads 5 seeded assets', () async {
      container.listen(fixedAssetsControllerProvider, (_, _) {});
      final assets = await container.read(fixedAssetsControllerProvider.future);
      expect(assets.length, equals(5));
    });

    test('createAsset adds asset to state', () async {
      container.listen(fixedAssetsControllerProvider, (_, _) {});
      final notifier = container.read(fixedAssetsControllerProvider.notifier);
      await notifier.future;

      final asset = FixedAsset(
        id: '',
        assetCode: '',
        assetName: 'New Asset',
        category: 'Equipment',
        purchaseDate: _purchaseDate,
        purchaseCost: 1000.0,
        salvageValue: 100.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
      );
      final result = await notifier.createAsset(asset);
      expect(result!.isSuccess, isTrue);

      final state = container.read(fixedAssetsControllerProvider).value!;
      expect(state.any((a) => a.assetName == 'New Asset'), isTrue);
      expect(state.length, equals(6));
    });

    test('updateAsset replaces item in state', () async {
      container.listen(fixedAssetsControllerProvider, (_, _) {});
      final notifier = container.read(fixedAssetsControllerProvider.notifier);
      final initial = await notifier.future;
      final target = initial.first;
      final renamed = target.copyWith(assetName: 'Renamed');

      final result = await notifier.updateAsset(renamed);
      expect(result!.isSuccess, isTrue);

      final state = container.read(fixedAssetsControllerProvider).value!;
      expect(
        state.firstWhere((a) => a.id == target.id).assetName,
        equals('Renamed'),
      );
    });

    test('disposeAsset sets isActive to false in state', () async {
      container.listen(fixedAssetsControllerProvider, (_, _) {});
      final notifier = container.read(fixedAssetsControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.disposeAsset('FA-001');
      expect(success, isTrue);

      final state = container.read(fixedAssetsControllerProvider).value!;
      expect(state.firstWhere((a) => a.id == 'FA-001').isActive, isFalse);
    });

    test(
      'calculateDepreciation increases accumulated depreciation in state',
      () async {
        container.listen(fixedAssetsControllerProvider, (_, _) {});
        final notifier = container.read(fixedAssetsControllerProvider.notifier);
        final initial = await notifier.future;
        final prev = initial
            .firstWhere((a) => a.id == 'FA-005')
            .accumulatedDepreciation;

        final success = await notifier.calculateDepreciation('FA-005');
        expect(success, isTrue);

        final state = container.read(fixedAssetsControllerProvider).value!;
        expect(
          state.firstWhere((a) => a.id == 'FA-005').accumulatedDepreciation,
          greaterThan(prev),
        );
      },
    );

    test('disposeAsset returns false for unknown id', () async {
      container.listen(fixedAssetsControllerProvider, (_, _) {});
      final notifier = container.read(fixedAssetsControllerProvider.notifier);
      await notifier.future;
      final success = await notifier.disposeAsset('NO-SUCH');
      expect(success, isFalse);
    });
  });
}
