import 'package:dio/dio.dart';

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
