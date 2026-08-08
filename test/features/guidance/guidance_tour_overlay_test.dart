import 'package:accounting_app/features/guidance/domain/guidance_tour.dart';
import 'package:accounting_app/features/guidance/guidance_tour_provider.dart';
import 'package:accounting_app/features/guidance/presentation/guidance_tour_overlay.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp(ProviderContainer container, GlobalKey targetKey) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              width: 200,
              height: 120,
              child: ColoredBox(key: targetKey, color: Colors.amber),
            ),
            const GuidanceTourOverlay(),
          ],
        ),
      ),
    ),
  );
}

ProviderContainer _container() {
  return ProviderContainer(
    overrides: [
      guidanceTourSeenProvider.overrideWith((ref) async => false),
    ],
  );
}

void main() {
  testWidgets('shows tooltip pointing at the target and advances via Next',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();
    final controller = container.read(guidanceTourControllerProvider);

    controller.start([
      GuidanceTourStep(
        title: 'First title',
        body: 'First body',
        targetKey: targetKey,
      ),
      const GuidanceTourStep(title: 'Last title', body: 'Last body'),
    ]);

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    expect(find.text('First title'), findsOneWidget);
    expect(find.text('First body'), findsOneWidget);
    expect(find.text('Step 1 of 2'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Last title'), findsOneWidget);
    expect(find.text('Step 2 of 2'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
    expect(find.text('Next'), findsNothing);
  });

  testWidgets('Done finishes the tour and hides the overlay', (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();
    final controller = container.read(guidanceTourControllerProvider);

    controller.start([
      GuidanceTourStep(title: 'First title', body: 'First body', targetKey: targetKey),
      const GuidanceTourStep(title: 'Last title', body: 'Last body'),
    ]);

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.text('Last title'), findsNothing);
    expect(controller.isVisible, isFalse);
  });

  testWidgets('Skip dismisses the tour', (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();
    final controller = container.read(guidanceTourControllerProvider);

    controller.start([
      GuidanceTourStep(title: 'First title', body: 'First body', targetKey: targetKey),
    ]);

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(controller.isVisible, isFalse);
  });

  testWidgets('overlay is a no-op when no tour is running', (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsNothing);
    expect(find.text('Skip'), findsNothing);
  });
}
