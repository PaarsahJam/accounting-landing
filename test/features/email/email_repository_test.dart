import 'package:accounting_app/features/email/data/email_repository.dart';
import 'package:accounting_app/features/email/domain/email_address.dart';
import 'package:accounting_app/features/email/domain/email_message.dart';
import 'package:accounting_app/features/email/domain/email_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockEmailRepository repository;

  setUp(() {
    repository = MockEmailRepository();
  });

  group('send', () {
    test('sends message and returns success', () async {
      final msg = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'alice@acme.com'),
        subject: 'Invoice INV-001',
        bodyText: 'Please find attached invoice.',
      );

      final result = await repository.send(msg);

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.status, equals(EmailStatus.sent));
      expect(result.data!.sentAt, isNotNull);
    });

    test('stores sent message for retrieval', () async {
      final msg = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'alice@acme.com'),
        subject: 'Invoice INV-001',
        bodyText: 'Body',
      );

      await repository.send(msg);
      final sent = await repository.fetchSentEmails();

      expect(sent.isSuccess, isTrue);
      expect(sent.data, hasLength(1));
      expect(sent.data!.first.id, equals('email-1'));
    });

    test('stores multiple messages in reverse chronological order', () async {
      final msg1 = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'a@b.com'),
        subject: 'First',
        bodyText: 'Body',
      );
      final msg2 = EmailMessage(
        id: 'email-2',
        to: EmailAddress(address: 'b@c.com'),
        subject: 'Second',
        bodyText: 'Body',
      );

      await repository.send(msg1);
      await repository.send(msg2);
      final sent = await repository.fetchSentEmails();

      expect(sent.data, hasLength(2));
      expect(sent.data!.first.id, equals('email-2'));
    });
  });

  group('fetchSentEmails', () {
    test('returns empty list when no messages sent', () async {
      final result = await repository.fetchSentEmails();
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('filters by relatedEntityType', () async {
      final invoiceEmail = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'a@b.com'),
        subject: 'Invoice',
        bodyText: 'Body',
        relatedEntityType: 'salesInvoice',
        relatedEntityId: 'SI-001',
      );
      final otherEmail = EmailMessage(
        id: 'email-2',
        to: EmailAddress(address: 'c@d.com'),
        subject: 'Report',
        bodyText: 'Body',
        relatedEntityType: 'report',
        relatedEntityId: 'RPT-001',
      );

      await repository.send(invoiceEmail);
      await repository.send(otherEmail);

      final invoices = await repository.fetchSentEmails(
        relatedEntityType: 'salesInvoice',
      );

      expect(invoices.data, hasLength(1));
      expect(invoices.data!.first.id, equals('email-1'));
    });

    test('filters by relatedEntityId', () async {
      final email = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'a@b.com'),
        subject: 'Invoice',
        bodyText: 'Body',
        relatedEntityType: 'salesInvoice',
        relatedEntityId: 'SI-001',
      );

      await repository.send(email);

      final result = await repository.fetchSentEmails(
        relatedEntityId: 'SI-001',
      );

      expect(result.data, hasLength(1));
      expect(result.data!.first.id, equals('email-1'));
    });
  });
}
