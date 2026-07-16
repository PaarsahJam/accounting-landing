import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/comments/data/comments_repository.dart';
import 'package:accounting_app/features/comments/domain/comment.dart';
import 'package:flutter_test/flutter_test.dart';

MockCommentsRepository _makeRepo() =>
    MockCommentsRepository(auditRepository: MockAuditTrailRepository());

void main() {
  group('MockCommentsRepository', () {
    test('fetchComments returns seeded entries for purchaseOrder', () async {
      final repo = _makeRepo();
      final result = await repo.fetchComments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(3));
    });

    test('fetchComments returns empty list for unknown entity', () async {
      final repo = _makeRepo();
      final result = await repo.fetchComments(
        entityType: 'salesInvoice',
        entityId: 'NON-EXISTENT',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('fetchComments returns entries sorted oldest first', () async {
      final repo = _makeRepo();
      final result = await repo.fetchComments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );

      expect(result.isSuccess, isTrue);
      final dates = result.data!.map((c) => c.createdAt).toList();
      for (var i = 0; i < dates.length - 1; i++) {
        expect(
          dates[i].isBefore(dates[i + 1]) ||
              dates[i].isAtSameMomentAs(dates[i + 1]),
          isTrue,
          reason: 'Results should be oldest first',
        );
      }
    });

    test(
      'addComment stores and returns the comment with generated id',
      () async {
        final repo = _makeRepo();
        final now = DateTime(2026, 4, 1);

        final comment = Comment(
          id: '',
          entityType: 'salesInvoice',
          entityId: 'SI-TEST-001',
          author: 'tester',
          createdAt: now,
          message: 'Test comment',
        );

        final result = await repo.addComment(comment);

        expect(result.isSuccess, isTrue);
        expect(result.data!.message, equals('Test comment'));
        expect(result.data!.id, isNotEmpty);

        // Verify it appears in fetch
        final fetch = await repo.fetchComments(
          entityType: 'salesInvoice',
          entityId: 'SI-TEST-001',
        );
        expect(fetch.data!.length, equals(1));
      },
    );

    test('addComment uses provided id when non-empty', () async {
      final repo = _makeRepo();
      final comment = Comment(
        id: 'CMT-CUSTOM-001',
        entityType: 'customer',
        entityId: 'CUST-1',
        author: 'admin',
        createdAt: DateTime(2026, 3, 1),
        message: 'Custom id comment',
      );

      final result = await repo.addComment(comment);

      expect(result.data!.id, equals('CMT-CUSTOM-001'));
    });

    test('editComment updates message and sets editedAt', () async {
      final repo = _makeRepo();
      final original = (await repo.fetchComments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!.first;

      final result = await repo.editComment(original.id, 'Updated message');

      expect(result.isSuccess, isTrue);
      expect(result.data!.message, equals('Updated message'));
      expect(result.data!.isEdited, isTrue);
      expect(result.data!.editedAt, isNotNull);
    });

    test('editComment fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.editComment('NON-EXISTENT', 'text');

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('deleteComment removes the entry', () async {
      final repo = _makeRepo();
      final before = (await repo.fetchComments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;
      final targetId = before.first.id;

      final deleteResult = await repo.deleteComment(targetId);
      expect(deleteResult.isSuccess, isTrue);

      final after = (await repo.fetchComments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;
      expect(after.length, equals(before.length - 1));
      expect(after.any((c) => c.id == targetId), isFalse);
    });

    test('deleteComment fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.deleteComment('NON-EXISTENT');

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });
  });

  group('Comment model', () {
    test('isEdited is false when editedAt is null', () {
      final comment = Comment(
        id: 'c1',
        entityType: 'salesInvoice',
        entityId: 'SI-1',
        author: 'alice',
        createdAt: DateTime(2026, 1, 1),
        message: 'Hello',
      );
      expect(comment.isEdited, isFalse);
    });

    test('isEdited is true when editedAt is set', () {
      final comment = Comment(
        id: 'c1',
        entityType: 'salesInvoice',
        entityId: 'SI-1',
        author: 'alice',
        createdAt: DateTime(2026, 1, 1),
        message: 'Hello',
        editedAt: DateTime(2026, 1, 2),
      );
      expect(comment.isEdited, isTrue);
    });

    test('copyWith preserves editedAt when not passed', () {
      final editTime = DateTime(2026, 2, 1);
      final comment = Comment(
        id: 'c1',
        entityType: 'salesInvoice',
        entityId: 'SI-1',
        author: 'alice',
        createdAt: DateTime(2026, 1, 1),
        message: 'Hello',
        editedAt: editTime,
      );
      final copy = comment.copyWith(message: 'Updated');
      expect(copy.editedAt, equals(editTime));
      expect(copy.message, equals('Updated'));
    });

    test('copyWith can clear editedAt by passing null', () {
      final comment = Comment(
        id: 'c1',
        entityType: 'salesInvoice',
        entityId: 'SI-1',
        author: 'alice',
        createdAt: DateTime(2026, 1, 1),
        message: 'Hello',
        editedAt: DateTime(2026, 1, 2),
      );
      final copy = comment.copyWith(editedAt: null);
      expect(copy.editedAt, isNull);
      expect(copy.isEdited, isFalse);
    });

    test('equality is by id', () {
      final a = Comment(
        id: 'c1',
        entityType: 'salesInvoice',
        entityId: 'SI-1',
        author: 'alice',
        createdAt: DateTime(2026, 1, 1),
        message: 'First',
      );
      final b = Comment(
        id: 'c1',
        entityType: 'vendorBill',
        entityId: 'VB-99',
        author: 'bob',
        createdAt: DateTime(2026, 6, 1),
        message: 'Different',
      );
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });
  });
}
