import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_provider.dart';
import 'package:accounting_app/core/ai/ai_providers.dart';
import 'package:accounting_app/core/ai/use_cases/ai_summarize.dart';
import 'package:accounting_app/features/ai_assistant/presentation/ai_assistant_page.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      aiSummarizeProvider.overrideWithValue(
        AiSummarize(
          aiProvider: _FakeAiProvider(),
          gateway: AiActionGateway(
            auditRepository: MockAuditTrailRepository(),
            performedBy: 'test',
          ),
        ),
      ),
    ],
    child: const MaterialApp(
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
      find.text('Ask a question or request a suggestion.'),
      findsOneWidget,
    );
    expect(
      find.byType(TextField),
      findsOneWidget,
    );
  });
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
