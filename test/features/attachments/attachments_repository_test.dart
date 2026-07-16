import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/domain/attachment.dart';
import 'package:accounting_app/features/attachments/domain/attachment_file_type.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:flutter_test/flutter_test.dart';

MockAttachmentsRepository _makeRepo() =>
    MockAttachmentsRepository(auditRepository: MockAuditTrailRepository());

void main() {
  group('MockAttachmentsRepository', () {
    test('fetchAttachments returns seeded entries for purchaseOrder', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(2));
    });

    test('fetchAttachments returns empty list for unknown entity', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAttachments(
        entityType: 'salesInvoice',
        entityId: 'NON-EXISTENT',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('fetchAttachments returns newest first', () async {
      final repo = _makeRepo();
      final result = await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      );

      expect(result.isSuccess, isTrue);
      final dates = result.data!.map((a) => a.uploadedAt).toList();
      for (var i = 0; i < dates.length - 1; i++) {
        expect(
          dates[i].isAfter(dates[i + 1]) ||
              dates[i].isAtSameMomentAs(dates[i + 1]),
          isTrue,
          reason: 'Results should be newest first',
        );
      }
    });

    test('addAttachment stores and returns the attachment', () async {
      final repo = _makeRepo();
      final now = DateTime(2026, 3, 1);

      final att = Attachment(
        id: '',
        entityType: 'salesInvoice',
        entityId: 'SI-TEST-001',
        filename: 'test.pdf',
        fileType: AttachmentFileType.pdf,
        fileSizeBytes: 10240,
        uploadedAt: now,
        uploadedBy: 'tester',
        notes: 'Test note',
      );

      final result = await repo.addAttachment(att);

      expect(result.isSuccess, isTrue);
      expect(result.data!.filename, equals('test.pdf'));
      expect(result.data!.id, isNotEmpty);

      // Verify it appears in fetch
      final fetch = await repo.fetchAttachments(
        entityType: 'salesInvoice',
        entityId: 'SI-TEST-001',
      );
      expect(fetch.data!.length, equals(1));
    });

    test('addAttachment uses provided id when non-empty', () async {
      final repo = _makeRepo();
      final att = Attachment(
        id: 'ATT-CUSTOM-001',
        entityType: 'customer',
        entityId: 'CUST-1',
        filename: 'contract.docx',
        fileType: AttachmentFileType.document,
        fileSizeBytes: 5120,
        uploadedAt: DateTime(2026, 3, 1),
        uploadedBy: 'admin',
      );

      final result = await repo.addAttachment(att);

      expect(result.data!.id, equals('ATT-CUSTOM-001'));
    });

    test('removeAttachment deletes the entry', () async {
      final repo = _makeRepo();

      final before = (await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;
      final targetId = before.first.id;

      final removeResult = await repo.removeAttachment(targetId);
      expect(removeResult.isSuccess, isTrue);

      final after = (await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!;
      expect(after.length, equals(before.length - 1));
      expect(after.any((a) => a.id == targetId), isFalse);
    });

    test('removeAttachment fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.removeAttachment('NON-EXISTENT');

      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('renameAttachment updates filename and re-infers fileType', () async {
      final repo = _makeRepo();
      final att = (await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!.first;

      final result = await repo.renameAttachment(att.id, 'updated.xlsx');

      expect(result.isSuccess, isTrue);
      expect(result.data!.filename, equals('updated.xlsx'));
      expect(result.data!.fileType, equals(AttachmentFileType.spreadsheet));
    });

    test('renameAttachment fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.renameAttachment('NON-EXISTENT', 'new.pdf');

      expect(result.isSuccess, isFalse);
    });

    test('updateNotes changes the notes field', () async {
      final repo = _makeRepo();
      final att = (await repo.fetchAttachments(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
      )).data!.first;

      final result = await repo.updateNotes(att.id, 'New note text');

      expect(result.isSuccess, isTrue);
      expect(result.data!.notes, equals('New note text'));
    });

    test('updateNotes fails for unknown id', () async {
      final repo = _makeRepo();
      final result = await repo.updateNotes('NON-EXISTENT', 'note');

      expect(result.isSuccess, isFalse);
    });
  });

  group('AttachmentFileType.fromFilename', () {
    test('pdf extension maps to pdf', () {
      expect(
        AttachmentFileType.fromFilename('invoice.pdf'),
        equals(AttachmentFileType.pdf),
      );
    });
    test('png maps to image', () {
      expect(
        AttachmentFileType.fromFilename('photo.png'),
        equals(AttachmentFileType.image),
      );
    });
    test('xlsx maps to spreadsheet', () {
      expect(
        AttachmentFileType.fromFilename('data.xlsx'),
        equals(AttachmentFileType.spreadsheet),
      );
    });
    test('docx maps to document', () {
      expect(
        AttachmentFileType.fromFilename('report.docx'),
        equals(AttachmentFileType.document),
      );
    });
    test('zip maps to archive', () {
      expect(
        AttachmentFileType.fromFilename('backup.zip'),
        equals(AttachmentFileType.archive),
      );
    });
    test('unknown extension maps to other', () {
      expect(
        AttachmentFileType.fromFilename('data.xyz'),
        equals(AttachmentFileType.other),
      );
    });
    test('no extension maps to other', () {
      expect(
        AttachmentFileType.fromFilename('noextension'),
        equals(AttachmentFileType.other),
      );
    });
  });

  group('Attachment.formattedSize', () {
    test('bytes < 1024 shown as B', () {
      final att = Attachment(
        id: 'x',
        entityType: 't',
        entityId: 'e',
        filename: 'f',
        fileType: AttachmentFileType.other,
        fileSizeBytes: 512,
        uploadedAt: _epoch,
        uploadedBy: 'u',
      );
      expect(att.formattedSize, equals('512 B'));
    });
    test('bytes in KB range', () {
      final att = Attachment(
        id: 'x',
        entityType: 't',
        entityId: 'e',
        filename: 'f',
        fileType: AttachmentFileType.other,
        fileSizeBytes: 4096,
        uploadedAt: _epoch,
        uploadedBy: 'u',
      );
      expect(att.formattedSize, contains('KB'));
    });
    test('bytes in MB range', () {
      final att = Attachment(
        id: 'x',
        entityType: 't',
        entityId: 'e',
        filename: 'f',
        fileType: AttachmentFileType.other,
        fileSizeBytes: 2 * 1024 * 1024,
        uploadedAt: _epoch,
        uploadedBy: 'u',
      );
      expect(att.formattedSize, contains('MB'));
    });
  });
}

final _epoch = DateTime.utc(2026);
