import '../../../core/ai/ai_action.dart';

/// The kind of accounting draft the copilot can generate.
enum CopilotDraftKind {
  /// A suggestion to create a new sales invoice (financial mutation).
  invoiceSuggestion,

  /// A read-only financial summary of the current business state.
  financialSummary,

  /// A read-only recommendation for the next best action to take.
  nextBestAction;

  /// The underlying AI action type used to generate this draft.
  AiActionType get aiActionType => switch (this) {
        CopilotDraftKind.invoiceSuggestion => AiActionType.draftCreate,
        CopilotDraftKind.financialSummary => AiActionType.summarize,
        CopilotDraftKind.nextBestAction => AiActionType.suggestAction,
      };

  /// Whether this draft represents a financial mutation that must be
  /// explicitly confirmed before it can be saved.
  bool get requiresConfirmation => isFinancialMutation(aiActionType);
}

/// Audit-safe lifecycle states of a copilot draft.
///
/// A draft is generated, then reviewed and possibly edited, and only ever
/// persisted through an explicit confirmation step. The copilot never
/// auto-commits: the [save] path is only reachable from [confirming].
enum CopilotDraftStatus {
  /// No draft is in progress.
  idle,

  /// The AI is generating the draft.
  drafting,

  /// The draft is ready and awaiting user review.
  review,

  /// The user is editing the draft content.
  editing,

  /// The user has explicitly confirmed the draft; awaiting save.
  confirming,

  /// The confirmed draft is being persisted (audit-logged).
  saving,

  /// The draft was confirmed and saved successfully.
  saved,

  /// Drafting or saving failed (e.g. AI unavailable).
  error,
}

/// An immutable snapshot of the current copilot draft.
class ActionCopilotDraft {
  const ActionCopilotDraft({
    required this.kind,
    required this.status,
    this.content = '',
    this.errorMessage,
    this.auditNote,
  });

  /// The kind of draft in progress.
  final CopilotDraftKind kind;

  /// The current lifecycle status.
  final CopilotDraftStatus status;

  /// The draft content (AI-generated text, editable by the user).
  final String content;

  /// Human-readable failure detail when [status] is [CopilotDraftStatus.error].
  final String? errorMessage;

  /// Confirmation shown after a successful save.
  final String? auditNote;

  /// Whether this draft requires explicit user confirmation before saving.
  bool get requiresConfirmation => kind.requiresConfirmation;

  /// Whether the draft can currently transition into the confirmation gate.
  bool get isConfirmable =>
      status == CopilotDraftStatus.review ||
      status == CopilotDraftStatus.editing;

  ActionCopilotDraft copyWith({
    CopilotDraftStatus? status,
    String? content,
    String? errorMessage,
    String? auditNote,
  }) {
    return ActionCopilotDraft(
      kind: kind,
      status: status ?? this.status,
      content: content ?? this.content,
      errorMessage: errorMessage ?? this.errorMessage,
      auditNote: auditNote ?? this.auditNote,
    );
  }
}
