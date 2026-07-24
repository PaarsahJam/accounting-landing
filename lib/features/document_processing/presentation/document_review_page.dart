import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/app_result.dart';
import '../../../core/finance/balance_snapshot.dart';
import '../../../core/finance/chart_of_accounts.dart';
import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/journal_posting_service.dart';
import '../../../core/finance/ledger_repository.dart';
import '../../../core/finance/ledger_service.dart';
import '../../../core/finance/ledger_service_provider.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_filter.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/document_processing_controller.dart';
import '../domain/document_processing_job.dart';
import '../domain/extracted_document_draft.dart';

class DocumentReviewPage extends ConsumerStatefulWidget {
  const DocumentReviewPage({required this.job, super.key});

  final DocumentProcessingJob job;

  @override
  ConsumerState<DocumentReviewPage> createState() => _DocumentReviewPageState();
}

class _DocumentReviewPageState extends ConsumerState<DocumentReviewPage> {
  final _noteController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // ── Approve flow ──────────────────────────────────────────────────────────

  Future<void> _approve() async {
    // If the draft can produce a journal entry, show the preview + confirm
    // dialog before committing. This is the mandatory review-before-post step.
    if (widget.job.draft != null) {
      final confirmed = await _showJournalPreviewDialog();
      if (confirmed != true) return;
    }

    setState(() => _submitting = true);
    await ref.read(documentProcessingControllerProvider.notifier).approve(
          widget.job,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    context.pop();
  }

  /// Shows the balanced journal entry that will be posted, and asks the user
  /// to confirm. Returns true only when the user explicitly taps "Post & Create".
  Future<bool?> _showJournalPreviewDialog() {
    final l10n = AppLocalizations.of(context)!;
    final service = JournalPostingService(
      ledgerService: ref.read(ledgerServiceProvider),
      auditRepository: ref.read(auditTrailRepositoryProvider),
    );
    final buildResult = service.buildEntry(
      widget.job.draft!,
      documentId: widget.job.id,
      postingDate: DateTime.now(),
    );

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.docReviewJournalPreviewTitle),
        content: SizedBox(
          width: 480,
          child: buildResult.isSuccess
              ? _JournalPreviewContent(entry: buildResult.data!)
              : _JournalPreviewError(message: buildResult.error!.message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel),
          ),
          if (buildResult.isSuccess)
            FilledButton.icon(
              onPressed: () => Navigator.of(ctx).pop(true),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l10n.docReviewPostAndCreate),
            ),
        ],
      ),
    );
  }

  // ── Reject flow ───────────────────────────────────────────────────────────

  Future<void> _reject() async {
    final l10n = AppLocalizations.of(context)!;
    final note = await _showRejectDialog(l10n);
    if (note == null) return;
    setState(() => _submitting = true);
    await ref.read(documentProcessingControllerProvider.notifier).reject(
          widget.job,
          note: note,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    context.pop();
  }

  Future<String?> _showRejectDialog(AppLocalizations l10n) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.docReviewRejectTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: l10n.docReviewRejectNoteLabel,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              Navigator.of(ctx).pop(
                text.isEmpty ? l10n.docReviewRejectedDefault : text,
              );
            },
            child: Text(l10n.docReviewRejectConfirm),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final job = widget.job;
    final canAct = job.step == ProcessingStep.awaitingReview && !_submitting;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.docReviewPageTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(l10n.docReviewDocumentSection),
            _InfoRow(l10n.docProcessingJobId, job.id),
            _InfoRow(l10n.docReviewAttachment, job.attachmentId),
            _InfoRow(l10n.docReviewStatus, job.step.label),
            if (job.classification != null) ...[
              _InfoRow(
                l10n.docReviewDocumentType,
                job.classification!.documentType.label,
              ),
              _InfoRow(
                l10n.docReviewConfidence,
                '${(job.classification!.confidence * 100).toStringAsFixed(0)}%',
              ),
            ],
            const SizedBox(height: 20),
            if (job.draft != null) ...[
              _SectionHeader(l10n.docReviewExtractedSection),
              _DraftSummary(draft: job.draft!),
              const SizedBox(height: 8),
              // Inline balance indicator — shows the user what will be posted
              _BalanceIndicator(draft: job.draft!),
              const SizedBox(height: 20),
            ],
            if (canAct) ...[
              _SectionHeader(l10n.docReviewNoteSection),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.docReviewNoteHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _submitting ? null : _reject,
                      icon: const Icon(Icons.cancel_outlined),
                      label: Text(l10n.docReviewRejectAction),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.error,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _submitting ? null : _approve,
                      icon: _submitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2),
                            )
                          : const Icon(Icons.preview_outlined),
                      label: Text(l10n.docReviewApproveAction),
                    ),
                  ),
                ],
              ),
            ],
            if (!canAct && job.reviewDecision != null) ...[
              const SizedBox(height: 20),
              _SectionHeader(l10n.docReviewDecisionSection),
              _InfoRow(
                  l10n.docReviewDecisionOutcome,
                  job.reviewDecision!.outcome.name),
              _InfoRow(
                  l10n.docReviewDecisionBy,
                  job.reviewDecision!.reviewedBy),
              if (job.reviewDecision!.note != null)
                _InfoRow(
                    l10n.docReviewDecisionNote,
                    job.reviewDecision!.note!),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Shared layout primitives ──────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _DraftSummary extends StatelessWidget {
  const _DraftSummary({required this.draft});

  final ExtractedDocumentDraft draft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fields = _fieldsFor(draft);
    if (fields.isEmpty) {
      return Text(
        'No extracted fields available.',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields
          .map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: _InfoRow(f.$1, f.$2),
            ),
          )
          .toList(),
    );
  }

  static List<(String, String)> _fieldsFor(ExtractedDocumentDraft draft) {
    if (draft is InvoiceDraft) {
      return [
        if (draft.reference.value != null) ('Reference', draft.reference.value!),
        if (draft.customerName.value != null) ('Customer', draft.customerName.value!),
        if (draft.total.value != null) ('Total', draft.total.value!.toStringAsFixed(2)),
      ];
    }
    if (draft is VendorBillDraft) {
      return [
        if (draft.reference.value != null) ('Reference', draft.reference.value!),
        if (draft.vendorName.value != null) ('Vendor', draft.vendorName.value!),
        if (draft.total.value != null) ('Total', draft.total.value!.toStringAsFixed(2)),
      ];
    }
    if (draft is ExpenseReceiptDraft) {
      return [
        if (draft.merchant.value != null) ('Merchant', draft.merchant.value!),
        if (draft.amount.value != null) ('Amount', draft.amount.value!.toStringAsFixed(2)),
      ];
    }
    return const [];
  }
}

// ── Journal preview dialog content ────────────────────────────────────────────

class _JournalPreviewContent extends StatelessWidget {
  const _JournalPreviewContent({required this.entry});

  final dynamic entry; // JournalEntry

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reference: ${entry.reference}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        ...List.generate(entry.lines.length, (i) {
          final line = entry.lines[i];
          final isDebit = (line.amount as double) >= 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    line.description ?? line.accountId,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  isDebit
                      ? 'DR ${(line.amount as double).abs().toStringAsFixed(2)}'
                      : 'CR ${(line.amount as double).abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isDebit
                        ? cs.primary
                        : cs.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }),
        const Divider(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.check_circle, color: cs.primary, size: 16),
            const SizedBox(width: 4),
            Text(
              'Balanced',
              style: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _JournalPreviewError extends StatelessWidget {
  const _JournalPreviewError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: cs.error),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: cs.error),
          ),
        ),
      ],
    );
  }
}

// ── Balance indicator (inline, below extracted data) ─────────────────────────

class _BalanceIndicator extends StatelessWidget {
  const _BalanceIndicator({required this.draft});

  final ExtractedDocumentDraft draft;

  @override
  Widget build(BuildContext context) {
    // Build a preview entry to check balance — pure, no I/O
    final service = JournalPostingService(
      ledgerService: _LedgerServiceFake(),
      auditRepository: _AuditRepositoryFake(),
    );
    final result = service.buildEntry(
      draft,
      documentId: 'preview',
      postingDate: DateTime.now(),
    );

    final cs = Theme.of(context).colorScheme;
    if (!result.isSuccess) {
      return Row(
        children: [
          Icon(Icons.info_outline, size: 14, color: cs.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            'Manual entry required for this document type',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      );
    }
    return Row(
      children: [
        Icon(Icons.account_balance_outlined, size: 14, color: cs.primary),
        const SizedBox(width: 4),
        Text(
          'Journal entry ready — balanced',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: cs.primary),
        ),
      ],
    );
  }
}

// ── Fake dependencies for pure balance check in widget ────────────────────────
// These are only used for the synchronous buildEntry() call in _BalanceIndicator
// which never calls any async methods.

class _LedgerServiceFake extends LedgerService {
  _LedgerServiceFake() : super(_FakeLedgerRepo());
}

class _FakeLedgerRepo implements LedgerRepository {
  @override
  Future<void> postJournalEntry(JournalEntry entry) async {}
  @override
  Future<List<JournalEntry>> fetchEntries() async => const [];
  @override
  Future<ChartOfAccounts> fetchChartOfAccounts() async =>
      ChartOfAccounts.mockDefault();
  @override
  Future<BalanceSnapshot> calculateBalanceSnapshot(
          {required String periodId}) async =>
      BalanceSnapshot(periodId: periodId, balances: const {});
}

class _AuditRepositoryFake implements AuditTrailRepository {
  @override
  Future<AppResult<AuditEntry>> addEntry(AuditEntry entry) async =>
      AppResult.success(entry);
  @override
  Future<AppResult<List<AuditEntry>>> fetchEntries(
          {AuditFilter? filter, String? companyId}) async =>
      AppResult.success(const []);
  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForEntity(
          dynamic entityType, String entityId,
          {String? companyId}) async =>
      AppResult.success(const []);
  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForCompany(String companyId,
          {AuditFilter? filter}) async =>
      AppResult.success(const []);
}
