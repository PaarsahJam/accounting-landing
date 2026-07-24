import '../ai_provider.dart';

/// In-memory fake AI provider for tests and offline preview.
class FakeAiProvider implements AiProvider {
  FakeAiProvider({this.response});

  /// The response to return from [complete].
  /// If null, returns a default summary based on the user prompt length.
  String? response;

  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    return response ?? _defaultResponse(userPrompt);
  }

  String _defaultResponse(String userPrompt) {
    if (userPrompt.contains('summarize')) {
      return 'This is a summary of the record. '
          'The entity has several key fields that describe its current state.';
    }
    if (userPrompt.contains('suggest')) {
      return 'Suggested action: The payment is overdue; consider sending a reminder.';
    }
    return 'AI assistant processed your request.';
  }
}
