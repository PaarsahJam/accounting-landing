import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/comments/data/comments_repository.dart';
import 'package:accounting_app/features/comments/data/comments_repository_provider.dart';
import 'package:accounting_app/features/comments/domain/comment.dart';
import 'package:accounting_app/features/comments/domain/comments_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _params = CommentsParams(
  entityType: 'purchaseOrder',
  entityId: 'PO-2026-000001',
);

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    commentsRepositoryProvider.overrideWithValue(
      MockCommentsRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

void main() {
  group('CommentsController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('builds and loads seeded comments for purchaseOrder', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      final comments = await notifier.future;

      expect(comments, isNotEmpty);
      expect(comments.every((c) => c.entityId == 'PO-2026-000001'), isTrue);
    });

    test('addComment appends new entry to state', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final before = initial.length;

      final result = await notifier.addComment(
        Comment(
          id: '',
          entityType: 'purchaseOrder',
          entityId: 'PO-2026-000001',
          author: 'controller_test',
          createdAt: DateTime(2026, 5, 1),
          message: 'New comment from test',
        ),
      );

      expect(result!.isSuccess, isTrue);
      final updated = container
          .read(commentsControllerProvider(_params))
          .value!;
      expect(updated.length, equals(before + 1));
      expect(updated.any((c) => c.message == 'New comment from test'), isTrue);
    });

    test('editComment updates message in state', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.editComment(targetId, 'Edited message');

      expect(success, isTrue);
      final updated = container
          .read(commentsControllerProvider(_params))
          .value!;
      final edited = updated.firstWhere((c) => c.id == targetId);
      expect(edited.message, equals('Edited message'));
      expect(edited.isEdited, isTrue);
    });

    test('deleteComment removes entry from state', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.deleteComment(targetId);

      expect(success, isTrue);
      final updated = container
          .read(commentsControllerProvider(_params))
          .value!;
      expect(updated.any((c) => c.id == targetId), isFalse);
    });

    test('refresh reloads state without error', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container.read(commentsControllerProvider(_params));
      expect(state.hasValue, isTrue);
      expect(state.value, isNotEmpty);
    });

    test('editComment returns false for unknown id', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      await notifier.future;

      final success = await notifier.editComment('NON-EXISTENT', 'text');

      expect(success, isFalse);
    });

    test('deleteComment returns false for unknown id', () async {
      container.listen(commentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        commentsControllerProvider(_params).notifier,
      );
      await notifier.future;

      final success = await notifier.deleteComment('NON-EXISTENT');

      expect(success, isFalse);
    });

    test('CommentsParams equality', () {
      const p1 = CommentsParams(entityType: 'salesInvoice', entityId: 'SI-001');
      const p2 = CommentsParams(entityType: 'salesInvoice', entityId: 'SI-001');
      const p3 = CommentsParams(entityType: 'vendorBill', entityId: 'SI-001');

      expect(p1, equals(p2));
      expect(p1, isNot(equals(p3)));
      expect(p1.hashCode, equals(p2.hashCode));
    });
  });

  test('CommentsController family isolates by params', () async {
    final container = ProviderContainer(
      overrides: [
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        commentsRepositoryProvider.overrideWithValue(
          MockCommentsRepository(auditRepository: MockAuditTrailRepository()),
        ),
      ],
    );

    const p1 = CommentsParams(
      entityType: 'purchaseOrder',
      entityId: 'PO-2026-000001',
    );
    const p2 = CommentsParams(
      entityType: 'salesInvoice',
      entityId: 'SI-2026-000001',
    );

    container.listen(commentsControllerProvider(p1), (_, _) {});
    container.listen(commentsControllerProvider(p2), (_, _) {});

    final r1 = await container.read(commentsControllerProvider(p1).future);
    final r2 = await container.read(commentsControllerProvider(p2).future);

    expect(r1.every((c) => c.entityId == 'PO-2026-000001'), isTrue);
    expect(r2.every((c) => c.entityId == 'SI-2026-000001'), isTrue);

    container.dispose();
  });
}
