import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/notifications/domain/app_notification.dart';
import 'package:accounting_app/features/notifications/domain/notification_channel.dart';
import 'package:accounting_app/features/notifications/domain/notification_severity.dart';
import 'package:accounting_app/features/notifications/domain/notification_type.dart';
import 'package:accounting_app/features/notifications/data/notification_repository.dart';

import '../data/email_repository.dart';
import '../domain/email_message.dart';
import '../domain/email_status.dart';

/// Orchestrates email sending with audit logging and notification dispatch.
///
/// This is the public API for sending business-document emails. It:
/// 1. Delegates the actual send to [EmailRepository]
/// 2. Logs the outcome to the audit trail
/// 3. Creates an in-app notification on success/failure
class EmailService {
  EmailService({
    required EmailRepository emailRepository,
    required AuditTrailRepository auditRepository,
    required NotificationRepository notificationRepository,
    required String performedBy,
  })  : _emailRepo = emailRepository,
        _auditRepo = auditRepository,
        _notificationRepo = notificationRepository,
        _performedBy = performedBy;

  final EmailRepository _emailRepo;
  final AuditTrailRepository _auditRepo;
  final NotificationRepository _notificationRepo;
  final String _performedBy;

  /// Sends [message] and records audit + notification.
  Future<AppResult<EmailMessage>> sendWithTracking(EmailMessage message) async {
    final result = await _emailRepo.send(message);

    if (result.isSuccess && result.data != null) {
      final sent = result.data!;
      await _logAudit(sent, errorMessage: null);
      await _notify(sent, failed: false);
    } else {
      final failed = message.copyWith(
        status: EmailStatus.failed,
        errorMessage: result.error?.message,
      );
      await _logAudit(failed, errorMessage: result.error?.message);
      await _notify(failed, failed: true);
    }

    return result;
  }

  Future<void> _logAudit(EmailMessage message, {String? errorMessage}) async {
    await _auditRepo.addEntry(
      AuditEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        entityType: AuditEntityType.email,
        entityId: message.relatedEntityId ?? message.id,
        entityLabel: 'Email: ${message.subject}',
        action: errorMessage != null
            ? AuditAction.emailFailed
            : AuditAction.emailSent,
        performedAt: DateTime.now(),
        performedBy: _performedBy,
        note: errorMessage ?? 'Sent to ${message.to.address}',
      ),
    );
  }

  Future<void> _notify(EmailMessage message, {required bool failed}) async {
    final channel = NotificationChannel.inApp;

    final notification = AppNotification(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: failed ? NotificationType.system : NotificationType.invoice,
      severity:
          failed ? NotificationSeverity.error : NotificationSeverity.success,
      title: failed ? 'Email failed' : 'Email sent',
      body: failed
          ? 'Failed to send "${message.subject}" to ${message.to.address}'
          : '"${message.subject}" sent to ${message.to.address}',
      channels: [channel],
      relatedEntityType: message.relatedEntityType ?? 'email',
      relatedEntityId: message.relatedEntityId ?? message.id,
      isRead: false,
      createdAt: DateTime.now(),
    );

    await _notificationRepo.addNotification(notification);
  }
}
