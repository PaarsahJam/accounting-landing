// lib/features/fixed_assets/data/fixed_assets_repository.dart

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/fixed_asset.dart';

abstract class FixedAssetsRepository {
  Future<AppResult<List<FixedAsset>>> fetchAssets();

  Future<AppResult<FixedAsset>> createAsset(FixedAsset asset);

  Future<AppResult<FixedAsset>> updateAsset(FixedAsset asset);

  /// Marks the asset as disposed (inactive).
  Future<AppResult<FixedAsset>> disposeAsset(String id);

  /// Applies one period of depreciation to the asset and returns the updated record.
  Future<AppResult<FixedAsset>> calculateDepreciation(String id);

  /// Returns the full depreciation schedule for an asset.
  Future<AppResult<List<DepreciationEntry>>> fetchDepreciationSchedule(
    String id,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockFixedAssetsRepository implements FixedAssetsRepository {
  MockFixedAssetsRepository({AuditTrailRepository? auditRepository})
      : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<FixedAsset> _assets = [];
  int _idCounter = 6;

  String _nextId() => 'FA-${_idCounter.toString().padLeft(3, '0')}';

  void _seed() {
    final now = DateTime(2024, 1, 1);
    _assets.addAll([
      FixedAsset(
        id: 'FA-001',
        assetCode: 'FA-001',
        assetName: 'Office Computer',
        category: 'Equipment',
        purchaseDate: DateTime(2022, 6, 1),
        purchaseCost: 1500.0,
        salvageValue: 100.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
        accumulatedDepreciation: 560.0,
        isActive: true,
        notes: 'Main workstation',
      ),
      FixedAsset(
        id: 'FA-002',
        assetCode: 'FA-002',
        assetName: 'Office Furniture',
        category: 'Furniture',
        purchaseDate: DateTime(2021, 3, 15),
        purchaseCost: 3000.0,
        salvageValue: 200.0,
        usefulLifeYears: 10,
        depreciationMethod: DepreciationMethod.straightLine,
        accumulatedDepreciation: 840.0,
        isActive: true,
        notes: 'Desks, chairs and shelving',
      ),
      FixedAsset(
        id: 'FA-003',
        assetCode: 'FA-003',
        assetName: 'Company Vehicle',
        category: 'Vehicle',
        purchaseDate: DateTime(2023, 1, 10),
        purchaseCost: 25000.0,
        salvageValue: 5000.0,
        usefulLifeYears: 8,
        depreciationMethod: DepreciationMethod.decliningBalance,
        accumulatedDepreciation: 5000.0,
        isActive: true,
        notes: 'Sales team vehicle',
      ),
      FixedAsset(
        id: 'FA-004',
        assetCode: 'FA-004',
        assetName: 'Printer',
        category: 'Equipment',
        purchaseDate: DateTime(2020, 9, 1),
        purchaseCost: 800.0,
        salvageValue: 50.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
        accumulatedDepreciation: 750.0,
        isActive: false,
        notes: 'Fully depreciated and disposed',
      ),
      FixedAsset(
        id: 'FA-005',
        assetCode: 'FA-005',
        assetName: 'Network Equipment',
        category: 'Equipment',
        purchaseDate: now,
        purchaseCost: 2000.0,
        salvageValue: 200.0,
        usefulLifeYears: 5,
        depreciationMethod: DepreciationMethod.straightLine,
        accumulatedDepreciation: 0.0,
        isActive: true,
        notes: 'Router, switches and access points',
      ),
    ]);
  }

  @override
  Future<AppResult<List<FixedAsset>>> fetchAssets() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_assets));
  }

  @override
  Future<AppResult<FixedAsset>> createAsset(FixedAsset asset) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final id = _nextId();
    _idCounter++;
    final created = asset.copyWith(id: id, assetCode: id);
    _assets.add(created);

    await _audit.addEntry(AuditEntry(
      id: 'AUD-FA-CREATE-$id',
      entityType: AuditEntityType.financialReport,
      entityId: id,
      entityLabel: created.assetName,
      action: AuditAction.created,
      performedAt: DateTime.now(),
      performedBy: 'system',
      note: 'Fixed asset created',
    ));

    return AppResult.success(created);
  }

  @override
  Future<AppResult<FixedAsset>> updateAsset(FixedAsset asset) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _assets.indexWhere((a) => a.id == asset.id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Fixed asset not found'),
      );
    }
    _assets[idx] = asset;

    await _audit.addEntry(AuditEntry(
      id: 'AUD-FA-EDIT-${asset.id}',
      entityType: AuditEntityType.financialReport,
      entityId: asset.id,
      entityLabel: asset.assetName,
      action: AuditAction.edited,
      performedAt: DateTime.now(),
      performedBy: 'system',
      note: 'Fixed asset updated',
    ));

    return AppResult.success(asset);
  }

  @override
  Future<AppResult<FixedAsset>> disposeAsset(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _assets.indexWhere((a) => a.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Fixed asset not found'),
      );
    }
    final disposed = _assets[idx].copyWith(isActive: false);
    _assets[idx] = disposed;

    await _audit.addEntry(AuditEntry(
      id: 'AUD-FA-DISPOSE-$id',
      entityType: AuditEntityType.financialReport,
      entityId: id,
      entityLabel: disposed.assetName,
      action: AuditAction.cancelled,
      performedAt: DateTime.now(),
      performedBy: 'system',
      note: 'Fixed asset disposed',
    ));

    return AppResult.success(disposed);
  }

  @override
  Future<AppResult<FixedAsset>> calculateDepreciation(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final idx = _assets.indexWhere((a) => a.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Fixed asset not found'),
      );
    }
    final asset = _assets[idx];
    if (!asset.isActive) {
      return AppResult.failure(
        const UnknownFailure(
          message: 'Cannot depreciate a disposed asset',
        ),
      );
    }

    final charge = _annualCharge(asset);
    final newAccumulated =
        (asset.accumulatedDepreciation + charge).clamp(
      0.0,
      asset.purchaseCost - asset.salvageValue,
    );
    final updated = asset.copyWith(accumulatedDepreciation: newAccumulated);
    _assets[idx] = updated;

    await _audit.addEntry(AuditEntry(
      id: 'AUD-FA-DEPR-$id-${DateTime.now().millisecondsSinceEpoch}',
      entityType: AuditEntityType.financialReport,
      entityId: id,
      entityLabel: asset.assetName,
      action: AuditAction.edited,
      performedAt: DateTime.now(),
      performedBy: 'system',
      note: 'Depreciation applied: $charge',
      previousValue: asset.accumulatedDepreciation.toStringAsFixed(2),
      newValue: newAccumulated.toStringAsFixed(2),
    ));

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<List<DepreciationEntry>>> fetchDepreciationSchedule(
    String id,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final asset = _assets.firstWhere(
      (a) => a.id == id,
      orElse: () => throw StateError('Not found'),
    );

    final schedule = <DepreciationEntry>[];
    double bookValue = asset.purchaseCost;
    double accumulated = 0.0;

    for (var year = 1; year <= asset.usefulLifeYears; year++) {
      final charge = _annualCharge(asset, currentBookValue: bookValue).clamp(
        0.0,
        bookValue - asset.salvageValue,
      );
      accumulated += charge;
      schedule.add(DepreciationEntry(
        year: year,
        openingBookValue: bookValue,
        depreciationCharge: charge,
        accumulatedDepreciation: accumulated,
        closingBookValue: bookValue - charge,
      ));
      bookValue -= charge;
      if (bookValue <= asset.salvageValue) break;
    }

    return AppResult.success(List.unmodifiable(schedule));
  }

  double _annualCharge(
    FixedAsset asset, {
    double? currentBookValue,
  }) {
    switch (asset.depreciationMethod) {
      case DepreciationMethod.straightLine:
        return (asset.purchaseCost - asset.salvageValue) / asset.usefulLifeYears;
      case DepreciationMethod.decliningBalance:
        final bv = currentBookValue ?? asset.bookValue;
        final rate = 2.0 / asset.usefulLifeYears;
        return bv * rate;
    }
  }
}
