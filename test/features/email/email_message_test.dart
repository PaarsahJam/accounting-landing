import 'package:accounting_app/features/email/domain/email_address.dart';
import 'package:accounting_app/features/email/domain/email_attachment.dart';
import 'package:accounting_app/features/email/domain/email_message.dart';
import 'package:accounting_app/features/email/domain/email_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailAddress', () {
    test('constructs with address only', () {
      final addr = EmailAddress(address: 'test@example.com');
      expect(addr.address, equals('test@example.com'));
      expect(addr.displayName, isNull);
    });

    test('constructs with display name', () {
      final addr = EmailAddress(
        address: 'alice@acme.com',
        displayName: 'Alice Smith',
      );
      expect(addr.address, equals('alice@acme.com'));
      expect(addr.displayName, equals('Alice Smith'));
    });

    test('formatted includes display name when present', () {
      final addr = EmailAddress(
        address: 'alice@acme.com',
        displayName: 'Alice Smith',
      );
      expect(addr.formatted, equals('Alice Smith <alice@acme.com>'));
    });

    test('formatted is just address when no display name', () {
      final addr = EmailAddress(address: 'alice@acme.com');
      expect(addr.formatted, equals('alice@acme.com'));
    });

    test('equality based on address and displayName', () {
      final a = EmailAddress(address: 'a@b.com', displayName: 'A');
      final b = EmailAddress(address: 'a@b.com', displayName: 'A');
      final c = EmailAddress(address: 'c@d.com');
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });
  });

  group('EmailAttachment', () {
    test('constructs with filename, mime type, and content', () {
      final attachment = EmailAttachment(
        filename: 'invoice.pdf',
        mimeType: 'application/pdf',
        content: [0x25, 0x50, 0x44, 0x46],
      );
      expect(attachment.filename, equals('invoice.pdf'));
      expect(attachment.mimeType, equals('application/pdf'));
      expect(attachment.content, hasLength(4));
    });

    test('equality based on filename', () {
      final a = EmailAttachment(
        filename: 'doc.pdf',
        mimeType: 'application/pdf',
        content: [1, 2, 3],
      );
      final b = EmailAttachment(
        filename: 'doc.pdf',
        mimeType: 'image/png',
        content: [4, 5, 6],
      );
      expect(a, equals(b));
    });
  });

  group('EmailMessage', () {
    test('constructs with required fields', () {
      final to = EmailAddress(address: 'alice@acme.com');
      final msg = EmailMessage(
        id: 'email-1',
        to: to,
        subject: 'Invoice INV-001',
        bodyText: 'Please find attached your invoice.',
      );

      expect(msg.id, equals('email-1'));
      expect(msg.to.address, equals('alice@acme.com'));
      expect(msg.subject, equals('Invoice INV-001'));
      expect(msg.bodyText, equals('Please find attached your invoice.'));
      expect(msg.status, equals(EmailStatus.queued));
      expect(msg.attachments, isEmpty);
    });

    test('copyWith updates specified fields', () {
      final msg = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'a@b.com'),
        subject: 'Original subject',
        bodyText: 'Original body',
      );

      final updated = msg.copyWith(
        subject: 'Updated subject',
        status: EmailStatus.sent,
      );

      expect(updated.id, equals('email-1'));
      expect(updated.subject, equals('Updated subject'));
      expect(updated.bodyText, equals('Original body'));
      expect(updated.status, equals(EmailStatus.sent));
    });

    test('equality based on id', () {
      final a = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'a@b.com'),
        subject: 'Subject A',
        bodyText: 'Body A',
      );
      final b = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'x@y.com'),
        subject: 'Subject B',
        bodyText: 'Body B',
      );
      expect(a, equals(b));
    });

    test('toString includes id, to, subject, and status', () {
      final msg = EmailMessage(
        id: 'email-1',
        to: EmailAddress(address: 'alice@acme.com'),
        subject: 'Invoice INV-001',
        bodyText: 'Body',
      );
      final str = msg.toString();
      expect(str, contains('email-1'));
      expect(str, contains('alice@acme.com'));
      expect(str, contains('Invoice INV-001'));
      expect(str, contains('queued'));
    });
  });
}
