// lib/features/audit_trail/domain/audit_action.dart

/// Every distinct action that can be recorded in the audit trail.
///
/// Grouped by kind so widgets can apply consistent icons/colours.
enum AuditAction {
  // ── Lifecycle ──────────────────────────────────────────────────────────────
  created,
  edited,
  deleted,

  // ── Approval workflow ──────────────────────────────────────────────────────
  submittedForApproval,
  approved,
  rejected,
  posted,
  locked,
  cancelled,
  reopened,

  // ── Financial events ───────────────────────────────────────────────────────
  paid,
  partiallyPaid,
  refunded,
  printed,
  exported,

  // ── Inventory ──────────────────────────────────────────────────────────────
  stockAdjusted,
  stockTransferred,
  stockCounted,

  // ── Journal ────────────────────────────────────────────────────────────────
  journalGenerated,
  journalReviewed,

  // ── Customer / Vendor ──────────────────────────────────────────────────────
  addressChanged,
  contactChanged,
  archived,
  unarchived,

  // ── Fiscal ─────────────────────────────────────────────────────────────────
  periodOpened,
  periodClosed,

  // ── Sync / Offline ─────────────────────────────────────────────────────────
  syncEnqueued,
  syncCompleted,
  syncFailed,
  syncConflictResolved;

  /// Short display label.
  String get label {
    switch (this) {
      case AuditAction.created:
        return 'Created';
      case AuditAction.edited:
        return 'Edited';
      case AuditAction.deleted:
        return 'Deleted';
      case AuditAction.submittedForApproval:
        return 'Submitted for Approval';
      case AuditAction.approved:
        return 'Approved';
      case AuditAction.rejected:
        return 'Rejected';
      case AuditAction.posted:
        return 'Posted';
      case AuditAction.locked:
        return 'Locked';
      case AuditAction.cancelled:
        return 'Cancelled';
      case AuditAction.reopened:
        return 'Reopened';
      case AuditAction.paid:
        return 'Paid';
      case AuditAction.partiallyPaid:
        return 'Partially Paid';
      case AuditAction.refunded:
        return 'Refunded';
      case AuditAction.printed:
        return 'Printed';
      case AuditAction.exported:
        return 'Exported';
      case AuditAction.stockAdjusted:
        return 'Stock Adjusted';
      case AuditAction.stockTransferred:
        return 'Stock Transferred';
      case AuditAction.stockCounted:
        return 'Stock Counted';
      case AuditAction.journalGenerated:
        return 'Journal Generated';
      case AuditAction.journalReviewed:
        return 'Journal Reviewed';
      case AuditAction.addressChanged:
        return 'Address Changed';
      case AuditAction.contactChanged:
        return 'Contact Changed';
      case AuditAction.archived:
        return 'Archived';
      case AuditAction.unarchived:
        return 'Unarchived';
      case AuditAction.periodOpened:
        return 'Period Opened';
      case AuditAction.periodClosed:
        return 'Period Closed';
      case AuditAction.syncEnqueued:
        return 'Sync Enqueued';
      case AuditAction.syncCompleted:
        return 'Sync Completed';
      case AuditAction.syncFailed:
        return 'Sync Failed';
      case AuditAction.syncConflictResolved:
        return 'Sync Conflict Resolved';
    }
  }
}
