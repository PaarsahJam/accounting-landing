/// The kind of action the AI is suggesting or performing.
enum AiActionType {
  /// Generate a descriptive summary of a record without any mutation.
  summarize,

  /// Suggest a new record to be created (financial mutation).
  draftCreate,

  /// Suggest edits to an existing record (financial mutation).
  draftUpdate,

  /// Suggest a record to be deleted with reasoning (financial mutation).
  draftDelete,

  /// Suggest a non-mutating business action (e.g., send reminder, flag review).
  suggestAction,
}

/// Whether an [AiActionType] represents a financial mutation that
/// must require explicit user confirmation before execution.
bool isFinancialMutation(AiActionType actionType) {
  switch (actionType) {
    case AiActionType.draftCreate:
    case AiActionType.draftUpdate:
    case AiActionType.draftDelete:
      return true;
    case AiActionType.summarize:
    case AiActionType.suggestAction:
      return false;
  }
}
