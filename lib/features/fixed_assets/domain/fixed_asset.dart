// lib/features/fixed_assets/domain/fixed_asset.dart

/// Depreciation method supported by the system.
enum DepreciationMethod {
  straightLine,
  decliningBalance;

  String get label {
    switch (this) {
      case DepreciationMethod.straightLine:
        return 'Straight Line';
      case DepreciationMethod.decliningBalance:
        return 'Declining Balance';
    }
  }
}

/// A single fixed asset record.
class FixedAsset {
  const FixedAsset({
    required this.id,
    required this.assetCode,
    required this.assetName,
    required this.category,
    required this.purchaseDate,
    required this.purchaseCost,
    required this.salvageValue,
    required this.usefulLifeYears,
    required this.depreciationMethod,
    this.accumulatedDepreciation = 0.0,
    this.isActive = true,
    this.notes,
  });

  final String id;

  /// Short unique code (e.g. `'FA-001'`).
  final String assetCode;

  /// Human-readable name.
  final String assetName;

  /// Asset category (e.g. `'Equipment'`, `'Furniture'`).
  final String category;

  /// Date the asset was purchased.
  final DateTime purchaseDate;

  /// Original purchase cost.
  final double purchaseCost;

  /// Residual/salvage value at end of useful life.
  final double salvageValue;

  /// Useful life in years.
  final int usefulLifeYears;

  /// Which depreciation method to use.
  final DepreciationMethod depreciationMethod;

  /// Accumulated depreciation to date.
  final double accumulatedDepreciation;

  /// `false` once the asset has been disposed.
  final bool isActive;

  /// Optional notes.
  final String? notes;

  /// Current book value = purchaseCost − accumulatedDepreciation.
  double get bookValue => purchaseCost - accumulatedDepreciation;

  /// Annual straight-line depreciation charge.
  double get annualDepreciation =>
      (purchaseCost - salvageValue) / usefulLifeYears;

  FixedAsset copyWith({
    String? id,
    String? assetCode,
    String? assetName,
    String? category,
    DateTime? purchaseDate,
    double? purchaseCost,
    double? salvageValue,
    int? usefulLifeYears,
    DepreciationMethod? depreciationMethod,
    double? accumulatedDepreciation,
    bool? isActive,
    String? notes,
  }) {
    return FixedAsset(
      id: id ?? this.id,
      assetCode: assetCode ?? this.assetCode,
      assetName: assetName ?? this.assetName,
      category: category ?? this.category,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchaseCost: purchaseCost ?? this.purchaseCost,
      salvageValue: salvageValue ?? this.salvageValue,
      usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
      depreciationMethod: depreciationMethod ?? this.depreciationMethod,
      accumulatedDepreciation:
          accumulatedDepreciation ?? this.accumulatedDepreciation,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixedAsset && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'FixedAsset($assetCode, $assetName)';
}

/// One row of a depreciation schedule.
class DepreciationEntry {
  const DepreciationEntry({
    required this.year,
    required this.openingBookValue,
    required this.depreciationCharge,
    required this.accumulatedDepreciation,
    required this.closingBookValue,
  });

  final int year;
  final double openingBookValue;
  final double depreciationCharge;
  final double accumulatedDepreciation;
  final double closingBookValue;
}
