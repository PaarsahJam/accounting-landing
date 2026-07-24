import '../../../../core/errors/app_result.dart';
import '../domain/email_message.dart';

/// Adapter interface for sending emails.
///
/// Implementations wrap a specific email provider (SMTP, SendGrid, SES, etc.)
/// so the rest of the app never depends on a concrete provider.
abstract class EmailProvider {
  /// Dispatches [message] for delivery.
  ///
  /// Returns the updated message (with status, sentAt, or errorMessage populated)
  /// inside an [AppResult].
  Future<AppResult<EmailMessage>> send(EmailMessage message);
}
