import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/features/crm/data/crm_repository.dart';
import 'package:accounting_app/features/crm/data/crm_repository_provider.dart';
import 'package:accounting_app/features/crm/domain/lead_opportunity.dart';
import 'package:accounting_app/features/crm/domain/pipeline_controller.dart';

void main() {
  late MockCrmRepository repository;

  setUp(() {
    repository = MockCrmRepository();
  });

  group('PipelineController', () {
    test('fetchAll returns seeded opportunities', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final items =
          await container.read(pipelineControllerProvider().future);
      expect(items.length, 4);
    });

    test('filter by stage returns only matching items', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final items = await container
          .read(pipelineControllerProvider(stage: PipelineStage.lead).future);
      expect(items, isNotEmpty);
      expect(items.every((o) => o.stage == PipelineStage.lead), true);
    });

    test('updateStage moves opportunity to next stage', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final current =
          (await container.read(pipelineControllerProvider().future))
              .firstWhere((o) => o.id == 'OPP-001');
      await container
          .read(pipelineControllerProvider().notifier)
          .updateOpportunity(current.copyWith(stage: PipelineStage.negotiation));

      final items =
          container.read(pipelineControllerProvider()).asData?.value;
      expect(items, isNotNull);
      final updated = items!.firstWhere((o) => o.id == 'OPP-001');
      expect(updated.stage, PipelineStage.negotiation);
    });

    test('createOpportunity adds a new lead', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final newOpp = LeadOpportunity(
        id: 'opp5',
        customerId: 'c1',
        title: 'New deal',
        description: '',
        estimatedValue: 50000,
        stage: PipelineStage.lead,
        probability: 0.1,
        expectedCloseDate: DateTime(2026, 9, 1),
        owner: 'user1',
        createdAt: DateTime.now(),
      );

      await container
          .read(pipelineControllerProvider().notifier)
          .createOpportunity(newOpp);

      final items =
          container.read(pipelineControllerProvider()).asData?.value;
      expect(items, isNotNull);
      expect(items!.any((o) => o.id == 'opp5'), true);
      expect(items.length, 5);
    });
  });
}
