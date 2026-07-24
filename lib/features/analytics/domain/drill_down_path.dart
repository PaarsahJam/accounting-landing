class DrillDownLevel {
  const DrillDownLevel({
    required this.label,
    required this.dimension,
    this.entityId,
    this.route,
  });

  final String label;
  final String dimension;
  final String? entityId;
  final String? route;

  DrillDownLevel drillInto(String id, {String? route}) {
    return DrillDownLevel(
      label: label,
      dimension: dimension,
      entityId: id,
      route: route,
    );
  }
}

class DrillDownPath {
  const DrillDownPath({
    required this.kpiId,
    required this.levels,
  });

  final String kpiId;
  final List<DrillDownLevel> levels;

  static const revenueDrillDown = DrillDownPath(
    kpiId: 'revenue',
    levels: [
      DrillDownLevel(label: 'By Customer', dimension: 'customer'),
      DrillDownLevel(label: 'By Invoice', dimension: 'invoice'),
    ],
  );

  static const expensesDrillDown = DrillDownPath(
    kpiId: 'expenses',
    levels: [
      DrillDownLevel(label: 'By Vendor', dimension: 'vendor'),
      DrillDownLevel(label: 'By Bill', dimension: 'bill'),
    ],
  );

  static const arDrillDown = DrillDownPath(
    kpiId: 'accountsReceivable',
    levels: [
      DrillDownLevel(label: 'By Customer', dimension: 'customer'),
      DrillDownLevel(label: 'By Invoice', dimension: 'invoice'),
    ],
  );

  static const apDrillDown = DrillDownPath(
    kpiId: 'accountsPayable',
    levels: [
      DrillDownLevel(label: 'By Vendor', dimension: 'vendor'),
      DrillDownLevel(label: 'By Bill', dimension: 'bill'),
    ],
  );
}
