import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../ai_provider.dart';

/// OpenAI / compatible API chat completion provider.
class OpenAiProvider implements AiProvider {
  OpenAiProvider({
    required String apiKey,
    String baseUrl = _defaultBaseUrl,
    String model = _defaultModel,
    Dio? dio,
  })  : _baseUrl = baseUrl,
        _model = model,
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 60),
              sendTimeout: const Duration(seconds: 30),
              headers: {
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
              },
            ));

  /// Creates an instance reading the API key from `--dart-define=OPENAI_API_KEY=...`.
  ///
  /// The base URL and model can be overridden with
  /// `--dart-define=OPENAI_BASE_URL=...` and `--dart-define=OPENAI_MODEL=...`.
  ///
  /// Falls back to [FakeAiProvider] if the key is empty in debug mode;
  /// throws in release mode so the build fails early.
  factory OpenAiProvider.fromEnv() {
    const apiKey = String.fromEnvironment('OPENAI_API_KEY');
    const baseUrl = String.fromEnvironment('OPENAI_BASE_URL');
    const model = String.fromEnvironment('OPENAI_MODEL');
    if (apiKey.isEmpty) {
      if (kReleaseMode) {
        throw ArgumentError(
          'OPENAI_API_KEY not set. Pass --dart-define=OPENAI_API_KEY=sk-...',
        );
      }
      return OpenAiProvider(apiKey: 'sk-debug-fallback');
    }
    return OpenAiProvider(
      apiKey: apiKey,
      baseUrl: baseUrl.isEmpty ? _defaultBaseUrl : baseUrl,
      model: model.isEmpty ? _defaultModel : model,
    );
  }

  static const String _defaultBaseUrl = 'https://api.openai.com/v1';
  static const String _defaultModel = 'gpt-4o-mini';

  final String _baseUrl;
  final String _model;
  final Dio _dio;

  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final response = await _dio.post(
      '$_baseUrl/chat/completions',
      data: {
        'model': _model,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': 0.3,
        'max_tokens': 2048,
      },
    );

    final choices = response.data['choices'] as List;
    if (choices.isEmpty) {
      throw Exception('AI provider returned no choices');
    }

    return (choices.first['message'] as Map)['content'] as String;
  }
}
