import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/notifications/data/notification_repository_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/email_repository.dart';
import 'console_email_provider.dart';
import 'email_provider.dart';
import 'email_service.dart';
import 'email_template_service.dart';
import 'http_email_provider.dart';

part 'email_providers.g.dart';

@Riverpod(keepAlive: true)
EmailProvider emailProvider(Ref ref) {
  if (kReleaseMode) {
    return HttpEmailProvider.fromEnv();
  }
  return const ConsoleEmailProvider();
}

@Riverpod(keepAlive: true)
EmailRepository emailRepository(Ref ref) {
  return MockEmailRepository(provider: ref.watch(emailProviderProvider));
}

@Riverpod(keepAlive: true)
EmailTemplateService emailTemplateService(Ref ref) =>
    const EmailTemplateService();

@Riverpod(keepAlive: true)
EmailService emailService(Ref ref) {
  return EmailService(
    emailRepository: ref.watch(emailRepositoryProvider),
    auditRepository: ref.watch(auditTrailRepositoryProvider),
    notificationRepository: ref.watch(notificationRepositoryProvider),
    performedBy: 'email-service',
  );
}
