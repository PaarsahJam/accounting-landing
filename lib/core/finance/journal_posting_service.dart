import '../errors/app_failure.dart';
import '../errors/app_result.dart';
import '../logging/app_logger.dart';
import '../../features/audit_trail/data/audit_trail_repository.dart';
import '../../features/audit_trail/domain/audit_action.dart';
import '../../features/audit_trail/domain/audit_entity_type.dart';
import '../../features/audit_trail/domain/audit_entry.dart';
import '../../features/document_processing/domain/extracted_document_draft.dart';
import 'journal_entry.dart';
import 'ledger_service.dart';
import 'transaction_line.dart';

/// Builds a balanced [JournalEntry] from an [ExtractedDocumentDraft],
/// validates the double-entry invariant, posts it through [LedgerService],
/// and records an audit entry.
///
/// Rules enforced here:
/// - Entry is always routed through [LedgerService.postEntry], never directly
///   to the repository.
/// - [JournalEntry.validate()] is called before any persistence — an unbalanced
///   entry is rejected with [ValidationFailure] and nothing is written.
/// - All failures are returned as [AppResult.failure]; this service never throws
///   across its public boundary.
/// - An audit entry is written after every successful post.
/// - A preview can be generated without posting via [buildEntry].
class JournalPostingService {
  const JournalPostingService({
    required LedgerService ledgerService,
    required AuditTrailRepository auditRepository,
    this.currency = 'USD',
    this.performedBy = 'system',
  })  : _ledger = ledgerService,
        _audit = auditRepository;

  final LedgerService _ledger;
  final AuditTrailRepository _audit;
  final String currency;
  final String performedBy;

  // ── Account codes from ChartOfAccounts.mockDefault() ──────────────────────
  static const _accountsReceivable = '1';   // 1000 Cash / used as AR proxy
  static const _accountsPayable    = '2';   // 2000 Accounts Payable
  static const _revenue            = '4';   // 4000 Revenue
  static const _expenses           = '5';   // 5000 Expenses

  // ─── Public API ───────────────────────────────────────────────────────────

  /// Returns a preview [JournalEntry] without posting it.
  ///
  /// Callers should show this to the user before calling [postFromDraft].
  AppResult<JournalEntry> buildEntry(
    ExtractedDocumentDraft draft, {
    required String documentId,
    required DateTime postingDate,
  }) {
    try {
      final lines = _linesFor(draft);
      if (lines.isEmpty) {
        return AppResult.failure(const ValidationFailure(
          message: 'No journal lines could be derived from this document type.',
        ));
      }
      final entry = JournalEntry(
        id: 'JV-PREVIEW-$documentId',
        date: postingDate,
        reference: documentId,
        memo: 'Auto-generated from ${draft.documentType.label}',
        lines: lines,
      );
      // Validate balance before returning the preview — fail fast.
      if (!entry.isBalanced) {
        return AppResult.failure(ValidationFailure(
          message: 'Journal entry is not balanced '
              '(total: ${entry.total.toStringAsFixed(4)}). '
              'Cannot post an unbalanced entry.',
        ));
      }
      return AppResult.success(entry);
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }

  /// Validates and posts the journal entry derived from [draft].
  ///
  /// Steps:
  /// 1. Build the entry via [buildEntry] — returns failure if unbalanced.
  /// 2. Call [LedgerService.postEntry] — which calls [JournalEntry.validate()]
  ///    again as a second guard before writing to the repository.
  /// 3. Write an audit entry.
  ///
  /// Returns [AppResult.success] with the posted [JournalEntry] on success.
  Future<AppResult<JournalEntry>> postFromDraft(
    ExtractedDocumentDraft draft, {
    required String documentId,
    required DateTime postingDate,
  }) async {
    // Step 1: build + validate balance (pure, no I/O)
    final buildResult = buildEntry(
      draft,
      documentId: documentId,
      postingDate: postingDate,
    );
    if (!buildResult.isSuccess) return buildResult;

    final entry = buildResult.data!.copyWith(
      id: 'JV-${DateTime.now().millisecondsSinceEpoch}-$documentId',
    );

    // Step 2: post through LedgerService — validate() is called inside
    try {
      await _ledger.postEntry(entry);
    } on ArgumentError catch (e) {
      // LedgerService.postEntry throws ArgumentError for unbalanced entries.
      // Convert to AppResult so callers never see a raw exception.
      AppLogger.warning('JournalPostingService: unbalanced entry rejected',
          error: e);
      return AppResult.failure(
        ValidationFailure(message: e.message?.toString() ?? e.toString()),
      );
    } catch (e) {
      AppLogger.warning('JournalPostingService: postEntry failed', error: e);
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }

    // Step 3: audit
    await _audit.addEntry(AuditEntry(
      id: 'AUD-JV-${entry.id}',
      entityType: AuditEntityType.journalEntry,
      entityId: entry.id,
      entityLabel: 'Journal Entry ${entry.reference}',
      action: AuditAction.journalGenerated,
      performedAt: DateTime.now(),
      performedBy: performedBy,
      note: 'Posted from ${draft.documentType.label} $documentId',
      newValue: entry.id,
    ));

    AppLogger.info('JournalPostingService: posted ${entry.id} '
        'for $documentId (${draft.documentType.label})');
    return AppResult.success(entry);
  }

  // ─── Line builders ────────────────────────────────────────────────────────

  List<TransactionLine> _linesFor(ExtractedDocumentDraft draft) {
    final d = draft;
    if (d is InvoiceDraft) return _invoiceLines(d);
    if (d is VendorBillDraft) return _vendorBillLines(d);
    if (d is ExpenseReceiptDraft) return _expenseLines(d);
    // BankStatementDraft and UnsupportedDocumentDraft produce no lines —
    // they must go through manual entry.
    return const [];
  }

  /// DR Accounts Receivable / CR Revenue
  List<TransactionLine> _invoiceLines(InvoiceDraft d) {
    final amount = d.total.value ?? 0.0;
    return [
      TransactionLine(
        accountId: _accountsReceivable,
        amount: amount,
        currency: currency,
        description: 'AR — ${d.reference.value ?? d.documentType.label}',
      ),
      TransactionLine(
        accountId: _revenue,
        amount: -amount,
        currency: currency,
        description: 'Revenue — ${d.customerName.value ?? ''}',
      ),
    ];
  }

  /// DR Expenses / CR Accounts Payable
  List<TransactionLine> _vendorBillLines(VendorBillDraft d) {
    final amount = d.total.value ?? 0.0;
    return [
      TransactionLine(
        accountId: _expenses,
        amount: amount,
        currency: currency,
        description: 'Expense — ${d.reference.value ?? d.documentType.label}',
      ),
      TransactionLine(
        accountId: _accountsPayable,
        amount: -amount,
        currency: currency,
        description: 'AP — ${d.vendorName.value ?? ''}',
      ),
    ];
  }

  /// DR Expenses / CR Accounts Payable (same pattern as vendor bill)
  List<TransactionLine> _expenseLines(ExpenseReceiptDraft d) {
    final amount = d.amount.value ?? 0.0;
    return [
      TransactionLine(
        accountId: _expenses,
        amount: amount,
        currency: currency,
        description: 'Expense — ${d.merchant.value ?? d.documentType.label}',
      ),
      TransactionLine(
        accountId: _accountsPayable,
        amount: -amount,
        currency: currency,
        description: 'AP — ${d.description.value ?? ''}',
      ),
    ];
  }
}
