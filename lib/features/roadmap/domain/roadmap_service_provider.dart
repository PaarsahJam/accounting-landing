import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/finance/ledger_service_provider.dart';
import '../../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import '../data/roadmap_repository_provider.dart';
import 'roadmap_mutation_service.dart';

part 'roadmap_service_provider.g.dart';

@riverpod
RoadmapMutationService roadmapMutationService(Ref ref) =>
    RoadmapMutationService(
      ledgerService: ref.watch(ledgerServiceProvider),
      auditRepository: ref.watch(auditTrailRepositoryProvider),
      roadmapRepository: ref.watch(roadmapRepositoryProvider),
      performedBy: 'system',
    );