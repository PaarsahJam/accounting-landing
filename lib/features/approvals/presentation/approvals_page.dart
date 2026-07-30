import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../../document_numbering/domain/approval_workflow_controller.dart';
import '../../document_numbering/document_record.dart';
import '../../document_numbering/document_status.dart';

class ApprovalsPage extends ConsumerWidget {
  const ApprovalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDocs = ref.watch(approvalWorkflowControllerProvider);

    return ResponsivePageScaffold(
      title: 'Approvals',
      child: asyncDocs.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (docs) {
          final pending =
              docs.where((d) => d.status == DocumentStatus.pendingApproval).toList();
          if (pending.isEmpty) {
            return const AppEmptyState(
              title: 'No pending approvals',
              message: 'Documents pending approval will appear here.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(approvalWorkflowControllerProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pending.length,
              itemBuilder: (context, index) => _ApprovalCard(
                record: pending[index],
                ref: ref,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ApprovalCard extends ConsumerWidget {
  const _ApprovalCard({required this.record, required this.ref});

  final DocumentRecord record;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.documentNumber,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Text('Type: ${record.documentType}'),
            Text('Created: ${record.createdAt.toLocal()}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => _transition(context, DocumentStatus.draft),
                  child: const Text('Reject'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => _transition(context, DocumentStatus.approved),
                  child: const Text('Approve'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _transition(BuildContext context, DocumentStatus target) async {
    try {
      await ref
          .read(approvalWorkflowControllerProvider.notifier)
          .transitionDocument(record.id, target);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transitioned to ${target.name}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }
}
