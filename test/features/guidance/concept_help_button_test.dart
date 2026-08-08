import 'package:accounting_app/features/guidance/domain/concept.dart';
import 'package:accounting_app/features/guidance/presentation/concept_help_button.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('labeled button opens the concept dialog and Got it closes it',
      (tester) async {
    await tester.pumpWidget(
      buildApp(
        const ConceptHelpButton(
          conceptId: ConceptIds.invoice,
          label: 'What does this mean?',
        ),
      ),
    );

    expect(find.text('What does this mean?'), findsOneWidget);

    await tester.tap(find.text('What does this mean?'));
    await tester.pumpAndSettle();

    expect(find.text('Invoice'), findsOneWidget);
    expect(find.textContaining('bill you send'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Invoice'), findsNothing);
    expect(find.text('Got it'), findsNothing);
  });

  testWidgets('icon-only button exposes the tooltip and opens the dialog',
      (tester) async {
    await tester.pumpWidget(
      buildApp(const ConceptHelpButton(conceptId: ConceptIds.profit)),
    );

    expect(find.byIcon(Icons.help_outline), findsOneWidget);
    expect(find.byTooltip('What does this mean?'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();

    expect(find.text('Profit'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
  });

  testWidgets('unknown concept id renders a no-op button', (tester) async {
    await tester.pumpWidget(
      buildApp(const ConceptHelpButton(conceptId: 'not-a-concept')),
    );

    await tester.tap(find.byIcon(Icons.help_outline));
    await tester.pumpAndSettle();

    expect(find.text('Got it'), findsNothing);
  });
}
