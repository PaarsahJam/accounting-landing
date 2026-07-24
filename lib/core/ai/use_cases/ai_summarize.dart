import '../ai_action.dart';
import '../ai_action_gateway.dart';
import '../ai_provider.dart';

/// Use case: ask the AI to summarize a domain record.
///
/// This is a read-only operation — it never mutates data and does not
/// require user confirmation.
class AiSummarize {
  AiSummarize({
    required AiProvider aiProvider,
    required AiActionGateway gateway,
  })  : _ai = aiProvider,
        _gateway = gateway;

  final AiProvider _ai;
  final AiActionGateway _gateway;

  /// Generates a summary of the given [entityContext].
  ///
  /// Returns the AI-generated summary text, or null if the action is
  /// not permitted by the safety gate.
  Future<String?> summarize({required String entityContext}) async {
    final requirement = _gateway.checkAction(AiActionType.summarize);
    if (requirement.requiresConfirmation) {
      return null;
    }

    final result = await _ai.complete(
      systemPrompt: _systemPrompt(),
      userPrompt: 'Please provide a concise summary of the following record:\n\n$entityContext',
    );

    return result.trim();
  }

  String _systemPrompt() {
    return 'You are an AI assistant integrated into an accounting application. '
        'Your task is to summarize business records concisely and accurately. '
        'Focus on key financial data, dates, and statuses. '
        'Use professional language. Keep summaries under 200 words.';
  }
}
