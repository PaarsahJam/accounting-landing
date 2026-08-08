import 'package:accounting_app/features/guidance/guidance_tips_provider.dart';
import 'package:accounting_app/features/guidance/presentation/contextual_tip_trigger.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('starts contextual tips for the current route on first visit',
      (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final router = GoRouter(
      initialLocation: '/dashboard',
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) =>
              const ContextualTipTrigger(child: Scaffold(body: SizedBox())),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final controller = container.read(contextualTipControllerProvider);
    expect(controller.isVisible, isTrue);
    expect(controller.currentTip?.id, 'receivable');
  });

  testWidgets('skips tips that were already dismissed', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(dismissedTipsProvider.notifier).state = {'receivable'};

    final router = GoRouter(
      initialLocation: '/dashboard',
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) =>
              const ContextualTipTrigger(child: Scaffold(body: SizedBox())),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final controller = container.read(contextualTipControllerProvider);
    expect(controller.isVisible, isTrue);
    expect(controller.currentTip?.id, 'profit');
  });
}
