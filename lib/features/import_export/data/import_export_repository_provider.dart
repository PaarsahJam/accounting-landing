// lib/features/import_export/data/import_export_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'import_export_repository.dart';

part 'import_export_repository_provider.g.dart';

@riverpod
ImportExportRepository importExportRepository(Ref ref) {
  return MockImportExportRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
