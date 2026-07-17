// lib/features/import_export/presentation/import_export_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/import_export_controller.dart';
import '../domain/import_export_job.dart';

class ImportExportPage extends ConsumerStatefulWidget {
  const ImportExportPage({super.key});

  @override
  ConsumerState<ImportExportPage> createState() => _ImportExportPageState();
}

class _ImportExportPageState extends ConsumerState<ImportExportPage> {
  ExportEntityType _selected = ExportEntityType.customers;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final jobsAsync = ref.watch(importExportControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.importExportPageTitle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectorPanel(
            selected: _selected,
            busy: _busy,
            l10n: l10n,
            onChanged: (v) => setState(() => _selected = v),
            onExport: _handleExport,
            onImport: _handleImport,
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              l10n.importExportRecentJobs,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: jobsAsync.when(
              loading: () => const AppLoadingState(),
              error: (e, _) =>
                  AppErrorState(message: '${l10n.importExportLoadError} $e'),
              data: (jobs) {
                if (jobs.isEmpty) {
                  return AppEmptyState(
                    title: l10n.importExportEmptyTitle,
                    message: l10n.importExportEmptyMessage,
                  );
                }
                return ListView.separated(
                  itemCount: jobs.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (ctx, i) =>
                      _JobTile(job: jobs[i], l10n: l10n, ref: ref),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleExport() async {
    setState(() => _busy = true);
    final result = await ref
        .read(importExportControllerProvider.notifier)
        .exportCsv(_selected);
    if (!mounted) return;
    setState(() => _busy = false);
    if (result?.isSuccess == true && result?.data?.csvPreview != null) {
      _showCsvPreview(result!.data!);
    }
  }

  Future<void> _handleImport() async {
    setState(() => _busy = true);
    await ref
        .read(importExportControllerProvider.notifier)
        .importCsv(_selected);
    if (mounted) setState(() => _busy = false);
  }

  void _showCsvPreview(ImportExportJob job) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (_) => _CsvPreviewDialog(job: job, l10n: l10n),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Entity selector + action buttons
// ─────────────────────────────────────────────────────────────────────────────

class _SelectorPanel extends StatelessWidget {
  const _SelectorPanel({
    required this.selected,
    required this.busy,
    required this.l10n,
    required this.onChanged,
    required this.onExport,
    required this.onImport,
  });

  final ExportEntityType selected;
  final bool busy;
  final AppLocalizations l10n;
  final ValueChanged<ExportEntityType> onChanged;
  final VoidCallback onExport;
  final VoidCallback onImport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.importExportSelectEntity,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<ExportEntityType>(
            value: selected,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: ExportEntityType.values.map((e) {
              return DropdownMenuItem(value: e, child: Text(e.label));
            }).toList(),
            onChanged: busy
                ? null
                : (v) {
                    if (v != null) onChanged(v);
                  },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: busy ? null : onExport,
                  icon: busy
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_outlined, size: 18),
                  label: Text(l10n.importExportExportBtn),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: busy ? null : onImport,
                  icon: const Icon(Icons.upload_outlined, size: 18),
                  label: Text(l10n.importExportImportBtn),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Job tile
// ─────────────────────────────────────────────────────────────────────────────

class _JobTile extends StatelessWidget {
  const _JobTile({required this.job, required this.l10n, required this.ref});

  final ImportExportJob job;
  final AppLocalizations l10n;
  final WidgetRef ref;

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final isExport = job.direction == JobDirection.export;
    final isSuccess = job.status == JobStatus.success;

    return ListTile(
      leading: Icon(
        isExport ? Icons.download_outlined : Icons.upload_outlined,
        color: isSuccess
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.error,
        size: 22,
      ),
      title: Row(
        children: [
          Text(
            job.entityType.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          _DirectionBadge(isExport, l10n),
          const SizedBox(width: 4),
          _StatusBadge(isSuccess, l10n),
        ],
      ),
      subtitle: Text(
        '${_formatDate(job.performedAt)}  •  '
        '${job.rowCount} ${l10n.importExportRows}',
      ),
      trailing: isExport && job.csvPreview != null
          ? IconButton(
              icon: const Icon(Icons.visibility_outlined, size: 18),
              tooltip: l10n.importExportPreviewBtn,
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => _CsvPreviewDialog(job: job, l10n: l10n),
              ),
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CSV preview dialog
// ─────────────────────────────────────────────────────────────────────────────

class _CsvPreviewDialog extends StatelessWidget {
  const _CsvPreviewDialog({required this.job, required this.l10n});

  final ImportExportJob job;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${l10n.importExportPreviewTitle} — ${job.entityType.label}'),
      content: SizedBox(
        width: 560,
        height: 300,
        child: SingleChildScrollView(
          child: SelectableText(
            job.csvPreview ?? '',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.invoiceCancel),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small badge widgets
// ─────────────────────────────────────────────────────────────────────────────

class _DirectionBadge extends StatelessWidget {
  const _DirectionBadge(this.isExport, this.l10n);

  final bool isExport;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final label = isExport
        ? l10n.importExportDirectionExport
        : l10n.importExportDirectionImport;
    final color = isExport ? Colors.blue : Colors.purple;
    return _RawBadge(label: label, color: color);
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.isSuccess, this.l10n);

  final bool isSuccess;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return _RawBadge(
      label: isSuccess
          ? l10n.importExportStatusSuccess
          : l10n.importExportStatusFailed,
      color: isSuccess ? Colors.green : Colors.red,
    );
  }
}

class _RawBadge extends StatelessWidget {
  const _RawBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        border: Border.all(color: color.withAlpha(120)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
