// lib/features/fixed_assets/data/fixed_assets_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'fixed_assets_repository.dart';

part 'fixed_assets_repository_provider.g.dart';

@riverpod
FixedAssetsRepository fixedAssetsRepository(Ref ref) {
  return MockFixedAssetsRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
