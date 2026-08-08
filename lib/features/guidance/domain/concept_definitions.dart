import '../../../l10n/app_localizations.dart';
import 'concept.dart';

/// Builds the full static concept library from localized strings.
///
/// Content is written once in each locale and never computed at runtime, so the
/// assistant stays fully rule-based with no AI dependency.
List<ConceptHelp> buildConceptHelp(AppLocalizations l10n) => [
      ConceptHelp(
        id: ConceptIds.invoice,
        title: l10n.conceptInvoiceTitle,
        body: l10n.conceptInvoiceBody,
      ),
      ConceptHelp(
        id: ConceptIds.receivable,
        title: l10n.conceptReceivableTitle,
        body: l10n.conceptReceivableBody,
      ),
      ConceptHelp(
        id: ConceptIds.profit,
        title: l10n.conceptProfitTitle,
        body: l10n.conceptProfitBody,
      ),
      ConceptHelp(
        id: ConceptIds.payment,
        title: l10n.conceptPaymentTitle,
        body: l10n.conceptPaymentBody,
      ),
      ConceptHelp(
        id: ConceptIds.bankReconciliation,
        title: l10n.conceptBankReconciliationTitle,
        body: l10n.conceptBankReconciliationBody,
      ),
    ];

/// Returns the explanation for [id], or null when unknown.
ConceptHelp? conceptHelpFor(AppLocalizations l10n, String id) {
  final concepts = buildConceptHelp(l10n);
  for (final concept in concepts) {
    if (concept.id == id) return concept;
  }
  return null;
}
