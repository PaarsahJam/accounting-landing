// lib/features/recurring_transactions/data/recurring_transactions_repository.dart

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/recurring_transaction.dart';

abstract class RecurringTransactionsRepository {
  Future<AppResult<List<RecurringTransaction>>> fetchRecurringTransactions();

  Future<AppResult<RecurringTransaction>> createRecurringTransaction(
    RecurringTransaction transaction,
  );

  Future<AppResult<RecurringTransaction>> updateRecurringTransaction(
    RecurringTransaction transaction,
  );

  Future<AppResult<RecurringTransaction>> activate(String id);

  Future<AppResult<RecurringTransaction>> deactivate(String id);

  /// Mock-only: simulate immediate execution and advance nextRun.
  Future<AppResult<RecurringTransaction>> executeNow(String id);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockRecurringTransactionsRepository
    implements RecurringTransactionsRepository {
  MockRecurringTransactionsRepository({AuditTrailRepository? auditRepository})
    : _audit = auditRepository ?? MockAuditTrailRepository() {
    _seed();
  }

  final AuditTrailRepository _audit;
  final List<RecurringTransaction> _items = [];
  int _idCounter = 5;

  String _nextId() => 'RT-${_idCounter++}';

  void _seed() {
    final base = DateTime(2026, 2, 1);
    _items.addAll([
      RecurringTransaction(
        id: 'RT-001',
        name: 'Monthly Office Rent',
        sourceDocumentId: 'VB-2026-000010',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.monthly,
        nextRun: DateTime(base.year, base.month + 1, 1),
        lastRun: base,
        isActive: true,
        notes: 'Rent for the main office space',
      ),
      RecurringTransaction(
        id: 'RT-002',
        name: 'Internet Subscription',
        sourceDocumentId: 'VB-2026-000011',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.monthly,
        nextRun: DateTime(base.year, base.month + 1, 5),
        lastRun: DateTime(base.year, base.month, 5),
        isActive: true,
        notes: 'Monthly ISP invoice',
      ),
      RecurringTransaction(
        id: 'RT-003',
        name: 'Software Subscription',
        sourceDocumentId: 'VB-2026-000012',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.yearly,
        nextRun: DateTime(base.year + 1, 1, 1),
        lastRun: DateTime(base.year, 1, 1),
        isActive: true,
        notes: 'Annual SaaS licence renewal',
      ),
      RecurringTransaction(
        id: 'RT-004',
        name: 'Monthly Insurance',
        sourceDocumentId: 'VB-2026-000013',
        sourceDocumentType: 'Vendor Bill',
        frequency: RecurrenceFrequency.monthly,
        nextRun: DateTime(base.year, base.month + 1, 15),
        lastRun: DateTime(base.year, base.month, 15),
        isActive: false,
        notes: 'Building insurance — currently paused',
      ),
    ]);
  }

  @override
  Future<AppResult<List<RecurringTransaction>>>
  fetchRecurringTransactions() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_items));
  }

  @override
  Future<AppResult<RecurringTransaction>> createRecurringTransaction(
    RecurringTransaction transaction,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final created = transaction.copyWith(id: _nextId());
    _items.add(created);

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-RT-CREATE-${created.id}',
        entityType: AuditEntityType.financialReport,
        entityId: created.id,
        entityLabel: created.name,
        action: AuditAction.created,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Recurring transaction created',
      ),
    );

    return AppResult.success(created);
  }

  @override
  Future<AppResult<RecurringTransaction>> updateRecurringTransaction(
    RecurringTransaction transaction,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _items.indexWhere((t) => t.id == transaction.id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Recurring transaction not found'),
      );
    }
    _items[idx] = transaction;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-RT-EDIT-${transaction.id}',
        entityType: AuditEntityType.financialReport,
        entityId: transaction.id,
        entityLabel: transaction.name,
        action: AuditAction.edited,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Recurring transaction updated',
      ),
    );

    return AppResult.success(transaction);
  }

  @override
  Future<AppResult<RecurringTransaction>> activate(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _items.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Recurring transaction not found'),
      );
    }
    final updated = _items[idx].copyWith(isActive: true);
    _items[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-RT-ACTIVATE-$id',
        entityType: AuditEntityType.financialReport,
        entityId: id,
        entityLabel: updated.name,
        action: AuditAction.reopened,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Recurring transaction activated',
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<RecurringTransaction>> deactivate(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _items.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Recurring transaction not found'),
      );
    }
    final updated = _items[idx].copyWith(isActive: false);
    _items[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-RT-DEACTIVATE-$id',
        entityType: AuditEntityType.financialReport,
        entityId: id,
        entityLabel: updated.name,
        action: AuditAction.cancelled,
        performedAt: DateTime.now(),
        performedBy: 'system',
        note: 'Recurring transaction deactivated',
      ),
    );

    return AppResult.success(updated);
  }

  @override
  Future<AppResult<RecurringTransaction>> executeNow(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final idx = _items.indexWhere((t) => t.id == id);
    if (idx < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Recurring transaction not found'),
      );
    }
    final now = DateTime.now();
    final item = _items[idx];
    final updated = item.copyWith(
      lastRun: now,
      nextRun: _advanceNextRun(item.nextRun, item.frequency),
    );
    _items[idx] = updated;

    await _audit.addEntry(
      AuditEntry(
        id: 'AUD-RT-EXEC-$id-${now.millisecondsSinceEpoch}',
        entityType: AuditEntityType.financialReport,
        entityId: id,
        entityLabel: updated.name,
        action: AuditAction.posted,
        performedAt: now,
        performedBy: 'system',
        note: 'Recurring transaction executed (mock)',
      ),
    );

    return AppResult.success(updated);
  }

  /// Advances a date by one frequency interval.
  DateTime _advanceNextRun(DateTime from, RecurrenceFrequency freq) {
    switch (freq) {
      case RecurrenceFrequency.daily:
        return from.add(const Duration(days: 1));
      case RecurrenceFrequency.weekly:
        return from.add(const Duration(days: 7));
      case RecurrenceFrequency.monthly:
        return DateTime(from.year, from.month + 1, from.day);
      case RecurrenceFrequency.quarterly:
        return DateTime(from.year, from.month + 3, from.day);
      case RecurrenceFrequency.yearly:
        return DateTime(from.year + 1, from.month, from.day);
    }
  }
}
