import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/currency.dart';
import '../domain/multi_currency_controller.dart';

/// Page for managing currencies and viewing exchange rates.
class CurrenciesPage extends ConsumerWidget {
  const CurrenciesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currenciesAsync = ref.watch(currenciesControllerProvider);
    final ratesAsync = ref.watch(exchangeRatesControllerProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.currenciesPageTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.currenciesTabCurrencies),
              Tab(text: l10n.currenciesTabRates),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _CurrenciesTab(currenciesAsync: currenciesAsync, l10n: l10n, ref: ref),
            _RatesTab(ratesAsync: ratesAsync, currenciesAsync: currenciesAsync, l10n: l10n, ref: ref),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Currencies tab
// ─────────────────────────────────────────────────────────────────────────────

class _CurrenciesTab extends StatelessWidget {
  const _CurrenciesTab({
    required this.currenciesAsync,
    required this.l10n,
    required this.ref,
  });

  final AsyncValue<List<Currency>> currenciesAsync;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return currenciesAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, _) => AppErrorState(message: '${l10n.currenciesLoadError} $e'),
      data: (currencies) {
        if (currencies.isEmpty) {
          return AppEmptyState(
            title: l10n.currenciesEmptyTitle,
            message: l10n.currenciesEmptyMessage,
          );
        }
        return ListView.separated(
          itemCount: currencies.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final c = currencies[i];
            return ListTile(
              leading: _CurrencyAvatar(symbol: c.symbol),
              title: Row(
                children: [
                  Text(
                    c.isoCode,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),
                  if (c.isBase) _Badge(l10n.currencyBadgeBase, Colors.blue),
                  if (!c.isActive) ...[
                    const SizedBox(width: 4),
                    _Badge(l10n.currencyBadgeInactive, Colors.grey),
                  ],
                ],
              ),
              subtitle: Text(c.name),
              trailing: c.isBase
                  ? null
                  : TextButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: ctx,
                          builder: (dCtx) => AlertDialog(
                            title: Text(l10n.currencySetBaseTitle),
                            content: Text(l10n.currencySetBaseConfirm(c.isoCode)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(dCtx).pop(false),
                                child: Text(l10n.invoiceCancel),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.of(dCtx).pop(true),
                                child: Text(l10n.currencySetBaseAction),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          await ref
                              .read(currenciesControllerProvider.notifier)
                              .setBase(c.isoCode);
                        }
                      },
                      child: Text(l10n.currencySetBaseAction),
                    ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Exchange rates tab
// ─────────────────────────────────────────────────────────────────────────────

class _RatesTab extends StatelessWidget {
  const _RatesTab({
    required this.ratesAsync,
    required this.currenciesAsync,
    required this.l10n,
    required this.ref,
  });

  final AsyncValue<List<ExchangeRate>> ratesAsync;
  final AsyncValue<List<Currency>> currenciesAsync;
  final AppLocalizations l10n;
  final WidgetRef ref;

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _showEditDialog(
    BuildContext context,
    ExchangeRate rate,
  ) async {
    final ctrl = TextEditingController(text: rate.rate.toString());
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dCtx) {
        return AlertDialog(
          title: Text(l10n.currencyEditRateTitle),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: ctrl,
              decoration: InputDecoration(
                labelText: l10n.currencyRateLabel(
                  rate.fromCurrency,
                  rate.toCurrency,
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return l10n.requiredField;
                final n = double.tryParse(v.trim());
                if (n == null || n <= 0) {
                  return l10n.currencyRateInvalid;
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dCtx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final newRate = double.parse(ctrl.text.trim());
                await ref
                    .read(exchangeRatesControllerProvider.notifier)
                    .updateRate(rate.id, newRate);
                if (dCtx.mounted) Navigator.of(dCtx).pop();
              },
              child: Text(l10n.invoiceSave),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ratesAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, _) => AppErrorState(message: '${l10n.currenciesLoadError} $e'),
      data: (rates) {
        if (rates.isEmpty) {
          return AppEmptyState(
            title: l10n.currenciesEmptyTitle,
            message: l10n.currenciesEmptyMessage,
          );
        }
        return ListView.separated(
          itemCount: rates.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final rate = rates[i];
            return ListTile(
              leading: const Icon(Icons.currency_exchange, size: 22),
              title: Text(
                '${rate.fromCurrency} → ${rate.toCurrency}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${l10n.currencyRateValue}: ${rate.rate}  •  ${_formatDate(rate.effectiveDate)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                tooltip: l10n.currencyEditRateTitle,
                onPressed: () => _showEditDialog(ctx, rate),
              ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CurrencyAvatar extends StatelessWidget {
  const _CurrencyAvatar({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        symbol,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label, this.color);

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
