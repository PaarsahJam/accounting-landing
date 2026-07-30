import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../../../core/sync/cloud/cloud_sync_providers.dart';
import '../../../core/sync/cloud/sync_orchestrator.dart';

class SyncStatusPage extends ConsumerWidget {
  const SyncStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orchestrator = ref.watch(syncOrchestratorProvider);
    final lifecycle = orchestrator.lifecycle;

    return ResponsivePageScaffold(
      title: 'Sync Status',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SyncStatusCard(lifecycle: lifecycle),
          const SizedBox(height: 16),
          _SyncActionsCard(ref: ref),
        ],
      ),
    );
  }
}

class _SyncStatusCard extends StatelessWidget {
  const _SyncStatusCard({required this.lifecycle});

  final SyncLifecycle lifecycle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = lifecycle.status;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sync Status', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            _StatusRow('State', lifecycle.state.name),
            if (status != null) ...[
              _StatusRow('Pending operations', '${status.pendingCount}'),
              _StatusRow('In flight', '${status.inFlightCount}'),
              _StatusRow('Failed', '${status.failedCount}'),
              if (status.lastSyncedAt != null)
                _StatusRow('Last synced',
                    status.lastSyncedAt!.toLocal().toString().split('.').first),
            ],
            _StatusRow('Push succeeded', '${lifecycle.pushSucceeded}'),
            _StatusRow('Push conflicts', '${lifecycle.pushConflicts}'),
            _StatusRow('Push failed', '${lifecycle.pushFailed}'),
            if (lifecycle.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Error: ${lifecycle.errorMessage}',
                  style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _SyncActionsCard extends ConsumerWidget {
  const _SyncActionsCard({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => _syncNow(context, ref),
              icon: const Icon(Icons.sync),
              label: const Text('Sync Now'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _syncNow(BuildContext context, WidgetRef ref) async {
    final orchestrator = ref.read(syncOrchestratorProvider);
    final result = await orchestrator.push();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.hasError
                ? 'Sync failed: ${result.errorMessage}'
                : 'Sync completed (${result.pushSucceeded} succeeded)',
          ),
        ),
      );
    }
  }
}
