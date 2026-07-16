import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/tags/data/tags_repository.dart';
import 'package:accounting_app/features/tags/data/tags_repository_provider.dart';
import 'package:accounting_app/features/tags/domain/tag.dart';
import 'package:accounting_app/features/tags/domain/tags_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    tagsRepositoryProvider.overrideWithValue(
      MockTagsRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

void main() {
  group('TagsController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('builds and loads seeded tags', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final tags = await container.read(tagsControllerProvider.future);
      expect(tags.length, equals(4));
    });

    test('createTag appends new tag to state', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      final initial = await notifier.future;
      final before = initial.length;

      final result = await notifier.createTag(
        const Tag(id: '', name: 'Test Tag', color: '#1E88E5'),
      );

      expect(result!.isSuccess, isTrue);
      final after = container.read(tagsControllerProvider).value!;
      expect(after.length, equals(before + 1));
      expect(after.any((t) => t.name == 'Test Tag'), isTrue);
    });

    test('renameTag updates name in state', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.renameTag(targetId, 'Renamed Tag');
      expect(success, isTrue);

      final state = container.read(tagsControllerProvider).value!;
      expect(
        state.any((t) => t.id == targetId && t.name == 'Renamed Tag'),
        isTrue,
      );
    });

    test('changeColor updates color in state', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.changeColor(targetId, '#ABCDEF');
      expect(success, isTrue);

      final state = container.read(tagsControllerProvider).value!;
      expect(
        state.any((t) => t.id == targetId && t.color == '#ABCDEF'),
        isTrue,
      );
    });

    test('deleteTag removes tag from state', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.deleteTag(targetId);
      expect(success, isTrue);

      final state = container.read(tagsControllerProvider).value!;
      expect(state.any((t) => t.id == targetId), isFalse);
    });

    test('renameTag returns false for unknown id', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.renameTag('NO-SUCH', 'x');
      expect(success, isFalse);
    });

    test('deleteTag returns false for unknown id', () async {
      container.listen(tagsControllerProvider, (_, _) {});
      final notifier = container.read(tagsControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.deleteTag('NO-SUCH');
      expect(success, isFalse);
    });
  });

  group('EntityTagsController', () {
    const params = EntityTagsParams(
      entityType: 'purchaseOrder',
      entityId: 'PO-2026-000001',
    );

    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('builds and loads seeded entity tags', () async {
      container.listen(entityTagsControllerProvider(params), (_, _) {});
      final tags = await container.read(
        entityTagsControllerProvider(params).future,
      );
      expect(tags.length, equals(2));
    });

    test('assignTag adds tag to entity state', () async {
      container.listen(entityTagsControllerProvider(params), (_, _) {});
      final notifier = container.read(
        entityTagsControllerProvider(params).notifier,
      );
      final initial = await notifier.future;
      final before = initial.length;

      // Assign TAG-2026-0004 (Draft) which is not yet assigned to PO
      final success = await notifier.assignTag('TAG-2026-0004');
      expect(success, isTrue);

      // After invalidateSelf(), provider reloads
      final after = await container.read(
        entityTagsControllerProvider(params).future,
      );
      expect(after.length, equals(before + 1));
    });

    test('removeTag removes tag from entity state', () async {
      container.listen(entityTagsControllerProvider(params), (_, _) {});
      final notifier = container.read(
        entityTagsControllerProvider(params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.removeTag(targetId);
      expect(success, isTrue);

      final state = container.read(entityTagsControllerProvider(params)).value!;
      expect(state.any((t) => t.id == targetId), isFalse);
    });

    test('removeTag returns false for unassigned tag', () async {
      container.listen(entityTagsControllerProvider(params), (_, _) {});
      final notifier = container.read(
        entityTagsControllerProvider(params).notifier,
      );
      await notifier.future;

      final success = await notifier.removeTag('NO-SUCH-TAG');
      expect(success, isFalse);
    });

    test('EntityTagsParams equality', () {
      const p1 = EntityTagsParams(
        entityType: 'salesInvoice',
        entityId: 'SI-001',
      );
      const p2 = EntityTagsParams(
        entityType: 'salesInvoice',
        entityId: 'SI-001',
      );
      const p3 = EntityTagsParams(entityType: 'vendorBill', entityId: 'SI-001');
      expect(p1, equals(p2));
      expect(p1, isNot(equals(p3)));
      expect(p1.hashCode, equals(p2.hashCode));
    });

    test('family provider isolates by params', () async {
      const p1 = EntityTagsParams(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );
      const p2 = EntityTagsParams(
        entityType: 'salesInvoice',
        entityId: 'SI-2026-000001',
      );

      container.listen(entityTagsControllerProvider(p1), (_, _) {});
      container.listen(entityTagsControllerProvider(p2), (_, _) {});

      final r1 = await container.read(entityTagsControllerProvider(p1).future);
      final r2 = await container.read(entityTagsControllerProvider(p2).future);

      // PO has 2 seeded tags; SI has 1
      expect(r1.length, equals(2));
      expect(r2.length, equals(1));
    });
  });
}
