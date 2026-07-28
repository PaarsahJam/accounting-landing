import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/ai/ai_context_collector.dart';
import 'package:accounting_app/core/ai/providers/fake_ai_provider.dart';
import 'package:accounting_app/core/ai/use_cases/ai_summarize.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeAiProvider aiProvider;
  late AiActionGateway gateway;
  late AiContextCollector contextCollector;
  late AiSummarize summarize;

  setUp(() {
    aiProvider = FakeAiProvider();
    gateway = AiActionGateway(
      auditRepository: MockAuditTrailRepository(),
      performedBy: 'test-ai',
    );
    contextCollector = AiContextCollector();
    summarize = AiSummarize(
      aiProvider: aiProvider,
      gateway: gateway,
    );
  });

  group('summarize', () {
    test('returns a summary for customer context', () async {
      final context = contextCollector.customerContext(
        id: 'CUST-001',
        name: 'Acme Corp',
        company: 'Acme Inc.',
        email: 'acme@example.com',
        phone: '+1-555-0100',
        outstandingBalance: 15000.0,
        status: 'active',
        notes: 'Key client',
      );

      final result = await summarize.summarize(entityContext: context);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
    });

    test('returns a summary for invoice context', () async {
      final context = contextCollector.invoiceContext(
        id: 'SI-2026-000001',
        customerName: 'Acme Corp',
        reference: 'INV-001',
        title: 'Consulting Services',
        notes: 'Monthly retainer',
        subtotal: 10000.0,
        tax: 1000.0,
        total: 11000.0,
        statusLabel: 'Posted',
        invoiceDate: '2026-01-15',
        dueDate: '2026-02-14',
        lines: [
          {'description': 'Consulting', 'quantity': 10, 'unitPrice': 1000},
        ],
      );

      final result = await summarize.summarize(entityContext: context);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
    });

    test('uses custom ai provider response when set', () async {
      aiProvider.response = 'Custom summary response';

      final result = await summarize.summarize(
        entityContext: 'Test record context',
      );

      expect(result, equals('Custom summary response'));
    });

    test('returns a summary for journal context', () async {
      final context = contextCollector.journalContext(
        journalNumber: 'JV-2026-000001',
        postingDate: '2026-01-20',
        narration: 'Monthly accrual',
        totalDebit: 5000.0,
        totalCredit: 5000.0,
        postingStatus: 'Posted',
      );

      final result = await summarize.summarize(entityContext: context);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
    });
  });
}
