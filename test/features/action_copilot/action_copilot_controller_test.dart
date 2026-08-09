import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_live_context.dart';
import 'package:accounting_app/core/ai/ai_provider.dart';
import 'package:accounting_app/core/ai/ai_providers.dart';
import 'package:accounting_app/core/ai/providers/fake_ai_provider.dart';
import 'package:accounting_app/core/ai/use_cases/ai_draft_action.dart';
import 'package:accounting_app/core/ai/use_cases/ai_summarize.dart';
import 'package:accounting_app/features/action_copilot/action_copilot_provider.dart';
import 'package:accounting_app/features/action_copilot/domain/action_copilot_draft.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  ProviderContainer buildContainer({AiProvider? aiProvider}) {
    final provider = aiProvider ?? FakeAiProvider();
    return ProviderContainer(
      overrides: [
        salesInvoicesRepositoryProvider.overrideWithValue(
          MockSalesInvoicesRepository(),
        ),
        aiLiveContextProvider.overrideWithValue(
          _FakeLiveContext(),
        ),
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
    );
  }

  tearDown(() => container.dispose());

  group('ActionCopilotController', () {
    test('generates a draft and moves it to review', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      expect(container.read(actionCopilotControllerProvider), isNull);

      await controller.generate(CopilotDraftKind.financialSummary);

      final draft = container.read(actionCopilotControllerProvider);
      expect(draft, isNotNull);
      expect(draft!.status, CopilotDraftStatus.review);
      expect(draft.content, isNotEmpty);
    });

    test('save() refuses to run before confirmation', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.financialSummary);
      final result = await controller.save();

      expect(result.isSuccess, isFalse);
      expect(
        container.read(actionCopilotControllerProvider)!.status,
        CopilotDraftStatus.review,
      );
    });

    test('save() refuses to run when there is no draft', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      final result = await controller.save();

      expect(result.isSuccess, isFalse);
    });

    test('confirm() then save() succeeds for a read-only draft', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.financialSummary);
      controller.confirm();

      expect(
        container.read(actionCopilotControllerProvider)!.status,
        CopilotDraftStatus.confirming,
      );

      final result = await controller.save();

      expect(result.isSuccess, isTrue);
      expect(
        container.read(actionCopilotControllerProvider)!.status,
        CopilotDraftStatus.saved,
      );
      expect(
        container.read(actionCopilotControllerProvider)!.auditNote,
        isNotNull,
      );
    });

    test('financial invoice draft requires confirmation before saving', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.invoiceSuggestion);

      final draft = container.read(actionCopilotControllerProvider)!;
      expect(draft.requiresConfirmation, isTrue);

      final result = await controller.save();
      expect(result.isSuccess, isFalse);
    });

    test('confirmed invoice draft creates a sales invoice', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.invoiceSuggestion);
      controller.confirm();

      final result = await controller.save();

      expect(result.isSuccess, isTrue, reason: 'error: ${result.error?.message}');
      expect(
        container.read(actionCopilotControllerProvider)!.status,
        CopilotDraftStatus.saved,
      );
    });

    test('edit() keeps the draft editable and requires re-confirmation', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.financialSummary);
      controller.edit('Edited summary text');

      final edited = container.read(actionCopilotControllerProvider)!;
      expect(edited.status, CopilotDraftStatus.editing);
      expect(edited.content, 'Edited summary text');
      expect(edited.isConfirmable, isTrue);

      // Editing must not auto-commit; save still needs explicit confirm.
      final result = await controller.save();
      expect(result.isSuccess, isFalse);
    });

    test('discard() resets the draft to null', () async {
      container = buildContainer();
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.financialSummary);
      controller.discard();

      expect(container.read(actionCopilotControllerProvider), isNull);
    });

    test('AI unavailability lands in error without committing', () async {
      container = buildContainer(
        aiProvider: _ThrowingAiProvider(),
      );
      final controller =
          container.read(actionCopilotControllerProvider.notifier);

      await controller.generate(CopilotDraftKind.invoiceSuggestion);

      final draft = container.read(actionCopilotControllerProvider)!;
      expect(draft.status, CopilotDraftStatus.error);
      expect(draft.errorMessage, isNotNull);

      final result = await controller.save();
      expect(result.isSuccess, isFalse);
      expect(draft.auditNote, isNull);
    });
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
