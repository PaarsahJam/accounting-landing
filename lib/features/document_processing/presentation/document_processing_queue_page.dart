import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/document_processing_controller.dart';
import '../domain/document_processing_job.dart';

class DocumentProcessingQueuePage extends ConsumerWidget {
  const DocumentProcessingQueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final queueAsync = ref.watch(documentProcessingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.docProcessingQueueTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () =>
                ref.read(documentProcessingControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: queueAsync.when(
        loading: () =>
            AppLoadingState(message: l10n.docProcessingQueueLoading),
        error: (e, _) => AppErrorState(
          message: '${l10n.docProcessingQueueLoadError} $e',
          onRetry: () =>
              ref.read(documentProcessingControllerProvider.notifier).refresh(),
        ),
        data: (jobs) {
          if (jobs.isEmpty) {
            return AppEmptyState(
              icon: Icons.task_alt,
              title: l10n.docProcessingQueueEmptyTitle,
              message: l10n.docProcessingQueueEmptyMessage,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) =>
                _JobCard(job: jobs[index]),
          );
        },
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});

  final DocumentProcessingJob job;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.description_outlined,
          color: cs.primary,
        ),
        title: Text(
          job.attachmentId,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job.classification != null)
              Text(
                job.classification!.documentType.label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Text(
              '${l10n.docProcessingJobId}: ${job.id}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
        trailing: _StepChip(step: job.step),
        onTap: () => context.push('/document-processing/${job.id}', extra: job),
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({required this.step});

  final ProcessingStep step;

  @override
  Widget build(BuildContext context) {
    final color = _colorForStep(step);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        step.label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Color _colorForStep(ProcessingStep step) {
    switch (step) {
      case ProcessingStep.awaitingReview:
        return Colors.orange;
      case ProcessingStep.reviewApproved:
      case ProcessingStep.completed:
        return Colors.green;
      case ProcessingStep.reviewRejected:
      case ProcessingStep.failed:
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
