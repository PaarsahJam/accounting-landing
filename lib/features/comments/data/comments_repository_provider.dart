import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'comments_repository.dart';

part 'comments_repository_provider.g.dart';

@riverpod
CommentsRepository commentsRepository(Ref ref) {
  return MockCommentsRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
