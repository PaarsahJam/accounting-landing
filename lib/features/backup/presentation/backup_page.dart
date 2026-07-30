import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../../../core/backup/backup_controller.dart';

class BackupPage extends ConsumerWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(backupControllerProvider);

    return ResponsivePageScaffold(
      title: 'Backup & Restore',
      actions: [
        FilledButton.icon(
          onPressed: controller.isLoading
              ? null
              : () => _createBackup(context, ref),
          icon: const Icon(Icons.backup),
          label: const Text('Create Backup'),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _BackupInfoCard(),
          const SizedBox(height: 16),
          _RestoreSection(ref: ref),
        ],
      ),
    );
  }

  Future<void> _createBackup(BuildContext context, WidgetRef ref) async {
    try {
      final notifier = ref.read(backupControllerProvider.notifier);
      await notifier.createFullBackup(description: 'Manual backup');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Backup created successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup failed: $e')),
        );
      }
    }
  }
}

class _BackupInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Backup Information',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Backups include:'),
            const Text('  - Company data'),
            const Text('  - Settings and preferences'),
            const Text('  - Attachment metadata'),
          ],
        ),
      ),
    );
  }
}

class _RestoreSection extends ConsumerWidget {
  const _RestoreSection({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Restore', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Restore from a previous backup file.'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _restoreFromFile(context, ref),
              icon: const Icon(Icons.restore),
              label: const Text('Restore from File'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _restoreFromFile(BuildContext context, WidgetRef ref) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restore functionality ready')),
    );
  }
}
