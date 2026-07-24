import 'package:accounting_app/core/errors/app_result.dart';

import '../domain/email_message.dart';
import '../domain/email_status.dart';
import 'email_provider.dart';

/// Development-only email provider that prints messages to the console.
class ConsoleEmailProvider implements EmailProvider {
  const ConsoleEmailProvider();

  @override
  Future<AppResult<EmailMessage>> send(EmailMessage message) async {
    final buffer = StringBuffer()
      ..writeln('--- EMAIL ---')
      ..writeln('To: ${message.to.formatted}')
      ..writeln('Subject: ${message.subject}')
      ..writeln('Body:')
      ..writeln(message.bodyText);

    if (message.attachments.isNotEmpty) {
      buffer.writeln('Attachments:');
      for (final a in message.attachments) {
        buffer.writeln(
          '  - ${a.filename} (${a.mimeType}, ${a.content.length} bytes)',
        );
      }
    }

    buffer.writeln('--- END EMAIL ---');

    return AppResult.success(
      message.copyWith(
        status: EmailStatus.sent,
        sentAt: DateTime.now(),
      ),
    );
  }
}
