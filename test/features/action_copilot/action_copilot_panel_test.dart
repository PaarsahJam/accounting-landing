import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_live_context.dart';
import 'package:accounting_app/core/ai/ai_provider.dart';
import 'package:accounting_app/core/ai/ai_providers.dart';
import 'package:accounting_app/core/ai/providers/fake_ai_provider.dart';
import 'package:accounting_app/core/ai/use_cases/ai_draft_action.dart';
import 'package:accounting_app/core/ai/use_cases/ai_summarize.dart';
import 'package:accounting_app/features/action_copilot/presentation/action_copilot_panel.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository_provider.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp({AiProvider? aiProvider}) {
  final provider = aiProvider ?? FakeAiProvider();
  return ProviderScope(
    overrides: [
      salesInvoicesRepositoryProvider.overrideWithValue(
        MockSalesInvoicesRepository(),
      ),
      aiLiveContextProvider.overrideWithValue(_FakeLiveContext()),
      aiProviderProvider.overrideWithValue(provider),
      aiSummarizeProvider.overrideWithValue(
        AiSummarize(
          aiProvider: provider,
          gateway: AiActionGateway(
            auditRepository: MockAuditTrailRepository(),
            performedBy: 'test',
          ),
        ),
      ),
      aiDraftActionProvider.overrideWithValue(
        AiDraftAction(
          aiProvider: provider,
          gateway: AiActionGateway(
            auditRepository: MockAuditTrailRepository(),
            performedBy: 'test',
          ),
        ),
      ),
      aiActionGatewayProvider.overrideWithValue(
        AiActionGateway(
          auditRepository: MockAuditTrailRepository(),
          performedBy: 'test',
        ),
      ),
    ],
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ActionCopilotPanel(),
      ),
    ),
  );
}

void main() {
  Future<void> pumpApp(WidgetTester tester, {AiProvider? aiProvider}) async {
    await tester.pumpWidget(_buildApp(aiProvider: aiProvider));
    await tester.pump();
    // Let the sales invoices fetch (triggered by the copilot's listener)
    // complete so no timer is left pending.
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
  }

  testWidgets('ActionCopilotPanel renders title and drafting buttons',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Action Copilot'), findsOneWidget);
    expect(find.text('Suggest invoice'), findsOneWidget);
    expect(find.text('Financial summary'), findsOneWidget);
    expect(find.text('Next best action'), findsOneWidget);
  });

  testWidgets('selecting an action opens the review sheet with the draft',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Financial summary'));
    await tester.pumpAndSettle();

    // Review sheet appears with the generated draft and a confirmation action.
    expect(find.text('Financial summary'), findsWidgets);
    expect(find.text('Confirm & Save'), findsOneWidget);
    expect(find.textContaining('summary'), findsWidgets);
  });

  testWidgets('saving without confirmation is blocked; confirm then save works',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Financial summary'));
    await tester.pumpAndSettle();

    // The sheet should never offer a plain save; only "Confirm & Save".
    expect(find.text('Save draft'), findsNothing);

    await tester.tap(find.text('Confirm & Save'));
    await tester.pumpAndSettle();

    // Explicit confirmation dialog appears.
    expect(find.text('Confirm AI draft'), findsOneWidget);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // Draft saved.
    expect(find.text('Draft confirmed and saved.'), findsOneWidget);
  });

  testWidgets('AI failure shows fallback message and nothing is saved',
      (tester) async {
    await pumpApp(tester, aiProvider: _ThrowingAiProvider());

    await tester.tap(find.text('Suggest invoice'));
    await tester.pumpAndSettle();

    expect(
      find.text('The AI assistant is unavailable right now. '
          'No draft was created.'),
      findsOneWidget,
    );
    expect(find.text('Save draft'), findsNothing);
    expect(find.text('Confirm & Save'), findsNothing);
  });

  testWidgets('editing a draft shows the editable field and save action',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Financial summary'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edit draft'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Save draft'), findsOneWidget);
  });
}

class _FakeLiveContext implements AiLiveContext {
  @override
  Future<String> contextForQuery(String query) async => 'Test business context';
}

class _ThrowingAiProvider implements AiProvider {
  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    throw Exception('AI provider unavailable');
  }
}
