import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../ai_action.dart';
import '../ai_action_gateway.dart';
import '../ai_provider.dart';

/// The result of drafting an AI suggestion.
class AiDraftResult {
  const AiDraftResult({
    required this.suggestion,
    this.confirmationRequirement,
  });

  /// The AI-generated suggestion text.
  final String suggestion;

  /// If non-null, the user must confirm before this action executes.
  final AiConfirmationRequirement? confirmationRequirement;
}

/// Use case: ask the AI to draft a suggested action (e.g., create/edit a record).
///
/// This returns a suggestion that the user must review and explicitly confirm
/// before any mutation occurs. Read-only suggestions (summarize, suggestAction)
/// skip the confirmation gate.
class AiDraftAction {
  AiDraftAction({
    required AiProvider aiProvider,
    required AiActionGateway gateway,
  })  : _ai = aiProvider,
        _gateway = gateway;

  final AiProvider _ai;
  final AiActionGateway _gateway;

  /// Drafts a suggestion for the given [actionType] based on [entityContext].
  ///
  /// For financial mutations, the result includes a
  /// [AiConfirmationRequirement] that the UI must present to the user.
  Future<AiDraftResult> draft({
    required AiActionType actionType,
    required String entityContext,
    String? userInstruction,
  }) async {
    final requirement = _gateway.checkAction(actionType);

    final response = await _ai.complete(
      systemPrompt: _systemPrompt(actionType),
      userPrompt: _buildUserPrompt(actionType, entityContext, userInstruction),
    );

    return AiDraftResult(
      suggestion: response.trim(),
      confirmationRequirement:
          requirement.requiresConfirmation ? requirement : null,
    );
  }

  /// Creates a [ConfirmedAction] for the given draft, which the UI can
  /// pass to [AiActionGateway.executeConfirmed] after user confirmation.
  ConfirmedAction<dynamic> createConfirmedAction({
    required AiActionType actionType,
    required String suggestionText,
    required Future<AppResult<dynamic>> Function() action,
    AuditEntityType? entityType,
    String? entityId,
    String? entityLabel,
  }) {
    return ConfirmedAction<dynamic>(
      actionType: actionType,
      description: suggestionText.length > 120
          ? '${suggestionText.substring(0, 117)}...'
          : suggestionText,
      action: action,
      entityType: entityType,
      entityId: entityId,
      entityLabel: entityLabel,
    );
  }

  String _systemPrompt(AiActionType actionType) {
    final actionDesc = _describeAction(actionType);
    return 'You are an AI assistant integrated into an accounting application. '
        'Your task is to $actionDesc. '
        'Base your suggestion on the provided record context and any user instructions. '
        'Be specific and action-oriented. Include relevant data points. '
        'If the user instruction is ambiguous, make a reasonable assumption and note it.';
  }

  String _buildUserPrompt(
    AiActionType actionType,
    String entityContext,
    String? userInstruction,
  ) {
    final actionDesc = _describeAction(actionType);
    final instruction = (userInstruction != null && userInstruction.isNotEmpty)
        ? '\n\nUser instruction: $userInstruction'
        : '';

    return 'Please $actionDesc based on this record:\n\n$entityContext$instruction';
  }

  String _describeAction(AiActionType type) {
    switch (type) {
      case AiActionType.draftCreate:
        return 'draft a suggestion to create a new record';
      case AiActionType.draftUpdate:
        return 'draft suggested edits to an existing record';
      case AiActionType.draftDelete:
        return 'draft a rationale for deleting a record';
      case AiActionType.summarize:
        return 'provide a concise summary of the record';
      case AiActionType.suggestAction:
        return 'suggest a business action (e.g., send reminder, flag for review)';
    }
  }
}
