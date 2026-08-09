import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ai/ai_action.dart';
import '../../../core/ai/ai_action_gateway.dart';
import '../../../core/ai/ai_providers.dart';
import '../../../core/ai/use_cases/ai_draft_action.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../../sales_invoices/domain/sales_invoice.dart';
import '../../sales_invoices/domain/sales_invoice_line.dart';
import '../../sales_invoices/domain/sales_invoice_status.dart';
import '../../sales_invoices/domain/sales_invoices_controller.dart';
import 'action_copilot_draft.dart';

/// Drives the action copilot: generates drafts, tracks their lifecycle and
/// enforces the confirmation boundary.
///
/// The copilot NEVER commits an accounting action on its own. Every generated
/// draft starts in [CopilotDraftStatus.drafting], moves to [review] for the
/// user to read and edit, and can only be persisted by moving through
/// [confirming] and then [save]. [save] refuses to run unless the draft is
/// already in [confirming], which is only reachable through [confirm] after
/// the user explicitly approves the draft.
class ActionCopilotController extends Notifier<ActionCopilotDraft?> {
  @override
  ActionCopilotDraft? build() {
    // Keep the sales invoices controller alive so confirmed saves that create
    // invoices never run against a disposed provider.
    ref.listen(salesInvoicesControllerProvider, (_, _) {});
    return null;
  }

  /// Generates a draft of [kind] using the shared AI infrastructure.
  ///
  /// On failure (e.g. the AI provider is unavailable) the draft moves to
  /// [CopilotDraftStatus.error] so the UI can show a fallback; no mutation
  /// ever runs.
  Future<void> generate(CopilotDraftKind kind) async {
    state = ActionCopilotDraft(
      kind: kind,
      status: CopilotDraftStatus.drafting,
    );

    try {
      final liveContext = ref.read(aiLiveContextProvider);
      final context = await liveContext.contextForQuery(_queryFor(kind));

      final String content;
      switch (kind) {
        case CopilotDraftKind.invoiceSuggestion:
          final draft = ref.read(aiDraftActionProvider);
          final result = await draft.draft(
            actionType: AiActionType.draftCreate,
            entityContext: context,
            userInstruction: 'Suggest a new sales invoice.',
          );
          content = result.suggestion;
        case CopilotDraftKind.financialSummary:
          final summarizer = ref.read(aiSummarizeProvider);
          content = await summarizer.summarize(entityContext: context) ?? '';
        case CopilotDraftKind.nextBestAction:
          final draft = ref.read(aiDraftActionProvider);
          final result = await draft.draft(
            actionType: AiActionType.suggestAction,
            entityContext: context,
            userInstruction: 'Recommend the next best action for the business.',
          );
          content = result.suggestion;
      }

      state = ActionCopilotDraft(
        kind: kind,
        status: CopilotDraftStatus.review,
        content: content.trim(),
      );
    } catch (e) {
      state = ActionCopilotDraft(
        kind: kind,
        status: CopilotDraftStatus.error,
        errorMessage: '$e',
      );
    }
  }

  /// Replaces the draft content while the user is editing it.
  ///
  /// Editing keeps the draft in [CopilotDraftStatus.editing] and, importantly,
  /// resets the confirmation gate: a draft that changed after being generated
  /// must be confirmed again before it can be saved.
  void edit(String content) {
    final current = state;
    if (current == null) return;
    if (!current.isConfirmable) return;
    state = current.copyWith(
      status: CopilotDraftStatus.editing,
      content: content,
    );
  }

  /// Explicitly approves the current draft. This is the ONLY way to reach
  /// [CopilotDraftStatus.confirming], which is required before [save].
  void confirm() {
    final current = state;
    if (current == null || !current.isConfirmable) return;
    state = current.copyWith(status: CopilotDraftStatus.confirming);
  }

  /// Persists the confirmed draft. Refuses to run unless the draft has been
  /// explicitly confirmed (status == [CopilotDraftStatus.confirming]).
  ///
  /// Confirmed drafts are executed through [AiActionGateway.executeConfirmed],
  /// which writes an audit trail entry. Financial mutations additionally run
  /// through the gateway's confirmation gate.
  Future<AppResult<void>> save() async {
    final current = state;
    if (current == null ||
        current.status != CopilotDraftStatus.confirming) {
      return AppResult.failure(
        const UnknownFailure(
          message: 'Draft must be explicitly confirmed before it can be saved.',
        ),
      );
    }

    state = current.copyWith(status: CopilotDraftStatus.saving);
    try {
      final gateway = ref.read(aiActionGatewayProvider);
      final draftAction = ref.read(aiDraftActionProvider);
      final confirmed = _confirmedActionFor(current, draftAction);
      final result = await gateway.executeConfirmed(confirmed);

      state = current.copyWith(
        status: result.isSuccess
            ? CopilotDraftStatus.saved
            : CopilotDraftStatus.error,
        errorMessage: result.isSuccess ? null : result.error?.message,
        auditNote: result.isSuccess ? _savedNoteFor(current.kind) : null,
      );
      return result;
    } catch (e) {
      state = current.copyWith(
        status: CopilotDraftStatus.error,
        errorMessage: '$e',
      );
      return AppResult.failure(
        UnknownFailure(message: 'Failed to save draft: $e'),
      );
    }
  }

  /// Discards the current draft and returns to idle.
  void discard() => state = null;

  /// Builds the [ConfirmedAction] that persists this draft.
  ConfirmedAction<dynamic> _confirmedActionFor(
    ActionCopilotDraft draft,
    AiDraftAction draftAction,
  ) {
    switch (draft.kind) {
      case CopilotDraftKind.invoiceSuggestion:
        final invoice = _invoiceFromDraft(draft.content);
        return draftAction.createConfirmedAction(
          actionType: AiActionType.draftCreate,
          suggestionText: draft.content,
          action: () async {
            await ref
                .read(salesInvoicesControllerProvider.notifier)
                .createSalesInvoice(invoice);
            return AppResult.success(invoice);
          },
          entityType: AuditEntityType.salesInvoice,
          entityId: invoice.id,
          entityLabel: invoice.title,
        );
      case CopilotDraftKind.financialSummary:
        return draftAction.createConfirmedAction(
          actionType: AiActionType.summarize,
          suggestionText: draft.content,
          action: () async => AppResult.success(true),
          entityType: AuditEntityType.aiAssistant,
          entityLabel: 'Action copilot: financial summary',
        );
      case CopilotDraftKind.nextBestAction:
        return draftAction.createConfirmedAction(
          actionType: AiActionType.suggestAction,
          suggestionText: draft.content,
          action: () async => AppResult.success(true),
          entityType: AuditEntityType.aiAssistant,
          entityLabel: 'Action copilot: next best action',
        );
    }
  }

  String _savedNoteFor(CopilotDraftKind kind) => switch (kind) {
        CopilotDraftKind.invoiceSuggestion =>
          'Sales invoice created from AI draft.',
        CopilotDraftKind.financialSummary =>
          'Financial summary accepted.',
        CopilotDraftKind.nextBestAction => 'Next best action accepted.',
      };

  String _queryFor(CopilotDraftKind kind) => switch (kind) {
        CopilotDraftKind.invoiceSuggestion => 'invoice suggestion',
        CopilotDraftKind.financialSummary => 'business overview',
        CopilotDraftKind.nextBestAction => 'next best action',
      };

  /// Parses a sales invoice out of the AI draft text.
  ///
  /// The AI returns free-form text, so the parser extracts the customer, a
  /// numeric amount and the title with sensible fallbacks so a confirmed draft
  /// always produces a valid, draft-status sales invoice.
  SalesInvoice _invoiceFromDraft(String content) {
    final id = 'SI-AI-${DateTime.now().microsecondsSinceEpoch}';
    final now = DateTime.now();

    final customer = _extractValue(content, 'customer') ?? 'AI Suggested Customer';
    final title = _extractValue(content, 'title') ?? 'AI suggested invoice';
    final amount = _extractAmount(content);

    return SalesInvoice(
      id: id,
      customerId: 'CUST-AI',
      customerName: customer,
      reference: id,
      title: title,
      notes: content,
      invoiceDate: now,
      dueDate: now.add(const Duration(days: 30)),
      status: const SalesInvoiceStatus(
        id: 'draft',
        label: 'Draft',
        color: 'grey',
      ),
      lines: const [
        SalesInvoiceLine(
          id: 'SIL-AI-1',
          description: 'AI suggested line',
          quantity: 1,
          unitPrice: 0,
        ),
      ],
      subtotal: amount,
      tax: 0,
      total: amount,
    );
  }

  String? _extractValue(String content, String key) {
    final match = RegExp(
      r'^\s*' + key + r'\s*[:\-]\s*(.+)$',
      caseSensitive: false,
      multiLine: true,
    ).firstMatch(content);
    return match?.group(1)?.trim();
  }

  double _extractAmount(String content) {
    final match = RegExp(r'(\d[\d,]*\.?\d*)').firstMatch(content);
    if (match == null) return 0;
    final parsed = double.tryParse(match.group(1)!.replaceAll(',', ''));
    if (parsed == null) return 0;
    return math.max(0, parsed);
  }
}
