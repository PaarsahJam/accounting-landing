// lib/features/fixed_assets/presentation/fixed_assets_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../data/fixed_assets_repository_provider.dart';
import '../domain/fixed_asset.dart';
import '../domain/fixed_assets_controller.dart';

class FixedAssetsPage extends ConsumerWidget {
  const FixedAssetsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final assetsAsync = ref.watch(fixedAssetsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fixedAssetsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l10n.fixedAssetCreateTitle,
            onPressed: () => _showCreateEditDialog(context, ref, l10n, null),
          ),
        ],
      ),
      body: assetsAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) =>
            AppErrorState(message: '${l10n.fixedAssetsLoadError} $e'),
        data: (assets) {
          if (assets.isEmpty) {
            return AppEmptyState(
              title: l10n.fixedAssetsEmptyTitle,
              message: l10n.fixedAssetsEmptyMessage,
            );
          }
          return ListView.separated(
            itemCount: assets.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (ctx, i) {
              final asset = assets[i];
              return _AssetTile(
                asset: asset,
                l10n: l10n,
                ref: ref,
                onEdit: () => _showCreateEditDialog(context, ref, l10n, asset),
                onSchedule: () =>
                    _showScheduleDialog(context, ref, l10n, asset),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showCreateEditDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    FixedAsset? existing,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dCtx) =>
          _CreateEditDialog(existing: existing, l10n: l10n, ref: ref),
    );
  }

  Future<void> _showScheduleDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    FixedAsset asset,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dCtx) => _ScheduleDialog(asset: asset, l10n: l10n, ref: ref),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Asset tile
// ─────────────────────────────────────────────────────────────────────────────

class _AssetTile extends StatelessWidget {
  const _AssetTile({
    required this.asset,
    required this.l10n,
    required this.ref,
    required this.onEdit,
    required this.onSchedule,
  });

  final FixedAsset asset;
  final AppLocalizations l10n;
  final WidgetRef ref;
  final VoidCallback onEdit;
  final VoidCallback onSchedule;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: asset.isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.business_center_outlined,
          size: 20,
          color: asset.isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              asset.assetName,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          _MethodBadge(asset.depreciationMethod),
          const SizedBox(width: 4),
          if (asset.isActive)
            _StatusBadge(l10n.fixedAssetBadgeActive, Colors.green)
          else
            _StatusBadge(l10n.fixedAssetBadgeDisposed, Colors.grey),
        ],
      ),
      subtitle: Text(
        '${l10n.fixedAssetCategory}: ${asset.category}'
        '  •  ${l10n.fixedAssetBookValue}: ${asset.bookValue.toStringAsFixed(2)}'
        '  •  ${l10n.fixedAssetAccumDepreciation}: ${asset.accumulatedDepreciation.toStringAsFixed(2)}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.table_chart_outlined, size: 20),
            tooltip: l10n.fixedAssetViewSchedule,
            onPressed: onSchedule,
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              final notifier = ref.read(fixedAssetsControllerProvider.notifier);
              switch (value) {
                case 'edit':
                  onEdit();
                case 'depreciate':
                  await notifier.calculateDepreciation(asset.id);
                case 'dispose':
                  await notifier.disposeAsset(asset.id);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: const Icon(Icons.edit_outlined, size: 18),
                  title: Text(l10n.fixedAssetEditTitle),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (asset.isActive) ...[
                PopupMenuItem(
                  value: 'depreciate',
                  child: ListTile(
                    leading: const Icon(Icons.trending_down, size: 18),
                    title: Text(l10n.fixedAssetCalculateDepreciation),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'dispose',
                  child: ListTile(
                    leading: const Icon(Icons.delete_outline, size: 18),
                    title: Text(l10n.fixedAssetDispose),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Depreciation schedule dialog
// ─────────────────────────────────────────────────────────────────────────────

class _ScheduleDialog extends StatefulWidget {
  const _ScheduleDialog({
    required this.asset,
    required this.l10n,
    required this.ref,
  });

  final FixedAsset asset;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  State<_ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<_ScheduleDialog> {
  late Future<List<DepreciationEntry>> _scheduleFuture;

  @override
  void initState() {
    super.initState();
    final repo = widget.ref.read(fixedAssetsRepositoryProvider);
    _scheduleFuture = repo
        .fetchDepreciationSchedule(widget.asset.id)
        .then((r) => r.data ?? const []);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final asset = widget.asset;
    return AlertDialog(
      title: Text('${l10n.fixedAssetScheduleTitle} — ${asset.assetName}'),
      content: SizedBox(
        width: 560,
        height: 320,
        child: FutureBuilder<List<DepreciationEntry>>(
          future: _scheduleFuture,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return Text('Error: ${snap.error}');
            final entries = snap.data ?? const [];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(label: Text(l10n.fixedAssetScheduleYear)),
                  DataColumn(
                    label: Text(l10n.fixedAssetScheduleOpening),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(l10n.fixedAssetScheduleCharge),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(l10n.fixedAssetScheduleAccum),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(l10n.fixedAssetScheduleClosing),
                    numeric: true,
                  ),
                ],
                rows: entries
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(Text(e.year.toString())),
                          DataCell(Text(e.openingBookValue.toStringAsFixed(2))),
                          DataCell(
                            Text(e.depreciationCharge.toStringAsFixed(2)),
                          ),
                          DataCell(
                            Text(e.accumulatedDepreciation.toStringAsFixed(2)),
                          ),
                          DataCell(Text(e.closingBookValue.toStringAsFixed(2))),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          },
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
// Create / Edit dialog
// ─────────────────────────────────────────────────────────────────────────────

class _CreateEditDialog extends StatefulWidget {
  const _CreateEditDialog({
    required this.existing,
    required this.l10n,
    required this.ref,
  });

  final FixedAsset? existing;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  State<_CreateEditDialog> createState() => _CreateEditDialogState();
}

class _CreateEditDialogState extends State<_CreateEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _categoryCtrl;
  late final TextEditingController _costCtrl;
  late final TextEditingController _salvageCtrl;
  late final TextEditingController _lifeCtrl;
  late final TextEditingController _notesCtrl;
  late DepreciationMethod _method;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameCtrl = TextEditingController(text: e?.assetName ?? '');
    _categoryCtrl = TextEditingController(text: e?.category ?? '');
    _costCtrl = TextEditingController(
      text: e?.purchaseCost.toStringAsFixed(2) ?? '',
    );
    _salvageCtrl = TextEditingController(
      text: e?.salvageValue.toStringAsFixed(2) ?? '0',
    );
    _lifeCtrl = TextEditingController(
      text: e?.usefulLifeYears.toString() ?? '5',
    );
    _notesCtrl = TextEditingController(text: e?.notes ?? '');
    _method = e?.depreciationMethod ?? DepreciationMethod.straightLine;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _categoryCtrl.dispose();
    _costCtrl.dispose();
    _salvageCtrl.dispose();
    _lifeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isEdit = widget.existing != null;
    return AlertDialog(
      title: Text(
        isEdit ? l10n.fixedAssetEditTitle : l10n.fixedAssetCreateTitle,
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(labelText: l10n.fixedAssetName),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.requiredField
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _categoryCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.fixedAssetCategory,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.requiredField
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _costCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.fixedAssetPurchaseCost,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    if (double.tryParse(v.trim()) == null) {
                      return l10n.fixedAssetInvalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _salvageCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.fixedAssetSalvageValue,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    if (double.tryParse(v.trim()) == null) {
                      return l10n.fixedAssetInvalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lifeCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.fixedAssetUsefulLife,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    final n = int.tryParse(v.trim());
                    if (n == null || n <= 0) {
                      return l10n.fixedAssetInvalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<DepreciationMethod>(
                  initialValue: _method,
                  decoration: InputDecoration(
                    labelText: l10n.fixedAssetDepreciationMethod,
                  ),
                  items: DepreciationMethod.values.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(
                        m == DepreciationMethod.straightLine
                            ? l10n.fixedAssetMethodStraightLine
                            : l10n.fixedAssetMethodDecliningBalance,
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _method = v);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notesCtrl,
                  decoration: InputDecoration(labelText: l10n.fixedAssetNotes),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.invoiceCancel),
        ),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final notifier = widget.ref.read(
              fixedAssetsControllerProvider.notifier,
            );
            final now = DateTime.now();
            final asset = FixedAsset(
              id: widget.existing?.id ?? '',
              assetCode: widget.existing?.assetCode ?? '',
              assetName: _nameCtrl.text.trim(),
              category: _categoryCtrl.text.trim(),
              purchaseDate: widget.existing?.purchaseDate ?? now,
              purchaseCost: double.parse(_costCtrl.text.trim()),
              salvageValue: double.parse(_salvageCtrl.text.trim()),
              usefulLifeYears: int.parse(_lifeCtrl.text.trim()),
              depreciationMethod: _method,
              accumulatedDepreciation:
                  widget.existing?.accumulatedDepreciation ?? 0.0,
              isActive: widget.existing?.isActive ?? true,
              notes: _notesCtrl.text.trim().isEmpty
                  ? null
                  : _notesCtrl.text.trim(),
            );
            if (widget.existing == null) {
              await notifier.createAsset(asset);
            } else {
              await notifier.updateAsset(asset);
            }
            if (context.mounted) Navigator.of(context).pop();
          },
          child: Text(l10n.invoiceSave),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Badge widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.label, this.color);

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

class _MethodBadge extends StatelessWidget {
  const _MethodBadge(this.method);

  final DepreciationMethod method;

  @override
  Widget build(BuildContext context) {
    final label = method == DepreciationMethod.straightLine ? 'SL' : 'DB';
    final color = method == DepreciationMethod.straightLine
        ? Colors.indigo
        : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        border: Border.all(color: color.withAlpha(100)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
