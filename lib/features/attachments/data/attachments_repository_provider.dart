import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'attachments_repository.dart';

part 'attachments_repository_provider.g.dart';

@riverpod
AttachmentsRepository attachmentsRepository(Ref ref) {
  return MockAttachmentsRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
