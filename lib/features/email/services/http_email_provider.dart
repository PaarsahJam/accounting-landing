import 'package:accounting_app/core/errors/app_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../domain/email_message.dart';
import '../domain/email_status.dart';
import 'email_provider.dart';

class HttpEmailProvider implements EmailProvider {
  HttpEmailProvider({
    required String apiKey,
    String baseUrl = _defaultBaseUrl,
    String fromEmail = _defaultFromEmail,
    String fromName = _defaultFromName,
    Dio? dio,
  })  : _baseUrl = baseUrl,
        _fromEmail = fromEmail,
        _fromName = fromName,
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 60),
              headers: {
                'Authorization': 'Bearer $apiKey',
                'Content-Type': 'application/json',
              },
            ));

  static const String _defaultBaseUrl =
      'https://api.sendgrid.com/v3/mail/send';
  static const String _defaultFromEmail = 'noreply@accounting.app';
  static const String _defaultFromName = 'Accounting App';
  final String _baseUrl;
  final String _fromEmail;
  final String _fromName;
  final Dio _dio;

  factory HttpEmailProvider.fromEnv() {
    const apiKey = String.fromEnvironment('EMAIL_API_KEY');
    const baseUrl = String.fromEnvironment('EMAIL_API_URL',
        defaultValue: _defaultBaseUrl);
    if (apiKey.isEmpty && kReleaseMode) {
      throw ArgumentError(
        'EMAIL_API_KEY not set. Pass --dart-define=EMAIL_API_KEY=...',
      );
    }
    return HttpEmailProvider(
      apiKey: apiKey.isNotEmpty ? apiKey : 'sk-debug-fallback',
      baseUrl: baseUrl,
    );
  }

  @override
  Future<AppResult<EmailMessage>> send(EmailMessage message) async {
    try {
      await _dio.post(
        _baseUrl,
        data: _buildPayload(message),
      );
      return AppResult.success(
        message.copyWith(status: EmailStatus.sent, sentAt: DateTime.now()),
      );
    } catch (e) {
      return AppResult.success(
        message.copyWith(
          status: EmailStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Map<String, dynamic> _buildPayload(EmailMessage message) => {
        'personalizations': [
          {'to': [{'email': message.to.address, 'name': message.to.displayName}]}
        ],
        'from': {'email': _fromEmail, 'name': _fromName},
        'subject': message.subject,
        'content': [
          {'type': 'text/plain', 'value': message.bodyText},
          if (message.bodyHtml != null)
            {'type': 'text/html', 'value': message.bodyHtml},
        ],
      };
}
