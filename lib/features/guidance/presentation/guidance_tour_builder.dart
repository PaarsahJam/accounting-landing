import 'package:flutter/widgets.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/guidance_tour.dart';
import 'guidance_tour_keys.dart';

/// Builds the ordered tour steps from localized strings.
///
/// The app-bar steps (search, language/theme, notifications) only apply on
/// desktop where the global app bar is rendered.
List<GuidanceTourStep> buildGuidanceTourSteps({
  required AppLocalizations l10n,
  required bool useRail,
}) {
  final steps = <GuidanceTourStep>[
    GuidanceTourStep(
      title: l10n.guidanceWelcomeTitle,
      body: l10n.guidanceWelcomeBody,
      targetKey: GuidanceTourKeys.dashboardHeader,
    ),
    GuidanceTourStep(
      title: l10n.guidanceQuickActionsTitle,
      body: l10n.guidanceQuickActionsBody,
      targetKey: GuidanceTourKeys.quickActionSalesInvoice,
      highlightPadding: const EdgeInsets.all(8),
    ),
    GuidanceTourStep(
      title: l10n.guidanceMetricsTitle,
      body: l10n.guidanceMetricsBody,
      targetKey: GuidanceTourKeys.metricAccountsReceivable,
      highlightPadding: const EdgeInsets.all(8),
    ),
    GuidanceTourStep(
      title: l10n.guidancePerformanceTitle,
      body: l10n.guidancePerformanceBody,
      targetKey: GuidanceTourKeys.profitOverview,
      highlightPadding: const EdgeInsets.all(8),
    ),
    GuidanceTourStep(
      title: l10n.guidanceNavigationTitle,
      body: l10n.guidanceNavigationBody,
      targetKey: GuidanceTourKeys.navSales,
      highlightPadding: const EdgeInsets.all(20),
    ),
    GuidanceTourStep(
      title: l10n.guidanceBankingTitle,
      body: l10n.guidanceBankingBody,
      targetKey: GuidanceTourKeys.navBanking,
      highlightPadding: const EdgeInsets.all(20),
    ),
    GuidanceTourStep(
      title: l10n.guidanceReportsTitle,
      body: l10n.guidanceReportsBody,
      targetKey: GuidanceTourKeys.navReports,
      highlightPadding: const EdgeInsets.all(20),
    ),
  ];

  if (useRail) {
    steps.addAll([
      GuidanceTourStep(
        title: l10n.guidanceSearchTitle,
        body: l10n.guidanceSearchBody,
        targetKey: GuidanceTourKeys.searchButton,
        highlightPadding: const EdgeInsets.all(6),
      ),
      GuidanceTourStep(
        title: l10n.guidanceLanguageTitle,
        body: l10n.guidanceLanguageBody,
        targetKey: GuidanceTourKeys.languageButton,
        highlightPadding: const EdgeInsets.all(6),
      ),
      GuidanceTourStep(
        title: l10n.guidanceNotificationsTitle,
        body: l10n.guidanceNotificationsBody,
        targetKey: GuidanceTourKeys.notificationsBell,
        highlightPadding: const EdgeInsets.all(6),
      ),
    ]);
  }

  steps.add(
    GuidanceTourStep(
      title: l10n.guidanceReadyTitle,
      body: l10n.guidanceReadyBody,
    ),
  );

  return steps;
}
