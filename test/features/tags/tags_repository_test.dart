import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/tags/data/tags_repository.dart';
import 'package:accounting_app/features/tags/domain/tag.dart';
import 'package:flutter_test/flutter_test.dart';

MockTagsRepository _makeRepo() =>
    MockTagsRepository(auditRepository: MockAuditTrailRepository());

void main() {
  group('MockTagsRepository — tags CRUD', () {
    test('fetchTags returns seeded tags', () async {
      final repo = _makeRepo();
      final result = await repo.fetchTags();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(4));
    });

    test('createTag generates id and stores tag', () async {
      final repo = _makeRepo();
      final result = await repo.createTag(
        const Tag(id: '', name: 'New Tag', color: '#1E88E5'),
      );
      expect(result.isSuccess, isTrue);
      expect(result.data!.id, isNotEmpty);
      expect(result.data!.name, equals('New Tag'));

      final all = await repo.fetchTags();
      expect(all.data!.any((t) => t.name == 'New Tag'), isTrue);
    });

    test('createTag uses provided id when non-empty', () async {
      final repo = _makeRepo();
      const tag = Tag(id: 'TAG-CUSTOM', name: 'Custom', color: '#E53935');
      final result = await repo.createTag(tag);
      expect(result.data!.id, equals('TAG-CUSTOM'));
    });

    test('renameTag updates name', () async {
      final repo = _makeRepo();
      final all = (await repo.fetchTags()).data!;
      final target = all.first;

      final result = await repo.renameTag(target.id, 'Renamed');
      expect(result.isSuccess, isTrue);
      expect(result.data!.name, equals('Renamed'));

      final updated = (await repo.fetchTags()).data!;
      expect(
        updated.any((t) => t.id == target.id && t.name == 'Renamed'),
        isTrue,
      );
    });

    test('renameTag fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.renameTag('NO-SUCH', 'x');
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('changeColor updates color', () async {
      final repo = _makeRepo();
      final target = (await repo.fetchTags()).data!.first;

      final result = await repo.changeColor(target.id, '#FFFF00');
      expect(result.isSuccess, isTrue);
      expect(result.data!.color, equals('#FFFF00'));
    });

    test('changeColor fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.changeColor('NO-SUCH', '#000000');
      expect(result.isSuccess, isFalse);
    });

    test('updateDescription updates description', () async {
      final repo = _makeRepo();
      final target = (await repo.fetchTags()).data!.first;
      final result = await repo.updateDescription(target.id, 'New description');
      expect(result.isSuccess, isTrue);
      expect(result.data!.description, equals('New description'));
    });

    test('updateDescription fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.updateDescription('NO-SUCH', 'desc');
      expect(result.isSuccess, isFalse);
    });

    test('deleteTag removes tag and all assignments', () async {
      final repo = _makeRepo();
      final all = (await repo.fetchTags()).data!;
      final target = all.first;

      final deleteResult = await repo.deleteTag(target.id);
      expect(deleteResult.isSuccess, isTrue);

      final remaining = (await repo.fetchTags()).data!;
      expect(remaining.any((t) => t.id == target.id), isFalse);

      // Assignments for the deleted tag should be cleaned up
      final after = await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );
      expect(after.data!.any((t) => t.id == target.id), isFalse);
    });

    test('deleteTag fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.deleteTag('NO-SUCH');
      expect(result.isSuccess, isFalse);
    });
  });

  group('MockTagsRepository — entity assignments', () {
    test('fetchTagsForEntity returns seeded assignments', () async {
      final repo = _makeRepo();
      final result = await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(2));
    });

    test('fetchTagsForEntity returns empty for unknown entity', () async {
      final repo = _makeRepo();
      final result = await repo.fetchTagsForEntity(
        entityType: 'salesInvoice',
        entityId: 'SI-UNKNOWN',
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('assignTag creates association', () async {
      final repo = _makeRepo();
      final allTags = (await repo.fetchTags()).data!;
      final target = allTags.firstWhere(
        (t) => t.id == 'TAG-2026-0004', // "Draft" — not yet assigned to PO
      );

      final result = await repo.assignTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: target.id,
      );
      expect(result.isSuccess, isTrue);

      final after = await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );
      expect(after.data!.any((t) => t.id == target.id), isTrue);
    });

    test('assignTag is idempotent', () async {
      final repo = _makeRepo();
      // Assign same tag twice — should not error or create duplicates
      await repo.assignTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: 'TAG-2026-0001',
      );
      await repo.assignTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: 'TAG-2026-0001',
      );

      final result = await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );
      final count = result.data!.where((t) => t.id == 'TAG-2026-0001').length;
      expect(count, equals(1));
    });

    test('assignTag fails for unknown tagId', () async {
      final repo = _makeRepo();
      final result = await repo.assignTag(
        entityType: 'salesInvoice',
        entityId: 'SI-001',
        tagId: 'NO-SUCH-TAG',
      );
      expect(result.isSuccess, isFalse);
    });

    test('removeTagFromEntity removes association', () async {
      final repo = _makeRepo();
      final before = (await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;

      final result = await repo.removeTagFromEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: before.first.id,
      );
      expect(result.isSuccess, isTrue);

      final after = (await repo.fetchTagsForEntity(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;
      expect(after.length, equals(before.length - 1));
    });

    test('removeTagFromEntity fails when not assigned', () async {
      final repo = _makeRepo();
      final result = await repo.removeTagFromEntity(
        entityType: 'salesInvoice',
        entityId: 'SI-999',
        tagId: 'TAG-2026-0001',
      );
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });
  });

  group('Tag model', () {
    test('copyWith preserves unchanged fields', () {
      const t = Tag(
        id: 'T1',
        name: 'Urgent',
        color: '#E53935',
        description: 'High priority',
      );
      final copy = t.copyWith(name: 'Very Urgent');
      expect(copy.name, equals('Very Urgent'));
      expect(copy.color, equals('#E53935'));
      expect(copy.description, equals('High priority'));
      expect(copy.id, equals('T1'));
    });

    test('equality is by id', () {
      const t1 = Tag(id: 'T1', name: 'Urgent', color: '#E53935');
      const t2 = Tag(id: 'T1', name: 'Different', color: '#000000');
      const t3 = Tag(id: 'T2', name: 'Urgent', color: '#E53935');
      expect(t1, equals(t2));
      expect(t1, isNot(equals(t3)));
      expect(t1.hashCode, equals(t2.hashCode));
    });

    test('description defaults to empty string', () {
      const t = Tag(id: 'T1', name: 'Test', color: '#000000');
      expect(t.description, equals(''));
    });

    test('toString includes id and name', () {
      const t = Tag(id: 'T1', name: 'Urgent', color: '#E53935');
      expect(t.toString(), contains('T1'));
      expect(t.toString(), contains('Urgent'));
    });
  });

  group('EntityTag model', () {
    test('equality covers all three fields', () {
      const a = EntityTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-1',
        tagId: 'TAG-1',
      );
      const b = EntityTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-1',
        tagId: 'TAG-1',
      );
      const c = EntityTag(
        entityType: 'salesInvoice',
        entityId: 'PO-1',
        tagId: 'TAG-1',
      );
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, equals(b.hashCode));
    });
  });
}
