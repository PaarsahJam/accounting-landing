// lib/features/audit_trail/data/audit_trail_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'audit_trail_repository.dart';

part 'audit_trail_repository_provider.g.dart';

@riverpod
AuditTrailRepository auditTrailRepository(Ref ref) {
  return MockAuditTrailRepository();
}
