import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/core/l10n/locale_setting_provider.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/customers/domain/customer.dart';
import 'package:accounting_app/features/email/services/email_providers.dart';
import 'package:accounting_app/features/email/domain/email_address.dart';
import 'package:accounting_app/features/email/domain/email_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_controller.g.dart';

@riverpod
class EmailController extends _$EmailController {
  @override
  FutureOr<List<EmailMessage>> build() async {
    final repo = ref.watch(emailRepositoryProvider);
    final result = await repo.fetchSentEmails();
    if (result.isSuccess) return result.data ?? [];
    throw result.error!;
  }

  /// Composes and sends an invoice email to the customer.
  ///
  /// Uses localized templates from [subjectTemplate] and [bodyTemplate].
  Future<AppResult<EmailMessage>> sendInvoice({
    required SalesInvoice invoice,
    required Customer customer,
    required String subjectTemplate,
    required String bodyTemplate,
  }) async {
    state = const AsyncValue.loading();

    try {
      final service = ref.read(emailServiceProvider);
      final templateService = ref.read(emailTemplateServiceProvider);

      final to = EmailAddress(
        address: customer.email,
        displayName: customer.name,
      );

      final message = templateService.composeInvoiceEmail(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        to: to,
        invoice: invoice,
        subjectTemplate: subjectTemplate,
        bodyTemplate: bodyTemplate,
        locale: ref.read(localeSettingProvider).languageCode,
      );

      final result = await service.sendWithTracking(message);

      if (result.isSuccess) {
        final current = state.whenOrNull(
              data: (data) => data,
            ) ??
            <EmailMessage>[];
        if (result.data != null) {
          state = AsyncValue.data([result.data!, ...current]);
        } else {
          state = AsyncValue.data(current);
        }
      }

      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return AppResult.failure(
        UnknownFailure(message: 'Failed to send invoice email: $e'),
      );
    }
  }
}
