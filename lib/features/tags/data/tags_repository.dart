import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/tag.dart';

abstract class TagsRepository {
  /// Returns all defined tags.
  Future<AppResult<List<Tag>>> fetchTags();

  /// Creates a new tag. Returns the stored tag with a generated id.
  Future<AppResult<Tag>> createTag(Tag tag);

  /// Renames a tag.
  Future<AppResult<Tag>> renameTag(String id, String newName);

  /// Changes the colour of a tag.
  Future<AppResult<Tag>> changeColor(String id, String newColor);

  /// Updates the description of a tag.
  Future<AppResult<Tag>> updateDescription(String id, String description);

  /// Permanently deletes a tag and all its [EntityTag] associations.
  Future<AppResult<void>> deleteTag(String id);

  /// Returns tags currently assigned to the given entity.
  Future<AppResult<List<Tag>>> fetchTagsForEntity({
    required String entityType,
    required String entityId,
  });

  /// Assigns a tag to an entity. No-op if already assigned.
  Future<AppResult<void>> assignTag({
    required String entityType,
    required String entityId,
    required String tagId,
  });

  /// Removes a tag from an entity.
  Future<AppResult<void>> removeTagFromEntity({
    required String entityType,
    required String entityId,
    required String tagId,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockTagsRepository implements TagsRepository {
  MockTagsRepository({AuditTrailRepository? auditRepository})
    : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<Tag> _tags = [];
  final List<EntityTag> _assignments = [];
  int _seq = 1;

  String _nextId() =>
      'TAG-${DateTime.now().year}-${(_seq++).toString().padLeft(4, '0')}';

  void _seed() {
    _tags.addAll([
      const Tag(
        id: 'TAG-2026-0001',
        name: 'Urgent',
        color: '#E53935',
        description: 'Requires immediate attention',
      ),
      const Tag(
        id: 'TAG-2026-0002',
        name: 'Reviewed',
        color: '#43A047',
        description: 'Has been reviewed and approved',
      ),
      const Tag(
        id: 'TAG-2026-0003',
        name: 'On Hold',
        color: '#FB8C00',
        description: 'Processing paused pending further information',
      ),
      const Tag(
        id: 'TAG-2026-0004',
        name: 'Draft',
        color: '#757575',
        description: 'Work in progress',
      ),
    ]);
    _assignments.addAll([
      const EntityTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: 'TAG-2026-0001',
      ),
      const EntityTag(
        entityType: 'purchaseOrder',
        entityId: 'PO-2026-000001',
        tagId: 'TAG-2026-0002',
      ),
      const EntityTag(
        entityType: 'salesInvoice',
        entityId: 'SI-2026-000001',
        tagId: 'TAG-2026-0003',
      ),
      const EntityTag(
        entityType: 'vendorBill',
        entityId: 'VB-2026-000001',
        tagId: 'TAG-2026-0001',
      ),
    ]);
    _seq = 5;
  }

  @override
  Future<AppResult<List<Tag>>> fetchTags() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return AppResult.success(List.unmodifiable(_tags));
  }

  @override
  Future<AppResult<Tag>> createTag(Tag tag) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final stored = tag.id.isEmpty ? tag.copyWith(id: _nextId()) : tag;
    _tags.add(stored);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-CREATE-${stored.id}',
        entityType: AuditEntityType.inventory, // closest available proxy
        entityId: stored.id,
        entityLabel: 'Tag: ${stored.name}',
        action: AuditAction.created,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag "${stored.name}" created',
      ),
    );

    return AppResult.success(stored);
  }

  @override
  Future<AppResult<Tag>> renameTag(String id, String newName) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final idx = _tags.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'Tag not found'));
    }
    final old = _tags[idx];
    final updated = old.copyWith(name: newName);
    _tags[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-RENAME-$id',
        entityType: AuditEntityType.inventory,
        entityId: id,
        entityLabel: 'Tag: $newName',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag renamed from "${old.name}" to "$newName"',
        previousValue: old.name,
        newValue: newName,
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<Tag>> changeColor(String id, String newColor) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final idx = _tags.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'Tag not found'));
    }
    final old = _tags[idx];
    final updated = old.copyWith(color: newColor);
    _tags[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-COLOR-$id',
        entityType: AuditEntityType.inventory,
        entityId: id,
        entityLabel: 'Tag: ${old.name}',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag "${old.name}" color changed',
        previousValue: old.color,
        newValue: newColor,
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<Tag>> updateDescription(
    String id,
    String description,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final idx = _tags.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'Tag not found'));
    }
    final updated = _tags[idx].copyWith(description: description);
    _tags[idx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<void>> deleteTag(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final idx = _tags.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'Tag not found'));
    }
    final removed = _tags[idx];
    _tags.removeAt(idx);
    // Remove all assignments for this tag
    _assignments.removeWhere((a) => a.tagId == id);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-DEL-$id',
        entityType: AuditEntityType.inventory,
        entityId: id,
        entityLabel: 'Tag: ${removed.name}',
        action: AuditAction.deleted,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag "${removed.name}" deleted',
      ),
    );

    return AppResult.success(null);
  }

  @override
  Future<AppResult<List<Tag>>> fetchTagsForEntity({
    required String entityType,
    required String entityId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final tagIds = _assignments
        .where((a) => a.entityType == entityType && a.entityId == entityId)
        .map((a) => a.tagId)
        .toSet();
    final result = _tags.where((t) => tagIds.contains(t.id)).toList();
    return AppResult.success(List.unmodifiable(result));
  }

  @override
  Future<AppResult<void>> assignTag({
    required String entityType,
    required String entityId,
    required String tagId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final tagIdx = _tags.indexWhere((t) => t.id == tagId);
    if (tagIdx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'Tag not found'));
    }
    final already = _assignments.any(
      (a) =>
          a.entityType == entityType &&
          a.entityId == entityId &&
          a.tagId == tagId,
    );
    if (already) return AppResult.success(null); // idempotent

    _assignments.add(
      EntityTag(entityType: entityType, entityId: entityId, tagId: tagId),
    );

    final tag = _tags[tagIdx];
    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-ASSIGN-$tagId-$entityId',
        entityType: _resolveEntityType(entityType),
        entityId: entityId,
        entityLabel: '$entityType $entityId',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag "${tag.name}" assigned',
      ),
    );

    return AppResult.success(null);
  }

  @override
  Future<AppResult<void>> removeTagFromEntity({
    required String entityType,
    required String entityId,
    required String tagId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final before = _assignments.length;
    _assignments.removeWhere(
      (a) =>
          a.entityType == entityType &&
          a.entityId == entityId &&
          a.tagId == tagId,
    );
    if (_assignments.length == before) {
      return AppResult.failure(
        const UnknownFailure(message: 'Assignment not found'),
      );
    }

    final tag = _tags.firstWhere(
      (t) => t.id == tagId,
      orElse: () => const Tag(id: '', name: '', color: ''),
    );

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-TAG-REMOVE-$tagId-$entityId',
        entityType: _resolveEntityType(entityType),
        entityId: entityId,
        entityLabel: '$entityType $entityId',
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Tag "${tag.name}" removed',
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
