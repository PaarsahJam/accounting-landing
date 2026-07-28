import 'package:accounting_app/core/ai/ai_action.dart';
import 'package:accounting_app/core/ai/ai_action_gateway.dart';
import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockAuditTrailRepository auditRepo;
  late AiActionGateway gateway;

  setUp(() {
    auditRepo = MockAuditTrailRepository();
    gateway = AiActionGateway(
      auditRepository: auditRepo,
      performedBy: 'test-ai',
    );
  });

  group('checkAction safety gate', () {
    test('summarize does not require confirmation', () {
      final req = gateway.checkAction(AiActionType.summarize);
      expect(req.requiresConfirmation, isFalse);
    });

    test('suggestAction does not require confirmation', () {
      final req = gateway.checkAction(AiActionType.suggestAction);
      expect(req.requiresConfirmation, isFalse);
    });

    test('draftCreate requires confirmation', () {
      final req = gateway.checkAction(AiActionType.draftCreate);
      expect(req.requiresConfirmation, isTrue);
    });

    test('draftUpdate requires confirmation', () {
      final req = gateway.checkAction(AiActionType.draftUpdate);
      expect(req.requiresConfirmation, isTrue);
    });

    test('draftDelete requires confirmation', () {
      final req = gateway.checkAction(AiActionType.draftDelete);
      expect(req.requiresConfirmation, isTrue);
    });

    test('confirmation reason is provided for financial mutations', () {
      final req = gateway.checkAction(AiActionType.draftCreate);
      expect(req.requiresConfirmation, isTrue);
      expect(req.reason, isNotNull);
      expect(req.reason, contains('confirmation'));
    });
  });

  group('executeConfirmed audit logging', () {
    test('logs audit entry on success', () async {
      final confirmed = ConfirmedAction<String>(
        actionType: AiActionType.draftCreate,
        description: 'Create invoice for Acme Corp',
        action: _successAction.call,
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-TEST-001',
        entityLabel: 'Test Invoice',
      );

      final result = await gateway.executeConfirmed(confirmed);

      expect(result.isSuccess, isTrue);
      expect(result.data, equals('created'));

      final entries =
          (await auditRepo.fetchEntries()).data ?? [];
      final aiEntries = entries.where(
        (e) => e.action == AuditAction.created,
      );
      expect(aiEntries, isNotEmpty);
      expect(aiEntries.first.note, contains('AI-initiated'));
    });

    test('logs audit entry on action failure', () async {
      final confirmed = ConfirmedAction<String>(
        actionType: AiActionType.draftUpdate,
        description: 'Update vendor bill',
        action: _failureAction.call,
      );

      final result = await gateway.executeConfirmed(confirmed);

      expect(result.isSuccess, isFalse);
      expect(result.error, isNotNull);
    });

    test('logs audit entry on exception', () async {
      final confirmed = ConfirmedAction<String>(
        actionType: AiActionType.draftDelete,
        description: 'Delete obsolete record',
        action: _throwAction.call,
      );

      final result = await gateway.executeConfirmed(confirmed);

      expect(result.isSuccess, isFalse);
      expect(result.error, isA<UnknownFailure>());
      expect(result.error!.message, contains('failed'));
    });
  });
}

const _successAction = _SuccessAction();
const _failureAction = _FailureAction();
const _throwAction = _ThrowAction();

class _SuccessAction {
  const _SuccessAction();
  Future<AppResult<String>> call() async =>
      AppResult.success('created');
}

class _FailureAction {
  const _FailureAction();
  Future<AppResult<String>> call() async => AppResult.failure(
        ValidationFailure(message: 'Amount exceeds limit'),
      );
}

class _ThrowAction {
  const _ThrowAction();
  Future<AppResult<String>> call() async {
    throw Exception('network error');
  }
}
