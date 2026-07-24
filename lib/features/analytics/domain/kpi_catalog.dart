import 'kpi_definition.dart';

class KpiCatalog {
  const KpiCatalog();

  List<KpiDefinition> all() => KpiDefinition.all;

  List<KpiDefinition> byCategory(KpiCategory category) {
    return KpiDefinition.byCategory[category] ?? [];
  }

  KpiDefinition? byId(String id) {
    for (final k in KpiDefinition.all) {
      if (k.id == id) return k;
    }
    return null;
  }

  List<KpiDefinition> byTags(List<String> tags) {
    return KpiDefinition.all.where((k) => tags.any((t) => k.tags.contains(t))).toList();
  }
}
