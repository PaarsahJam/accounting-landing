import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/concept_definitions.dart';

/// Reusable "What does this mean?" affordance for a static concept.
///
/// Shows an icon button (or a labeled text button when [label] is provided)
/// that opens a dialog with the plain-language explanation for [conceptId].
class ConceptHelpButton extends StatelessWidget {
  const ConceptHelpButton({super.key, required this.conceptId, this.label});

  final String conceptId;

  /// When provided, renders a labeled text button; otherwise an icon button
  /// with a "What does this mean?" tooltip.
  final String? label;

  Future<void> _showConcept(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final concept = conceptHelpFor(l10n, conceptId);
    if (concept == null) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(concept.title),
          content: SingleChildScrollView(
            child: Text(concept.body),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.conceptHelpGotIt),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tooltip =
        l10n?.conceptHelpWhatDoesThisMean ?? 'What does this mean?';
    final helpIcon = const Icon(Icons.help_outline);

    if (label == null) {
      return IconButton(
        tooltip: tooltip,
        onPressed: () => _showConcept(context),
        icon: helpIcon,
      );
    }

    return TextButton.icon(
      onPressed: () => _showConcept(context),
      icon: helpIcon,
      label: Text(label!),
    );
  }
}
