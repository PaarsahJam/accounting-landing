import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../domain/lead_opportunity.dart';
import '../domain/pipeline_controller.dart';

class PipelinePage extends ConsumerWidget {
  const PipelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final pipelineAsync = ref.watch(pipelineControllerProvider());

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pipeline)),
      body: pipelineAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) => AppErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(pipelineControllerProvider()),
        ),
        data: (opportunities) =>
            _PipelineView(opportunities: opportunities),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.newOpportunity),
        content: const Text('Create opportunity form (TBD)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
}

class _PipelineView extends ConsumerWidget {
  final List<LeadOpportunity> opportunities;

  const _PipelineView({required this.opportunities});

  @override
  Widget build(BuildContext context, ref) {
    final l10n = AppLocalizations.of(context)!;
    if (opportunities.isEmpty) {
      return Center(child: Text(l10n.noOpportunities));
    }

    final grouped = <PipelineStage, List<LeadOpportunity>>{};
    for (final stage in PipelineStage.values) {
      final items =
          opportunities.where((o) => o.stage == stage).toList();
      if (items.isNotEmpty) {
        grouped[stage] = items;
      }
    }

    final currencyFormat = NumberFormat('#,###', 'fa');
    final dateFormat = DateFormat('yyyy-MM-dd');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: grouped.entries.map((entry) {
        final stage = entry.key;
        final items = entry.value;
        final stageValue =
            items.fold<double>(0, (sum, o) => sum + o.estimatedValue);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  _stageColorDot(stage),
                  const SizedBox(width: 8),
                  Text(
                    stage.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${currencyFormat.format(stageValue)} IRR',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            ...items.map(
              (opp) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(opp.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (opp.description.isNotEmpty)
                        Text(
                          opp.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${currencyFormat.format(opp.estimatedValue)} IRR',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${(opp.probability * 100).toInt()}%',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            dateFormat.format(opp.expectedCloseDate),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'won') {
                        await ref
                            .read(pipelineControllerProvider().notifier)
                            .updateOpportunity(opp.copyWith(
                              stage: PipelineStage.won,
                              probability: 1.0,
                              wonAt: DateTime.now(),
                            ));
                      } else if (value == 'lost') {
                        await ref
                            .read(pipelineControllerProvider().notifier)
                            .updateOpportunity(opp.copyWith(
                              stage: PipelineStage.lost,
                              probability: 0.0,
                            ));
                      } else if (value == 'delete') {
                        await ref
                            .read(pipelineControllerProvider().notifier)
                            .deleteOpportunity(opp.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'won',
                        child: Text('Mark as Won'),
                      ),
                      const PopupMenuItem(
                        value: 'lost',
                        child: Text('Mark as Lost'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _stageColorDot(PipelineStage stage) {
    Color color;
    switch (stage) {
      case PipelineStage.lead:
        color = Colors.grey;
      case PipelineStage.qualified:
        color = Colors.blue;
      case PipelineStage.proposal:
        color = Colors.orange;
      case PipelineStage.negotiation:
        color = Colors.deepOrange;
      case PipelineStage.won:
        color = Colors.green;
      case PipelineStage.lost:
        color = Colors.red;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
