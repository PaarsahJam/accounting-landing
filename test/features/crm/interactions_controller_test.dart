import 'package:accounting_app/features/crm/data/crm_repository.dart';
import 'package:accounting_app/features/crm/data/crm_repository_provider.dart';
import 'package:accounting_app/features/crm/domain/interaction.dart';
import 'package:accounting_app/features/crm/domain/interactions_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InteractionsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(MockCrmRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads interactions for a contact successfully', () async {
      final controller =
          container.read(interactionsControllerProvider('CONT-001').notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.contactId, 'CONT-001');
    });

    test('returns empty list for unknown contact', () async {
      final controller =
          container.read(interactionsControllerProvider('UNKNOWN').notifier);
      final result = await controller.future;

      expect(result, isEmpty);
    });

    test('createInteraction adds interaction to state', () async {
      final provider = interactionsControllerProvider('CONT-001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      final interaction = Interaction(
        id: 'INT-NEW',
        contactId: 'CONT-001',
        customerId: 'CUST-1001',
        type: InteractionType.call,
        subject: 'Test call',
        description: 'A test call interaction',
        occurredAt: DateTime(2026, 7, 23, 14, 0),
        performedBy: 'tester',
        createdAt: DateTime(2026, 7, 23, 14, 0),
      );

      await controller.createInteraction(interaction);

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value!.any((i) => i.id == 'INT-NEW'), isTrue);
    });

    test('deleteInteraction removes interaction from state', () async {
      final provider = interactionsControllerProvider('CONT-001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      await controller.deleteInteraction('INT-001');

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value!.any((i) => i.id == 'INT-001'), isFalse);
    });

    test('refresh reloads interactions', () async {
      final provider = interactionsControllerProvider('CONT-001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      await controller.refresh();

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value, isNotEmpty);
    });

    test('new interactions appear at top of list', () async {
      final provider = interactionsControllerProvider('CONT-001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      final recent = Interaction(
        id: 'INT-RECENT',
        contactId: 'CONT-001',
        customerId: 'CUST-1001',
        type: InteractionType.note,
        subject: 'Recent note',
        description: 'Most recent',
        occurredAt: DateTime(2026, 7, 23, 23, 59),
        performedBy: 'tester',
        createdAt: DateTime(2026, 7, 23, 23, 59),
      );

      await controller.createInteraction(recent);

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value!.first.id, 'INT-RECENT');
    });
  });
}
