import 'package:accounting_app/features/guidance/guidance_tour_provider.dart';
import 'package:accounting_app/features/workflows/domain/workflow_definitions.dart';
import 'package:accounting_app/features/workflows/presentation/workflow_overlay.dart';
import 'package:accounting_app/features/workflows/presentation/workflow_trigger.dart';
import 'package:accounting_app/features/workflows/workflow_provider.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _Page extends StatelessWidget {
  const _Page(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(label)), body: const SizedBox());
  }
}

/// Mirrors the app shell: the workflow trigger wraps the page content and the
/// overlay floats above the whole screen.
class _ShellPage extends StatelessWidget {
  const _ShellPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WorkflowTrigger(child: child),
        const WorkflowOverlay(),
      ],
    );
  }
}

GoRouter _router() => GoRouter(
      initialLocation: '/dashboard',
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const _ShellPage(
            child: _Page('Dashboard'),
          ),
        ),
        GoRoute(
          path: '/sales-invoices',
          builder: (context, state) => const _ShellPage(
            child: _Page('Sales Invoices'),
          ),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) =>
              const _ShellPage(child: _Page('Reports')),
        ),
      ],
    );

Widget _buildApp(ProviderContainer container, GoRouter router) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
    ),
  );
}

ProviderContainer _container() {
  return ProviderContainer(
    overrides: [
      // The copilot only auto-starts after the onboarding tour is seen.
      guidanceTourSeenProvider.overrideWith((ref) async => true),
    ],
  );
}

void _startTask(ProviderContainer container, String taskId) {
  // Persistence hits the platform channel, which never resolves under the
  // test's fake async zone. The notifier sets its state synchronously before
  // persisting, so firing-and-forgetting is safe here.
  container.read(workflowProgressProvider.notifier).start(taskId);
}

void main() {
  testWidgets('trigger opens the overlay for the step on the current route',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    _startTask(container, WorkflowTaskIds.createFirstInvoice);

    await tester.pumpWidget(_buildApp(container, _router()));
    await tester.pumpAndSettle();

    // First step lives on /sales-invoices, so nothing shows on the dashboard.
    expect(find.text('Open the sales module'), findsNothing);

    final router = GoRouter.of(tester.element(find.byType(_Page)));
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);
    expect(find.text('Step 1 of 3'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Next advances steps and cross-route steps hand off to the router',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    _startTask(container, WorkflowTaskIds.createFirstInvoice);

    await tester.pumpWidget(_buildApp(container, _router()));
    await tester.pumpAndSettle();

    final router = GoRouter.of(tester.element(find.byType(_Page)));
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    // Step 1 -> step 2 on the same module.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Start a new invoice'), findsOneWidget);
    expect(find.text('Step 2 of 3'), findsOneWidget);

    // Step 2 -> step 3 lives on the dashboard; Next deep-links there and the
    // trigger re-opens the overlay on the matching route.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm your receivable'), findsOneWidget);
    expect(find.text('Step 3 of 3'), findsOneWidget);
    expect(find.text('Finish'), findsOneWidget);

    // Finish completes the task and hides the overlay.
    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    expect(find.text('Confirm your receivable'), findsNothing);
    final progress = container.read(workflowProgressProvider);
    expect(progress.activeTaskId, isNull);
    expect(progress.finishedTaskIds, contains(WorkflowTaskIds.createFirstInvoice));
    // Step progress is folded into the finished-task set on completion.
    expect(progress.completedStepIds, isEmpty);
  });

  testWidgets('Resume later hides the overlay but keeps the task active',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    _startTask(container, WorkflowTaskIds.createFirstInvoice);

    await tester.pumpWidget(_buildApp(container, _router()));
    await tester.pumpAndSettle();

    final router = GoRouter.of(tester.element(find.byType(_Page)));
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);
    await tester.tap(find.text('Resume later'));
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsNothing);
    final progress = container.read(workflowProgressProvider);
    expect(progress.isActive, isTrue);
    expect(progress.completedStepIds, isEmpty);

    // Returning to the route re-opens the overlay at the same step.
    router.go('/reports');
    await tester.pumpAndSettle();
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);
  });

  testWidgets('Cancel abandons the active task', (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    _startTask(container, WorkflowTaskIds.createFirstInvoice);

    await tester.pumpWidget(_buildApp(container, _router()));
    await tester.pumpAndSettle();

    final router = GoRouter.of(tester.element(find.byType(_Page)));
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsNothing);
    expect(container.read(workflowProgressProvider).isActive, isFalse);
  });

  testWidgets('navigating away quietly pauses a cross-module step',
      (tester) async {
    final container = _container();
    addTearDown(container.dispose);
    _startTask(container, WorkflowTaskIds.createFirstInvoice);

    await tester.pumpWidget(_buildApp(container, _router()));
    await tester.pumpAndSettle();

    final router = GoRouter.of(tester.element(find.byType(_Page)));
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);

    // Leaving the module hides the overlay without touching progress.
    router.go('/reports');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsNothing);
    final progress = container.read(workflowProgressProvider);
    expect(progress.isActive, isTrue);
    expect(progress.completedStepIds, isEmpty);

    // Coming back resumes at the same step.
    router.go('/sales-invoices');
    await tester.pumpAndSettle();

    expect(find.text('Open the sales module'), findsOneWidget);
  });
}
