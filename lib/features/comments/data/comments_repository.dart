import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/comment.dart';

abstract class CommentsRepository {
  /// Returns all comments for the entity, oldest first.
  Future<AppResult<List<Comment>>> fetchComments({
    required String entityType,
    required String entityId,
  });

  /// Adds a new comment. Returns the stored comment (with generated id).
  Future<AppResult<Comment>> addComment(Comment comment);

  /// Replaces the message of an existing comment.
  Future<AppResult<Comment>> editComment(String id, String newMessage);

  /// Permanently removes a comment.
  Future<AppResult<void>> deleteComment(String id);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockCommentsRepository implements CommentsRepository {
  MockCommentsRepository({AuditTrailRepository? auditRepository})
    : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<Comment> _comments = [];
  int _seq = 1;

  String _nextId() =>
      'CMT-${DateTime.now().year}-${(_seq++).toString().padLeft(4, '0')}';

  void _seed() {
    final base = DateTime(2026, 1, 15);

    // Purchase Order comments
    _comments.addAll([
      Comment(
        id: 'CMT-2026-0001',
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        author: 'alice',
        createdAt: base,
        message: 'Please confirm the delivery date with the vendor.',
      ),
      Comment(
        id: 'CMT-2026-0002',
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        author: 'bob',
        createdAt: base.add(const Duration(hours: 3)),
        message: 'Vendor confirmed delivery by end of January.',
      ),
      Comment(
        id: 'CMT-2026-0003',
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        author: 'alice',
        createdAt: base.add(const Duration(hours: 5)),
        message: 'Great, I have updated the expected receipt date.',
        editedAt: base.add(const Duration(hours: 6)),
      ),
      // Sales Invoice comment
      Comment(
        id: 'CMT-2026-0004',
        entityType: 'salesInvoice',
        entityId: 'SI-2026-000001',
        author: 'carol',
        createdAt: DateTime(2026, 1, 20, 10, 0),
        message: 'Customer requested a copy via email.',
      ),
      // Vendor Bill comment
      Comment(
        id: 'CMT-2026-0005',
        entityType: 'vendorBill',
        entityId: 'VB-2026-000001',
        author: 'dave',
        createdAt: DateTime(2026, 2, 5, 9, 0),
        message: 'Matched to goods receipt GR-2026-000002.',
      ),
    ]);
    _seq = 6;
  }

  @override
  Future<AppResult<List<Comment>>> fetchComments({
    required String entityType,
    required String entityId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final result =
        _comments
            .where((c) => c.entityType == entityType && c.entityId == entityId)
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return AppResult.success(List.unmodifiable(result));
  }

  @override
  Future<AppResult<Comment>> addComment(Comment comment) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final stored = comment.id.isEmpty
        ? comment.copyWith(id: _nextId())
        : comment;
    _comments.add(stored);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-CMT-${stored.id}',
        entityType: _resolveEntityType(stored.entityType),
        entityId: stored.entityId,
        entityLabel: '${stored.entityType} ${stored.entityId}',
        action: AuditAction.created,
        performedAt: stored.createdAt,
        performedBy: stored.author,
        note: 'Comment added by ${stored.author}',
      ),
    );

    return AppResult.success(stored);
  }

  @override
  Future<AppResult<Comment>> editComment(String id, String newMessage) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final idx = _comments.indexWhere((c) => c.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Comment not found'),
      );
    }
    final old = _comments[idx];
    final updated = old.copyWith(message: newMessage, editedAt: DateTime.now());
    _comments[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-CMT-EDIT-$id',
        entityType: _resolveEntityType(updated.entityType),
        entityId: updated.entityId,
        entityLabel: '${updated.entityType} ${updated.entityId}',
        action: AuditAction.edited,
        performedAt: updated.editedAt!,
        performedBy: updated.author,
        note: 'Comment edited by ${updated.author}',
        previousValue: old.message,
        newValue: newMessage,
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<void>> deleteComment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final idx = _comments.indexWhere((c) => c.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Comment not found'),
      );
    }
    final removed = _comments[idx];
    _comments.removeAt(idx);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-CMT-DEL-$id',
        entityType: _resolveEntityType(removed.entityType),
        entityId: removed.entityId,
        entityLabel: '${removed.entityType} ${removed.entityId}',
        action: AuditAction.deleted,
        performedAt: DateTime.now(),
        performedBy: removed.author,
        note: 'Comment deleted',
      ),
    );

    return AppResult.success(null);
  }

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
