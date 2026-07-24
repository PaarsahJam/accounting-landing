import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'ai_action_gateway.dart';
import 'ai_context_collector.dart';
import 'ai_provider.dart';
import 'providers/fake_ai_provider.dart';
import 'use_cases/ai_draft_action.dart';
import 'use_cases/ai_summarize.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
AiProvider aiProvider(Ref ref) => FakeAiProvider();

@Riverpod(keepAlive: true)
AiActionGateway aiActionGateway(Ref ref) {
  final auditRepo = ref.watch(auditTrailRepositoryProvider);
  return AiActionGateway(
    auditRepository: auditRepo,
    performedBy: 'ai-assistant',
  );
}

@Riverpod(keepAlive: true)
AiContextCollector aiContextCollector(Ref ref) => AiContextCollector();

@Riverpod(keepAlive: true)
AiSummarize aiSummarize(Ref ref) {
  return AiSummarize(
    aiProvider: ref.watch(aiProviderProvider),
    gateway: ref.watch(aiActionGatewayProvider),
  );
}

@Riverpod(keepAlive: true)
AiDraftAction aiDraftAction(Ref ref) {
  return AiDraftAction(
    aiProvider: ref.watch(aiProviderProvider),
    gateway: ref.watch(aiActionGatewayProvider),
  );
}
