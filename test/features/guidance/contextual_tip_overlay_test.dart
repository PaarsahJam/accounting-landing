import 'package:accounting_app/features/guidance/domain/contextual_tip.dart';
import 'package:accounting_app/features/guidance/guidance_tips_provider.dart';
import 'package:accounting_app/features/guidance/presentation/contextual_tip_overlay.dart';
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
      locale: const Locale('en'),
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
            const ContextualTipOverlay(),
          ],
        ),
      ),
    ),
  );
}

ProviderContainer _container() {
  return ProviderContainer();
}

void main() {
  testWidgets('shows the tip pointing at the target and Got it dismisses it',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();
    final controller = container.read(contextualTipControllerProvider);

    controller.start([
      ContextualTip(
        id: 'invoice',
        title: 'What is an invoice?',
        body: 'An invoice is a bill.',
        targetKey: targetKey,
      ),
    ]);

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    expect(find.text('What is an invoice?'), findsOneWidget);
    expect(find.text('An invoice is a bill.'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('What is an invoice?'), findsNothing);
    expect(controller.isVisible, isFalse);
    expect(container.read(dismissedTipsProvider), contains('invoice'));
  });

  testWidgets('advances through a queue and persists each dismissal',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();
    final controller = container.read(contextualTipControllerProvider);

    controller.start([
      ContextualTip(
        id: 'receivable',
        title: 'First',
        body: 'Body one',
        targetKey: targetKey,
      ),
      const ContextualTip(id: 'profit', title: 'Second', body: 'Body two'),
    ]);

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    expect(find.text('First'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Second'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(controller.isVisible, isFalse);
    expect(
      container.read(dismissedTipsProvider),
      containsAll({'receivable', 'profit'}),
    );
  });

  testWidgets('overlay is a no-op when no tips are running', (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    final targetKey = GlobalKey();

    await tester.pumpWidget(_buildApp(container, targetKey));
    await tester.pumpAndSettle();

    expect(find.text('Got it'), findsNothing);
  });
}
