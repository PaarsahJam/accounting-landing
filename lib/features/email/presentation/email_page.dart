import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/email_controller.dart';
import '../domain/email_message.dart';
import '../domain/email_status.dart';

class EmailPage extends ConsumerWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEmails = ref.watch(emailControllerProvider);

    return ResponsivePageScaffold(
      title: 'Email History',
      child: asyncEmails.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (emails) {
          if (emails.isEmpty) {
            return const AppEmptyState(
              title: 'No emails sent',
              message: 'Sent emails will appear here.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(emailControllerProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: emails.length,
              itemBuilder: (context, index) => _EmailCard(email: emails[index]),
            ),
          );
        },
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({required this.email});

  final EmailMessage email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = email.status == EmailStatus.sent
        ? Colors.green
        : email.status == EmailStatus.failed
            ? Colors.red
            : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(email.subject,
                      style: theme.textTheme.titleSmall),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(email.status.name,
                      style: TextStyle(fontSize: 12, color: statusColor)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('To: ${email.to.formatted}',
                style: theme.textTheme.bodySmall),
            if (email.sentAt != null)
              Text('Sent: ${email.sentAt!.toLocal()}',
                  style: theme.textTheme.bodySmall),
            if (email.errorMessage != null)
              Text('Error: ${email.errorMessage}',
                  style: TextStyle(fontSize: 12, color: Colors.red.shade700)),
          ],
        ),
      ),
    );
  }
}
