/// Abstract interface for AI/LLM interactions.
///
/// Implementations wrap a specific AI provider (OpenAI, Claude, etc.)
/// so the rest of the app never depends on a concrete provider.
abstract class AiProvider {
  /// Sends a chat completion request and returns the response text.
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  });
}
