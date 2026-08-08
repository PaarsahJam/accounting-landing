import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/concept.dart';
import '../domain/concept_definitions.dart';
import '../domain/contextual_tip.dart';
import '../guidance_tips_provider.dart';
import '../guidance_tour_provider.dart';
import 'guidance_tour_keys.dart';

/// Rule-based mapping of route -> concepts to teach on first visit.
///
/// Tips already dismissed for a concept are filtered out, so each concept is
/// only ever shown once per device.
List<ContextualTip> buildContextualTipsForRoute(
  String location,
  Set<String> dismissed,
  AppLocalizations l10n,
) {
  final concepts = buildConceptHelp(l10n);
  ContextualTip tip(String id, GlobalKey? targetKey) {
    final concept = concepts.firstWhere(
      (c) => c.id == id,
      orElse: () => throw StateError('Unknown concept id: $id'),
    );
    return ContextualTip(
      id: concept.id,
      title: concept.title,
      body: concept.body,
      targetKey: targetKey,
    );
  }

  final candidates = <ContextualTip>[];
  switch (location) {
    case '/dashboard':
      candidates.add(tip(ConceptIds.receivable, GuidanceTourKeys.metricAccountsReceivable));
      candidates.add(tip(ConceptIds.profit, GuidanceTourKeys.profitOverview));
    case '/sales-invoices':
      candidates.add(tip(ConceptIds.invoice, GuidanceTourKeys.salesInvoicesHeader));
    case '/invoices':
      candidates.add(tip(ConceptIds.invoice, GuidanceTourKeys.invoicesHeader));
    case '/customer-payments':
      candidates.add(tip(ConceptIds.payment, GuidanceTourKeys.customerPaymentsHeader));
    case '/vendor-payments':
      candidates.add(tip(ConceptIds.payment, GuidanceTourKeys.vendorPaymentsHeader));
    case '/bank-reconciliation':
      candidates.add(tip(ConceptIds.bankReconciliation, GuidanceTourKeys.bankReconciliationHeader));
  }

  return candidates.where((tip) => !dismissed.contains(tip.id)).toList();
}

/// Starts the first-time contextual tips for the current route.
///
/// The overlay itself is rendered by the app shell; this widget only decides
/// when to begin showing tips, and only when the first-run tour is not active.
class ContextualTipTrigger extends ConsumerWidget {
  const ContextualTipTrigger({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dismissed = ref.watch(dismissedTipsProvider);
    final controller = ref.watch(contextualTipControllerProvider);
    final tourVisible = ref.watch(guidanceTourControllerProvider).isVisible;
    final location = GoRouterState.of(context).matchedLocation;

    if (!controller.isVisible && !tourVisible) {
      final l10n = AppLocalizations.of(context);
      final pending = l10n == null
          ? const <ContextualTip>[]
          : buildContextualTipsForRoute(location, dismissed, l10n);

      if (pending.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.mounted) return;
          final current = ref.read(contextualTipControllerProvider);
          if (current.isVisible) return;
          if (ref.read(guidanceTourControllerProvider).isVisible) return;
          if (GoRouterState.of(context).matchedLocation != location) return;
          final l10nNow = AppLocalizations.of(context);
          if (l10nNow == null) return;
          final stillPending = buildContextualTipsForRoute(
            location,
            ref.read(dismissedTipsProvider),
            l10nNow,
          );
          if (stillPending.isEmpty) return;
          current.start(stillPending);
        });
      }
    }

    return child;
  }
}
