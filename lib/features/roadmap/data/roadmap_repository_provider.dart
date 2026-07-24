import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'roadmap_repository.dart';

part 'roadmap_repository_provider.g.dart';

@riverpod
RoadmapRepository roadmapRepository(Ref ref) => MockRoadmapRepository();