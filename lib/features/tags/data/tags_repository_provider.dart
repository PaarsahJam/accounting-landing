import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'tags_repository.dart';

part 'tags_repository_provider.g.dart';

@riverpod
TagsRepository tagsRepository(Ref ref) {
  return MockTagsRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
