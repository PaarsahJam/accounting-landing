import 'package:accounting_app/core/errors/app_result.dart';

import '../domain/email_message.dart';
import '../domain/email_status.dart';
import '../services/email_provider.dart';

/// Repository for sending and tracking email messages.
abstract class EmailRepository {
  /// Sends [message] via the configured provider and records the outcome.
  Future<AppResult<EmailMessage>> send(EmailMessage message);

  /// Returns all sent email records, optionally filtered by entity.
  Future<AppResult<List<EmailMessage>>> fetchSentEmails({
    String? relatedEntityType,
    String? relatedEntityId,
  });
}

/// Mock implementation of [EmailRepository].
class MockEmailRepository implements EmailRepository {
  MockEmailRepository({EmailProvider? provider})
      : _provider = provider ?? const _FakeEmailProvider();

  final EmailProvider _provider;
  final List<EmailMessage> _sent = [];

  @override
  Future<AppResult<EmailMessage>> send(EmailMessage message) async {
    final result = await _provider.send(message);

    if (result.isSuccess && result.data != null) {
      _sent.insert(0, result.data!);
    } else {
      _sent.insert(0, message.copyWith(status: EmailStatus.failed));
    }

    return result;
  }

  @override
  Future<AppResult<List<EmailMessage>>> fetchSentEmails({
    String? relatedEntityType,
    String? relatedEntityId,
  }) async {
    Iterable<EmailMessage> result = List.from(_sent);
    if (relatedEntityType != null) {
      result = result.where((e) => e.relatedEntityType == relatedEntityType);
    }
    if (relatedEntityId != null) {
      result = result.where((e) => e.relatedEntityId == relatedEntityId);
    }
    return AppResult.success(result.toList());
  }
}

/// Simple in-memory provider that always succeeds.
class _FakeEmailProvider implements EmailProvider {
  const _FakeEmailProvider();

  @override
  Future<AppResult<EmailMessage>> send(EmailMessage message) async {
    return AppResult.success(
      message.copyWith(
        status: EmailStatus.sent,
        sentAt: DateTime.now(),
      ),
    );
  }
}
