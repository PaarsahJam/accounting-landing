import 'package:accounting_app/features/guidance/domain/concept.dart';
import 'package:accounting_app/features/guidance/domain/concept_definitions.dart';
import 'package:accounting_app/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildConceptHelp', () {
    test('returns all five built-in concepts in stable order', () {
      final l10n = AppLocalizationsEn('en');
      final concepts = buildConceptHelp(l10n);

      expect(concepts.map((c) => c.id), ConceptIds.all);
    });

    test('every concept has a non-empty localized title and body', () {
      final l10n = AppLocalizationsEn('en');
      for (final concept in buildConceptHelp(l10n)) {
        expect(concept.title, isNotEmpty, reason: 'title for ${concept.id}');
        expect(concept.body, isNotEmpty, reason: 'body for ${concept.id}');
      }
    });

    test('bodies are written in plain language for beginners', () {
      final l10n = AppLocalizationsEn('en');
      final invoice = conceptHelpFor(l10n, ConceptIds.invoice);
      expect(invoice?.body.toLowerCase(), contains('bill'));
      final profit = conceptHelpFor(l10n, ConceptIds.profit);
      expect(profit?.body.toLowerCase(), contains('revenue'));
    });
  });

  group('conceptHelpFor', () {
    test('returns the matching concept by id', () {
      final l10n = AppLocalizationsEn('en');
      final receivable = conceptHelpFor(l10n, ConceptIds.receivable);
      expect(receivable?.id, ConceptIds.receivable);
      expect(receivable?.title, l10n.conceptReceivableTitle);
    });

    test('returns null for an unknown id', () {
      final l10n = AppLocalizationsEn('en');
      expect(conceptHelpFor(l10n, 'not-a-concept'), isNull);
    });
  });
}
