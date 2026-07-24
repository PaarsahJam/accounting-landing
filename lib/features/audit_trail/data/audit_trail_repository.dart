// lib/features/audit_trail/data/audit_trail_repository.dart

import '../../../core/errors/app_result.dart';
import '../domain/audit_action.dart';
import '../domain/audit_entry.dart';
import '../domain/audit_entity_type.dart';
import '../domain/audit_filter.dart';

abstract class AuditTrailRepository {
  /// Returns all entries (newest first) optionally narrowed by [filter].
  Future<AppResult<List<AuditEntry>>> fetchEntries({
    AuditFilter? filter,
    String? companyId,
  });

  /// Returns all entries for a single entity, newest first.
  Future<AppResult<List<AuditEntry>>> fetchEntriesForEntity(
    AuditEntityType entityType,
    String entityId, {
    String? companyId,
  });

  /// Returns all entries scoped to a company, newest first.
  Future<AppResult<List<AuditEntry>>> fetchEntriesForCompany(
    String companyId, {
    AuditFilter? filter,
  });

  /// Appends a new immutable [entry]. Returns the stored entry.
  Future<AppResult<AuditEntry>> addEntry(AuditEntry entry);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockAuditTrailRepository implements AuditTrailRepository {
  MockAuditTrailRepository() {
    _seed();
  }

  final List<AuditEntry> _entries = [];
  int _idCounter = 1;

  String _nextId() => 'AUD-${_idCounter++}';

  void _seed() {
    final base = DateTime(2026, 1, 10);

    // ── Sales Invoice: full lifecycle ─────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.created,
        performedAt: base,
        performedBy: 'alice',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.edited,
        performedAt: base.add(const Duration(hours: 2)),
        performedBy: 'alice',
        note: 'Corrected line item quantity',
        previousValue: 'qty: 5',
        newValue: 'qty: 8',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.submittedForApproval,
        performedAt: base.add(const Duration(hours: 3)),
        performedBy: 'alice',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.approved,
        performedAt: base.add(const Duration(hours: 5)),
        performedBy: 'bob',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.posted,
        performedAt: base.add(const Duration(hours: 6)),
        performedBy: 'bob',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.printed,
        performedAt: base.add(const Duration(hours: 7)),
        performedBy: 'alice',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice SI-2026-000001',
        action: AuditAction.paid,
        performedAt: base.add(const Duration(days: 5)),
        performedBy: 'system',
        note: 'Full payment received',
      ),
    );

    // ── Vendor Bill ──────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.vendorBill,
        entityId: 'VB-2026-000001',
        entityLabel: 'Vendor Bill VB-2026-000001',
        action: AuditAction.created,
        performedAt: base.add(const Duration(days: 1)),
        performedBy: 'charlie',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.vendorBill,
        entityId: 'VB-2026-000001',
        entityLabel: 'Vendor Bill VB-2026-000001',
        action: AuditAction.edited,
        performedAt: base.add(const Duration(days: 1, hours: 1)),
        performedBy: 'charlie',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.vendorBill,
        entityId: 'VB-2026-000001',
        entityLabel: 'Vendor Bill VB-2026-000001',
        action: AuditAction.approved,
        performedAt: base.add(const Duration(days: 2)),
        performedBy: 'bob',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.vendorBill,
        entityId: 'VB-2026-000001',
        entityLabel: 'Vendor Bill VB-2026-000001',
        action: AuditAction.paid,
        performedAt: base.add(const Duration(days: 4)),
        performedBy: 'system',
      ),
    );

    // ── Customer ─────────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.customer,
        entityId: 'CUST-001',
        entityLabel: 'Acme Corp',
        action: AuditAction.created,
        performedAt: base.subtract(const Duration(days: 30)),
        performedBy: 'alice',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.customer,
        entityId: 'CUST-001',
        entityLabel: 'Acme Corp',
        action: AuditAction.addressChanged,
        performedAt: base.subtract(const Duration(days: 10)),
        performedBy: 'alice',
        previousValue: '123 Old St',
        newValue: '456 New Ave',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.customer,
        entityId: 'CUST-001',
        entityLabel: 'Acme Corp',
        action: AuditAction.contactChanged,
        performedAt: base.subtract(const Duration(days: 5)),
        performedBy: 'alice',
        previousValue: '+1-555-0001',
        newValue: '+1-555-9999',
      ),
    );

    // ── Inventory ────────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.inventory,
        entityId: 'PROD-001',
        entityLabel: 'Printer Paper A4',
        action: AuditAction.stockAdjusted,
        performedAt: base.add(const Duration(days: 2)),
        performedBy: 'warehouse',
        previousValue: '100',
        newValue: '90',
        note: 'Damaged stock removal',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.inventory,
        entityId: 'PROD-001',
        entityLabel: 'Printer Paper A4',
        action: AuditAction.stockTransferred,
        performedAt: base.add(const Duration(days: 3)),
        performedBy: 'warehouse',
        note: 'Transferred to WH-2',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.inventory,
        entityId: 'PROD-001',
        entityLabel: 'Printer Paper A4',
        action: AuditAction.stockCounted,
        performedAt: base.add(const Duration(days: 7)),
        performedBy: 'warehouse',
        newValue: '85',
      ),
    );

    // ── Purchase Order ────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.purchaseOrder,
        entityId: 'PO-2026-000001',
        entityLabel: 'Purchase Order PO-2026-000001',
        action: AuditAction.created,
        performedAt: base.subtract(const Duration(days: 5)),
        performedBy: 'charlie',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.purchaseOrder,
        entityId: 'PO-2026-000001',
        entityLabel: 'Purchase Order PO-2026-000001',
        action: AuditAction.approved,
        performedAt: base.subtract(const Duration(days: 3)),
        performedBy: 'bob',
      ),
    );

    // ── Journal ───────────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.journalEntry,
        entityId: 'JV-2026-000001',
        entityLabel: 'Journal Entry JV-2026-000001',
        action: AuditAction.journalGenerated,
        performedAt: base.add(const Duration(days: 6)),
        performedBy: 'system',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.journalEntry,
        entityId: 'JV-2026-000001',
        entityLabel: 'Journal Entry JV-2026-000001',
        action: AuditAction.journalReviewed,
        performedAt: base.add(const Duration(days: 6, hours: 2)),
        performedBy: 'bob',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.journalEntry,
        entityId: 'JV-2026-000001',
        entityLabel: 'Journal Entry JV-2026-000001',
        action: AuditAction.posted,
        performedAt: base.add(const Duration(days: 6, hours: 3)),
        performedBy: 'bob',
      ),
    );

    // ── Fiscal Period ─────────────────────────────────────────────────────────
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.fiscalPeriod,
        entityId: 'FP-2026-01',
        entityLabel: 'Fiscal Period Jan 2026',
        action: AuditAction.periodOpened,
        performedAt: DateTime(2026, 1, 1),
        performedBy: 'system',
      ),
    );
    _add(
      AuditEntry(
        id: _nextId(),
        entityType: AuditEntityType.fiscalPeriod,
        entityId: 'FP-2026-01',
        entityLabel: 'Fiscal Period Jan 2026',
        action: AuditAction.periodClosed,
        performedAt: DateTime(2026, 1, 31, 23, 59),
        performedBy: 'system',
      ),
    );

    // Sort newest first
    _entries.sort((a, b) => b.performedAt.compareTo(a.performedAt));
  }

  void _add(AuditEntry entry) => _entries.add(entry);

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntries({
    AuditFilter? filter,
    String? companyId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    Iterable<AuditEntry> result = List<AuditEntry>.from(_entries);
    if (companyId != null) {
      result = result.where((e) => e.companyId == companyId);
    }
    if (filter != null) {
      result = result.where(filter.matches);
    }
    return AppResult.success(List.unmodifiable(result));
  }

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForEntity(
    AuditEntityType entityType,
    String entityId, {
    String? companyId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    var result = _entries
        .where((e) => e.entityType == entityType && e.entityId == entityId);
    if (companyId != null) {
      result = result.where((e) => e.companyId == companyId);
    }
    return AppResult.success(List.unmodifiable(result.toList()));
  }

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForCompany(
    String companyId, {
    AuditFilter? filter,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    Iterable<AuditEntry> result =
        _entries.where((e) => e.companyId == companyId);
    if (filter != null) {
      result = result.where(filter.matches);
    }
    return AppResult.success(List.unmodifiable(result.toList()));
  }

  @override
  Future<AppResult<AuditEntry>> addEntry(AuditEntry entry) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    // Insert at head so newest-first order is maintained
    _entries.insert(0, entry);
    return AppResult.success(entry);
  }
}
