import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'workflow_repository.dart';

part 'workflow_repository_provider.g.dart';

@riverpod
WorkflowRepository workflowRepository(Ref ref) =>
    MockWorkflowRepository();
