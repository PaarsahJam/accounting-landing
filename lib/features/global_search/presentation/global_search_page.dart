import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/global_search_controller.dart';
import '../domain/search_result.dart';

class GlobalSearchPage extends ConsumerStatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  ConsumerState<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends ConsumerState<GlobalSearchPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _hasSearched = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      ref.read(globalSearchControllerProvider.notifier).clearResults();
      setState(() => _hasSearched = false);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () {
      setState(() => _hasSearched = true);
      ref.read(globalSearchControllerProvider.notifier).search(query.trim());
    });
  }

  void _onRecentTap(String query) {
    _searchController.text = query;
    setState(() => _hasSearched = true);
    ref.read(globalSearchControllerProvider.notifier).search(query);
  }

  void _navigateTo(BuildContext context, SearchResult result) {
    context.goNamed(result.route);
  }

  String _groupLabel(SearchEntityType type, AppLocalizations l10n) {
    switch (type) {
      case SearchEntityType.customer:
        return l10n.searchGroupCustomers;
      case SearchEntityType.vendor:
        return l10n.searchGroupVendors;
      case SearchEntityType.product:
        return l10n.searchGroupProducts;
      case SearchEntityType.salesInvoice:
        return l10n.searchGroupSalesInvoices;
      case SearchEntityType.vendorBill:
        return l10n.searchGroupVendorBills;
      case SearchEntityType.purchaseOrder:
        return l10n.searchGroupPurchaseOrders;
      case SearchEntityType.goodsReceipt:
        return l10n.searchGroupGoodsReceipts;
      case SearchEntityType.bankAccount:
        return l10n.searchGroupBankAccounts;
      case SearchEntityType.journalEntry:
        return l10n.searchGroupJournalEntries;
      case SearchEntityType.fiscalPeriod:
        return l10n.searchGroupFiscalPeriods;
    }
  }

  Map<SearchEntityType, List<SearchResult>> _groupResults(
    List<SearchResult> results,
  ) {
    final map = <SearchEntityType, List<SearchResult>>{};
    for (final r in results) {
      map.putIfAbsent(r.entityType, () => []).add(r);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final searchAsync = ref.watch(globalSearchControllerProvider);
    final recentAsync = ref.watch(recentSearchesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _onQueryChanged,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
            filled: false,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (q) {
            if (q.trim().isNotEmpty) {
              setState(() => _hasSearched = true);
              ref
                  .read(globalSearchControllerProvider.notifier)
                  .search(q.trim());
            }
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: l10n.searchClear,
              onPressed: () {
                _searchController.clear();
                ref
                    .read(globalSearchControllerProvider.notifier)
                    .clearResults();
                setState(() => _hasSearched = false);
              },
            ),
        ],
      ),
      body: !_hasSearched
          ? _buildRecentSearches(context, recentAsync, l10n, theme)
          : searchAsync.when(
              loading: () => const AppLoadingState(),
              error: (e, _) =>
                  AppErrorState(message: '${l10n.searchErrorMessage} $e'),
              data: (results) {
                if (results.isEmpty) {
                  return AppEmptyState(
                    title: l10n.searchEmptyTitle,
                    message: l10n.searchEmptyMessage(
                      _searchController.text.trim(),
                    ),
                  );
                }
                return _buildGroupedResults(context, results, l10n, theme);
              },
            ),
    );
  }

  Widget _buildRecentSearches(
    BuildContext context,
    AsyncValue<List<String>> recentAsync,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return recentAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (recent) {
        if (recent.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                l10n.searchRecentEmpty,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
              child: Row(
                children: [
                  Text(
                    l10n.searchRecentTitle,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => ref
                        .read(recentSearchesControllerProvider.notifier)
                        .clear(),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                    child: Text(l10n.searchRecentClear),
                  ),
                ],
              ),
            ),
            ...recent.map(
              (q) => ListTile(
                dense: true,
                leading: const Icon(Icons.history, size: 18),
                title: Text(q, style: theme.textTheme.bodySmall),
                onTap: () => _onRecentTap(q),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGroupedResults(
    BuildContext context,
    List<SearchResult> results,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final groups = _groupResults(results);

    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (ctx, groupIndex) {
        final type = groups.keys.elementAt(groupIndex);
        final items = groups[type]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                _groupLabel(type, l10n),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            ...items.map(
              (result) => ListTile(
                dense: true,
                leading: Icon(result.icon, size: 20),
                title: Text(
                  result.title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: result.subtitle.isNotEmpty
                    ? Text(
                        result.subtitle,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                trailing: const Icon(Icons.chevron_right, size: 16),
                onTap: () => _navigateTo(context, result),
              ),
            ),
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}
