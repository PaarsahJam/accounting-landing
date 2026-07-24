import 'package:accounting_app/features/email/domain/email_address.dart';
import 'package:accounting_app/features/email/domain/email_attachment.dart';
import 'package:accounting_app/features/email/domain/email_status.dart';
import 'package:accounting_app/features/email/services/email_template_service.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice_line.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EmailTemplateService service;
  late SalesInvoice invoice;
  late EmailAddress customerAddress;

  setUp(() {
    service = const EmailTemplateService();

    invoice = SalesInvoice(
      id: 'SI-2026-000001',
      customerId: 'CUST-001',
      customerName: 'Acme Corp',
      reference: 'INV-2026-001',
      title: 'Consulting Services',
      notes: 'Monthly retainer',
      invoiceDate: DateTime(2026, 7, 1),
      dueDate: DateTime(2026, 7, 31),
      status: SalesInvoiceStatus(id: 'posted', label: 'Posted', color: 'green'),
      lines: [
        SalesInvoiceLine(
          id: 'line-1',
          description: 'Consulting',
          quantity: 10,
          unitPrice: 1000,
        ),
      ],
      subtotal: 10000,
      tax: 1000,
      total: 11000,
    );

    customerAddress = EmailAddress(
      address: 'acme@example.com',
      displayName: 'Acme Corp',
    );
  });

  group('composeInvoiceEmail', () {
    test('fills subject template placeholders', () {
      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        invoice: invoice,
        subjectTemplate: 'Invoice {reference} for {customerName}',
        bodyTemplate: 'Body',
      );

      expect(message.subject, equals('Invoice INV-2026-001 for Acme Corp'));
    });

    test('fills body template placeholders', () {
      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        invoice: invoice,
        subjectTemplate: 'Subject',
        bodyTemplate: 'Dear {customerName},\n\nInvoice {reference} total: {total} due by {dueDate}.',
      );

      expect(message.bodyText, contains('Dear Acme Corp'));
      expect(message.bodyText, contains('Invoice INV-2026-001'));
      expect(message.bodyText, contains('11000.00'));
      expect(message.bodyText, contains('2026-07-31'));
    });

    test('sets correct related entity metadata', () {
      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        invoice: invoice,
        subjectTemplate: 'Subject',
        bodyTemplate: 'Body',
      );

      expect(message.relatedEntityType, equals('salesInvoice'));
      expect(message.relatedEntityId, equals('SI-2026-000001'));
    });

    test('attaches provided files', () {
      final attachment = EmailAttachment(
        filename: 'invoice.pdf',
        mimeType: 'application/pdf',
        content: [0x25, 0x50, 0x44, 0x46],
      );

      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        invoice: invoice,
        subjectTemplate: 'Subject',
        bodyTemplate: 'Body',
        attachments: [attachment],
      );

      expect(message.attachments, hasLength(1));
      expect(message.attachments.first.filename, equals('invoice.pdf'));
    });

    test('handles from address when provided', () {
      final from = EmailAddress(
        address: 'billing@company.com',
        displayName: 'Billing Dept',
      );

      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        fromAddress: from,
        invoice: invoice,
        subjectTemplate: 'Subject',
        bodyTemplate: 'Body',
      );

      expect(message.fromAddress, isNotNull);
      expect(message.fromAddress!.address, equals('billing@company.com'));
    });

    test('status defaults to queued', () {
      final message = service.composeInvoiceEmail(
        id: 'email-1',
        to: customerAddress,
        invoice: invoice,
        subjectTemplate: 'Subject',
        bodyTemplate: 'Body',
      );

      expect(message.status, equals(EmailStatus.queued));
    });
  });
}


