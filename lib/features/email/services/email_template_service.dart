import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';

import '../domain/email_address.dart';
import '../domain/email_attachment.dart';
import '../domain/email_message.dart';

/// Renders localized email templates for business documents.
///
/// Each method fills placeholders from domain models into template strings.
/// The templates themselves are injected (e.g. from ARB-localized strings)
/// so the service stays provider-agnostic.
class EmailTemplateService {
  const EmailTemplateService();

  /// Composes an [EmailMessage] for sending a [SalesInvoice] to a [Customer].
  ///
  /// [subjectTemplate] and [bodyTemplate] use `{placeholder}` syntax.
  /// Supported placeholders:
  ///   {customerName}, {reference}, {total}, {dueDate}, {invoiceDate}, {title}
  EmailMessage composeInvoiceEmail({
    required String id,
    required EmailAddress to,
    required SalesInvoice invoice,
    required String subjectTemplate,
    required String bodyTemplate,
    EmailAddress? fromAddress,
    List<EmailAttachment>? attachments,
  }) {
    final subject = _fillInvoiceTemplate(subjectTemplate, invoice);
    final body = _fillInvoiceTemplate(bodyTemplate, invoice);

    return EmailMessage(
      id: id,
      to: to,
      fromAddress: fromAddress,
      subject: subject,
      bodyText: body,
      attachments: attachments ?? [],
      relatedEntityType: 'salesInvoice',
      relatedEntityId: invoice.id,
    );
  }

  String _fillInvoiceTemplate(String template, SalesInvoice invoice) {
    return template
        .replaceAll('{customerName}', invoice.customerName)
        .replaceAll('{reference}', invoice.reference)
        .replaceAll('{total}', invoice.total.toStringAsFixed(2))
        .replaceAll('{dueDate}', _formatDate(invoice.dueDate))
        .replaceAll('{invoiceDate}', _formatDate(invoice.invoiceDate))
        .replaceAll('{title}', invoice.title);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
