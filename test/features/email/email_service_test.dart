import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/email/data/email_repository.dart';
import 'package:accounting_app/features/email/domain/email_address.dart';
import 'package:accounting_app/features/email/domain/email_message.dart';
import 'package:accounting_app/features/email/domain/email_status.dart';
import 'package:accounting_app/features/email/services/email_service.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/notifications/data/notification_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockEmailRepository emailRepo;
  late MockAuditTrailRepository auditRepo;
  late MockNotificationRepository notificationRepo;
  late EmailService service;

  setUp(() {
    emailRepo = MockEmailRepository();
    auditRepo = MockAuditTrailRepository();
    notificationRepo = MockNotificationRepository();
    service = EmailService(
      emailRepository: emailRepo,
      auditRepository: auditRepo,
      notificationRepository: notificationRepo,
      performedBy: 'test-service',
    );
  });

  EmailMessage testMessage({String? id, String? subject}) {
    return EmailMessage(
      id: id ?? 'test-email',
      to: EmailAddress(address: 'alice@acme.com'),
      subject: subject ?? 'Test Invoice',
      bodyText: 'Please find attached invoice.',
    );
  }

  group('sendWithTracking', () {
    test('returns success result from repository', () async {
      final msg = testMessage();
      final result = await service.sendWithTracking(msg);

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
    });

    test('creates audit entry on success', () async {
      final msg = testMessage(subject: 'Invoice INV-001');
      await service.sendWithTracking(msg);

      final entries = (await auditRepo.fetchEntries()).data ?? [];
      final emailEntries = entries.where(
        (e) => e.entityType == AuditEntityType.email,
      );

      expect(emailEntries, isNotEmpty);
      expect(emailEntries.first.action, equals(AuditAction.emailSent));
      expect(emailEntries.first.note, contains('alice@acme.com'));
    });

    test('creates audit entry on failure', () async {
      // Use a repository that simulates failure
      final failingRepo = _FailingEmailRepository();
      final localService = EmailService(
        emailRepository: failingRepo,
        auditRepository: auditRepo,
        notificationRepository: notificationRepo,
        performedBy: 'test-service',
      );

      final msg = testMessage();
      await localService.sendWithTracking(msg);

      final entries = (await auditRepo.fetchEntries()).data ?? [];
      final emailEntries = entries.where(
        (e) => e.entityType == AuditEntityType.email,
      );

      expect(emailEntries, isNotEmpty);
      expect(emailEntries.first.action, equals(AuditAction.emailFailed));
    });

    test('creates notification on success', () async {
      final msg = testMessage(subject: 'Invoice INV-001');
      await service.sendWithTracking(msg);

      final notifs = (await notificationRepo.fetchNotifications()).data ?? [];
      final emailNotifs = notifs.where(
        (n) => n.relatedEntityType == 'email',
      );

      expect(emailNotifs, isNotEmpty);
      expect(emailNotifs.first.title, contains('sent'));
    });

    test('creates notification on failure', () async {
      final failingRepo = _FailingEmailRepository();
      final localService = EmailService(
        emailRepository: failingRepo,
        auditRepository: auditRepo,
        notificationRepository: notificationRepo,
        performedBy: 'test-service',
      );

      final msg = testMessage(subject: 'Invoice INV-001');
      await localService.sendWithTracking(msg);

      final notifs = (await notificationRepo.fetchNotifications()).data ?? [];
      final emailNotifs = notifs.where(
        (n) => n.relatedEntityType == 'email',
      );

      expect(emailNotifs, isNotEmpty);
      expect(emailNotifs.first.title, contains('failed'));
    });

    test('updates message status to sent on success', () async {
      final msg = testMessage();
      final result = await service.sendWithTracking(msg);

      expect(result.data!.status, equals(EmailStatus.sent));
      expect(result.data!.sentAt, isNotNull);
    });
  });
}

/// Helper repository that simulates a sending failure.
class _FailingEmailRepository extends MockEmailRepository {
  @override
  Future<AppResult<EmailMessage>> send(EmailMessage message) async {
    return AppResult.failure(
      EmailFailure(message: 'SMTP connection refused'),
    );
  }
}


