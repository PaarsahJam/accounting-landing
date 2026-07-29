import 'dart:typed_data';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/attachment.dart';
import '../domain/attachment_file_type.dart';

abstract class AttachmentsRepository {
  /// Returns all attachments for a given entity, newest first.
  Future<AppResult<List<Attachment>>> fetchAttachments({
    required String entityType,
    required String entityId,
  });

  /// Returns a single attachment by id.
  Future<AppResult<Attachment>> getAttachment(String id);

  /// Downloads the raw bytes of an attachment for processing.
  Future<AppResult<Uint8List>> downloadAttachment(String id);

  /// Adds attachment metadata. No real file upload.
  Future<AppResult<Attachment>> addAttachment(Attachment attachment);

  /// Removes an attachment by id.
  Future<AppResult<void>> removeAttachment(String id);

  /// Renames an attachment (updates [filename]).
  Future<AppResult<Attachment>> renameAttachment(String id, String newFilename);

  /// Updates the notes field of an attachment.
  Future<AppResult<Attachment>> updateNotes(String id, String notes);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockAttachmentsRepository implements AttachmentsRepository {
  MockAttachmentsRepository({AuditTrailRepository? auditRepository})
    : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<Attachment> _attachments = [];
  int _seq = 1;

  String _nextId() =>
      'ATT-${DateTime.now().year}-${(_seq++).toString().padLeft(4, '0')}';

  void _seed() {
    // Purchase Order PO-2026-000001
    _attachments.addAll([
      Attachment(
        id: 'ATT-2026-0001',
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        filename: 'purchase_order_001.pdf',
        fileType: AttachmentFileType.pdf,
        fileSizeBytes: 245_120,
        uploadedAt: DateTime(2026, 1, 15, 9, 30),
        uploadedBy: 'alice',
        notes: 'Signed PO document',
      ),
      Attachment(
        id: 'ATT-2026-0002',
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        filename: 'vendor_quote.xlsx',
        fileType: AttachmentFileType.spreadsheet,
        fileSizeBytes: 48_640,
        uploadedAt: DateTime(2026, 1, 14, 16, 0),
        uploadedBy: 'bob',
        notes: 'Vendor price quote',
      ),
      // Sales Invoice SI-2026-000001
      Attachment(
        id: 'ATT-2026-0003',
        entityType: 'salesInvoice',
        entityId: 'SI-2026-000001',
        filename: 'invoice_draft.pdf',
        fileType: AttachmentFileType.pdf,
        fileSizeBytes: 180_224,
        uploadedAt: DateTime(2026, 1, 20, 11, 0),
        uploadedBy: 'alice',
        notes: '',
      ),
      // Vendor Bill VB-2026-000001
      Attachment(
        id: 'ATT-2026-0004',
        entityType: 'vendorBill',
        entityId: 'VB-2026-000001',
        filename: 'bill_scan.jpg',
        fileType: AttachmentFileType.image,
        fileSizeBytes: 512_000,
        uploadedAt: DateTime(2026, 2, 5, 14, 15),
        uploadedBy: 'carol',
        notes: 'Scanned bill from vendor',
      ),
      Attachment(
        id: 'ATT-2026-0005',
        entityType: 'vendorBill',
        entityId: 'VB-2026-000001',
        filename: 'delivery_note.pdf',
        fileType: AttachmentFileType.pdf,
        fileSizeBytes: 92_160,
        uploadedAt: DateTime(2026, 2, 5, 14, 20),
        uploadedBy: 'carol',
        notes: 'Delivery receipt',
      ),
    ]);
    _seq = 6;
  }

  @override
  Future<AppResult<List<Attachment>>> fetchAttachments({
    required String entityType,
    required String entityId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final result =
        _attachments
            .where((a) => a.entityType == entityType && a.entityId == entityId)
            .toList()
          ..sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));
    return AppResult.success(List.unmodifiable(result));
  }

  @override
  Future<AppResult<Attachment>> getAttachment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    try {
      final attachment = _attachments.firstWhere((a) => a.id == id);
      return AppResult.success(attachment);
    } catch (_) {
      return AppResult.failure(
        UnknownFailure(message: 'Attachment not found: $id'),
      );
    }
  }

  @override
  Future<AppResult<Uint8List>> downloadAttachment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return AppResult.success(Uint8List.fromList([
      0xFF, 0xD8, 0xFF, 0xE0, // JPEG SOI + APP0
    ]));
  }

  @override
  Future<AppResult<Attachment>> addAttachment(Attachment attachment) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final stored = attachment.id.isEmpty
        ? attachment.copyWith(id: _nextId())
        : attachment;
    _attachments.add(stored);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-ATT-${stored.id}',
        entityType: _resolveEntityType(stored.entityType),
        entityId: stored.entityId,
        entityLabel: '${stored.entityType} ${stored.entityId}',
        action: AuditAction.created,
        performedAt: stored.uploadedAt,
        performedBy: stored.uploadedBy,
        note: 'Attachment added: ${stored.filename}',
      ),
    );

    return AppResult.success(stored);
  }

  @override
  Future<AppResult<void>> removeAttachment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _attachments.indexWhere((a) => a.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Attachment not found'),
      );
    }
    final removed = _attachments[idx];
    _attachments.removeAt(idx);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-ATT-DEL-$id',
        entityType: _resolveEntityType(removed.entityType),
        entityId: removed.entityId,
        entityLabel: '${removed.entityType} ${removed.entityId}',
        action: AuditAction.deleted,
        performedAt: DateTime.now(),
        performedBy: 'current_user',
        note: 'Attachment removed: ${removed.filename}',
      ),
    );

    return AppResult.success(null);
  }

  @override
  Future<AppResult<Attachment>> renameAttachment(
    String id,
    String newFilename,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _attachments.indexWhere((a) => a.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Attachment not found'),
      );
    }
    final old = _attachments[idx];
    final updated = old.copyWith(
      filename: newFilename,
      fileType: AttachmentFileType.fromFilename(newFilename),
    );
    _attachments[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-ATT-REN-$id',
        entityType: _resolveEntityType(updated.entityType),
        entityId: updated.entityId,
        entityLabel: '${updated.entityType} ${updated.entityId}',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'current_user',
        note: 'Renamed: ${old.filename} → $newFilename',
        previousValue: old.filename,
        newValue: newFilename,
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<Attachment>> updateNotes(String id, String notes) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final idx = _attachments.indexWhere((a) => a.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Attachment not found'),
      );
    }
    final updated = _attachments[idx].copyWith(notes: notes);
    _attachments[idx] = updated;
    return AppResult.success(updated);
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  AuditEntityType _resolveEntityType(String entityType) {
    switch (entityType) {
      case 'salesInvoice':
        return AuditEntityType.salesInvoice;
      case 'vendorBill':
        return AuditEntityType.vendorBill;
      case 'purchaseOrder':
        return AuditEntityType.purchaseOrder;
      case 'goodsReceipt':
        return AuditEntityType.goodsReceipt;
      case 'vendorPayment':
        return AuditEntityType.vendorPayment;
      case 'customerPayment':
        return AuditEntityType.customerPayment;
      case 'customer':
        return AuditEntityType.customer;
      case 'vendor':
        return AuditEntityType.vendor;
      case 'journalEntry':
        return AuditEntityType.journalEntry;
      default:
        return AuditEntityType.inventory;
    }
  }
}
