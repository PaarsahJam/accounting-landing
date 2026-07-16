import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/data/attachments_repository_provider.dart';
import 'package:accounting_app/features/attachments/domain/attachment.dart';
import 'package:accounting_app/features/attachments/domain/attachment_file_type.dart';
import 'package:accounting_app/features/attachments/domain/attachments_controller.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _params = AttachmentsParams(
  entityType: 'purchaseOrder',
  entityId: 'PO-2026-000001',
);

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    attachmentsRepositoryProvider.overrideWithValue(
      MockAttachmentsRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

void main() {
  group('AttachmentsController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('builds and loads seeded attachments', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      final attachments = await notifier.future;

      expect(attachments, isNotEmpty);
      expect(attachments.every((a) => a.entityId == 'PO-2026-000001'), isTrue);
    });

    test('addAttachment prepends new entry to state', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final before = initial.length;

      final result = await notifier.addAttachment(
        Attachment(
          id: '',
          entityType: 'purchaseOrder',
          entityId: 'PO-2026-000001',
          filename: 'new_file.pdf',
          fileType: AttachmentFileType.pdf,
          fileSizeBytes: 8192,
          uploadedAt: DateTime(2026, 5, 1),
          uploadedBy: 'controller_test',
        ),
      );

      expect(result!.isSuccess, isTrue);
      final updated = container
          .read(attachmentsControllerProvider(_params))
          .value!;
      expect(updated.length, equals(before + 1));
      expect(updated.first.filename, equals('new_file.pdf'));
    });

    test('removeAttachment removes entry from state', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.removeAttachment(targetId);

      expect(success, isTrue);
      final updated = container
          .read(attachmentsControllerProvider(_params))
          .value!;
      expect(updated.any((a) => a.id == targetId), isFalse);
    });

    test('renameAttachment updates filename in state', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.renameAttachment(targetId, 'renamed.pdf');

      expect(success, isTrue);
      final updated = container
          .read(attachmentsControllerProvider(_params))
          .value!;
      final renamed = updated.firstWhere((a) => a.id == targetId);
      expect(renamed.filename, equals('renamed.pdf'));
    });

    test('updateNotes updates notes in state', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      final initial = await notifier.future;
      final targetId = initial.first.id;

      final success = await notifier.updateNotes(targetId, 'Updated note');

      expect(success, isTrue);
      final updated = container
          .read(attachmentsControllerProvider(_params))
          .value!;
      final changed = updated.firstWhere((a) => a.id == targetId);
      expect(changed.notes, equals('Updated note'));
    });

    test('refresh reloads state without error', () async {
      container.listen(attachmentsControllerProvider(_params), (_, _) {});
      final notifier = container.read(
        attachmentsControllerProvider(_params).notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container.read(attachmentsControllerProvider(_params));
      expect(state.hasValue, isTrue);
      expect(state.value, isNotEmpty);
    });

    test('AttachmentsParams equality', () {
      const p1 = AttachmentsParams(
        entityType: 'salesInvoice',
        entityId: 'SI-001',
      );
      const p2 = AttachmentsParams(
        entityType: 'salesInvoice',
        entityId: 'SI-001',
      );
      const p3 = AttachmentsParams(
        entityType: 'vendorBill',
        entityId: 'SI-001',
      );

      expect(p1, equals(p2));
      expect(p1, isNot(equals(p3)));
      expect(p1.hashCode, equals(p2.hashCode));
    });
  });
}
