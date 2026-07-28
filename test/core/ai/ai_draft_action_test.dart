import 'package:accounting_app/core/ai/ai_action.dart';
import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_context_collector.dart';
import 'package:accounting_app/core/ai/providers/fake_ai_provider.dart';
import 'package:accounting_app/core/ai/use_cases/ai_draft_action.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeAiProvider aiProvider;
  late AiActionGateway gateway;
  late AiDraftAction draftAction;

  setUp(() {
    aiProvider = FakeAiProvider();
    gateway = AiActionGateway(
      auditRepository: MockAuditTrailRepository(),
      performedBy: 'test-ai',
    );
    draftAction = AiDraftAction(
      aiProvider: aiProvider,
      gateway: gateway,
    );
  });

  group('draft action suggestion', () {
    test('summarize type does not include confirmation requirement', () async {
      final result = await draftAction.draft(
        actionType: AiActionType.summarize,
        entityContext: 'Customer: Acme Corp, Balance: 15000',
      );

      expect(result.suggestion, isNotEmpty);
      expect(result.confirmationRequirement, isNull);
    });

    test('suggestAction type does not include confirmation requirement', () async {
      final result = await draftAction.draft(
        actionType: AiActionType.suggestAction,
        entityContext: 'Invoice SI-001 is overdue',
      );

      expect(result.suggestion, isNotEmpty);
      expect(result.confirmationRequirement, isNull);
    });

    test('draftCreate includes confirmation requirement', () async {
      final result = await draftAction.draft(
        actionType: AiActionType.draftCreate,
        entityContext: 'Proposal for new customer record',
      );

      expect(result.suggestion, isNotEmpty);
      expect(result.confirmationRequirement, isNotNull);
      expect(result.confirmationRequirement!.requiresConfirmation, isTrue);
    });

    test('draftUpdate includes confirmation requirement', () async {
      final result = await draftAction.draft(
        actionType: AiActionType.draftUpdate,
        entityContext: 'Existing invoice with incorrect amount',
      );

      expect(result.suggestion, isNotEmpty);
      expect(result.confirmationRequirement, isNotNull);
      expect(result.confirmationRequirement!.requiresConfirmation, isTrue);
    });

    test('draftDelete includes confirmation requirement', () async {
      final result = await draftAction.draft(
        actionType: AiActionType.draftDelete,
        entityContext: 'Obsolete vendor record',
      );

      expect(result.suggestion, isNotEmpty);
      expect(result.confirmationRequirement, isNotNull);
      expect(result.confirmationRequirement!.requiresConfirmation, isTrue);
    });
  });

  group('createConfirmedAction', () {
    test('builds ConfirmedAction with correct fields', () async {
      final confirmed = draftAction.createConfirmedAction(
        actionType: AiActionType.draftCreate,
        suggestionText: 'Create new customer: TechStart Inc.',
        action: () async => AppResult.success('done'),
        entityType: AuditEntityType.customer,
        entityId: 'CUST-NEW',
        entityLabel: 'TechStart Inc.',
      );

      expect(confirmed.actionType, equals(AiActionType.draftCreate));
      expect(confirmed.description, contains('TechStart'));
      expect(confirmed.entityType, equals(AuditEntityType.customer));
      expect(confirmed.entityId, equals('CUST-NEW'));
      expect(confirmed.entityLabel, equals('TechStart Inc.'));
    });

    test('truncates long description', () async {
      final longText = 'A' * 200;
      final confirmed = draftAction.createConfirmedAction(
        actionType: AiActionType.draftUpdate,
        suggestionText: longText,
        action: () async => AppResult.success('done'),
      );

      expect(confirmed.description.length, equals(120));
      expect(confirmed.description.endsWith('...'), isTrue);
    });

    test('executed confirmed action succeeds', () async {
      final confirmed = draftAction.createConfirmedAction(
        actionType: AiActionType.draftCreate,
        suggestionText: 'Create test record',
        action: () async => AppResult.success('created'),
      );

      final result = await gateway.executeConfirmed(confirmed);
      expect(result.isSuccess, isTrue);
      expect(result.data, equals('created'));
    });
  });

  group('context collector', () {
    test('customerContext produces structured output', () {
      final collector = AiContextCollector();
      final context = collector.customerContext(
        id: 'CUST-001',
        name: 'Test Company',
        company: 'Test Ltd.',
        email: 'test@test.com',
        phone: '123',
        outstandingBalance: 5000,
        status: 'active',
      );

      expect(context, contains('Test Company'));
      expect(context, contains('5000'));
      expect(context, contains('active'));
    });

    test('invoiceContext produces structured output with line items', () {
      final collector = AiContextCollector();
      final context = collector.invoiceContext(
        id: 'INV-001',
        customerName: 'Client A',
        reference: 'REF-001',
        title: 'Services',
        subtotal: 1000,
        tax: 100,
        total: 1100,
        statusLabel: 'Draft',
        invoiceDate: '2026-01-01',
        dueDate: '2026-01-31',
        lines: [
          {'description': 'Item 1', 'quantity': 2, 'unitPrice': 500},
        ],
      );

      expect(context, contains('Client A'));
      expect(context, contains('1100'));
      expect(context, contains('Item 1'));
    });

    test('journalContext produces structured output', () {
      final collector = AiContextCollector();
      final context = collector.journalContext(
        journalNumber: 'JV-001',
        postingDate: '2026-01-15',
        totalDebit: 2000,
        totalCredit: 2000,
      );

      expect(context, contains('JV-001'));
      expect(context, contains('2000'));
    });
  });
}
