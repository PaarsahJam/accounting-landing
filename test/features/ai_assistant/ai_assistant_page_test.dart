import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_live_context.dart';
import 'package:accounting_app/core/ai/ai_provider.dart';
import 'package:accounting_app/core/ai/ai_providers.dart';
import 'package:accounting_app/core/ai/use_cases/ai_draft_action.dart';
import 'package:accounting_app/core/ai/use_cases/ai_summarize.dart';
import 'package:accounting_app/features/ai_assistant/presentation/ai_assistant_page.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      aiLiveContextProvider.overrideWithValue(
        _FakeLiveContextProvider(),
      ),
      aiSummarizeProvider.overrideWithValue(
        AiSummarize(
          aiProvider: _FakeAiProvider(),
          gateway: AiActionGateway(
            auditRepository: MockAuditTrailRepository(),
            performedBy: 'test',
          ),
        ),
      ),
      aiDraftActionProvider.overrideWithValue(
        AiDraftAction(
          aiProvider: _FakeAiProvider(),
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
        body: AiAssistantPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('AiAssistantPage renders title and input field', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('AI Assistant'), findsWidgets);
    expect(
      find.text('Ask about your business — revenue, cash, invoices, customers, '
          'or ask me to draft an action.'),
      findsOneWidget,
    );
    expect(
      find.byType(TextField),
      findsOneWidget,
    );
  });

  testWidgets('sends a question and shows the assistant answer', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'How is my business?');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('How is my business?'), findsOneWidget);
    expect(find.text('Fake summary'), findsWidgets);
  });

  testWidgets('action intent opens a confirmation dialog', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Create a new invoice');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Confirm AI Action'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('confirming the action logs it in the audit trail', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Create a new invoice');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm & Log'));
    await tester.pumpAndSettle();

    expect(
      find.text('AI action confirmed and recorded in the audit trail.'),
      findsOneWidget,
    );
  });
}

class _FakeLiveContextProvider implements AiLiveContext {
  @override
  Future<String> contextForQuery(String query) async => 'Test business context';
}

class _FakeAiProvider implements AiProvider {
  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    return 'Fake summary';
  }
}
