import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _approve() async {
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

  Future<void> _reject() async {
    final l10n = AppLocalizations.of(context)!;
    final note = await _showRejectDialog(l10n);
    if (note == null) return; // cancelled
    setState(() => _submitting = true);
    await ref.read(documentProcessingControllerProvider.notifier).reject(
          widget.job,
          note: note,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    context.pop();
  }

  Future<String?> _showRejectDialog(AppLocalizations l10n) async {
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
              Navigator.of(ctx).pop(text.isEmpty ? l10n.docReviewRejectedDefault : text);
            },
            child: Text(l10n.docReviewRejectConfirm),
          ),
        ],
      ),
    );
  }

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
                        foregroundColor: Theme.of(context).colorScheme.error,
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
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_circle_outline),
                      label: Text(l10n.docReviewApproveAction),
                    ),
                  ),
                ],
              ),
            ],
            if (!canAct && job.reviewDecision != null) ...[
              const SizedBox(height: 20),
              _SectionHeader(l10n.docReviewDecisionSection),
              _InfoRow(l10n.docReviewDecisionOutcome,
                  job.reviewDecision!.outcome.name),
              _InfoRow(l10n.docReviewDecisionBy,
                  job.reviewDecision!.reviewedBy),
              if (job.reviewDecision!.note != null)
                _InfoRow(l10n.docReviewDecisionNote,
                    job.reviewDecision!.note!),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
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
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
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
    final rows = _rows();
    if (rows.isEmpty) {
      return Text(
        draft.documentType.label,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
    return Column(
      children: rows
          .map((r) => _InfoRow(r.$1, r.$2))
          .toList(),
    );
  }

  List<(String, String)> _rows() {
    final d = draft;
    if (d is InvoiceDraft) {
      return [
        ('Customer', d.customerName.value ?? '—'),
        ('Reference', d.reference.value ?? '—'),
        ('Total', d.total.value?.toStringAsFixed(2) ?? '—'),
      ];
    }
    if (d is VendorBillDraft) {
      return [
        ('Vendor', d.vendorName.value ?? '—'),
        ('Reference', d.reference.value ?? '—'),
        ('Total', d.total.value?.toStringAsFixed(2) ?? '—'),
      ];
    }
    if (d is ExpenseReceiptDraft) {
      return [
        ('Merchant', d.merchant.value ?? '—'),
        ('Amount', d.amount.value?.toStringAsFixed(2) ?? '—'),
      ];
    }
    if (d is BankStatementDraft) {
      return [
        ('Account', d.accountNumber.value ?? '—'),
        ('Closing Balance', d.closingBalance.value?.toStringAsFixed(2) ?? '—'),
      ];
    }
    return [];
  }
}
