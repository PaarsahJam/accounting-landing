import 'email_address.dart';
import 'email_attachment.dart';
import 'email_status.dart';

/// An immutable representation of an outbound email message.
class EmailMessage {
  const EmailMessage({
    required this.id,
    required this.to,
    this.fromAddress,
    required this.subject,
    required this.bodyText,
    this.bodyHtml,
    this.attachments = const [],
    this.relatedEntityType,
    this.relatedEntityId,
    this.status = EmailStatus.queued,
    this.sentAt,
    this.errorMessage,
  });

  final String id;
  final EmailAddress to;
  final EmailAddress? fromAddress;
  final String subject;
  final String bodyText;
  final String? bodyHtml;
  final List<EmailAttachment> attachments;
  final String? relatedEntityType;
  final String? relatedEntityId;
  final EmailStatus status;
  final DateTime? sentAt;
  final String? errorMessage;

  EmailMessage copyWith({
    String? id,
    EmailAddress? to,
    EmailAddress? fromAddress,
    String? subject,
    String? bodyText,
    String? bodyHtml,
    List<EmailAttachment>? attachments,
    String? relatedEntityType,
    String? relatedEntityId,
    EmailStatus? status,
    DateTime? sentAt,
    String? errorMessage,
  }) {
    return EmailMessage(
      id: id ?? this.id,
      to: to ?? this.to,
      fromAddress: fromAddress ?? this.fromAddress,
      subject: subject ?? this.subject,
      bodyText: bodyText ?? this.bodyText,
      bodyHtml: bodyHtml ?? this.bodyHtml,
      attachments: attachments ?? this.attachments,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailMessage && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'EmailMessage(id: $id, to: ${to.address}, subject: $subject, status: ${status.name})';
}
