import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository.dart';
import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository_provider.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_reconciliation_detail_controller.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_statement_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BankReconciliationDetailController', () {
    late ProviderContainer container;
    const statementId = 'BS-2024-03-001';

    setUp(() {
      container = ProviderContainer(
        overrides: [
          bankStatementRepositoryProvider.overrideWithValue(
            MockBankStatementRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads statement detail successfully', () async {
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      final detail = await controller.future;
      expect(detail.statement.id, equals(statementId));
      expect(detail.statement.transactions, isNotEmpty);
    });

    test('difference is computed from statement data', () async {
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      final detail = await controller.future;
      // Difference is a finite number
      expect(detail.difference.isFinite, isTrue);
    });

    test('matchTransaction updates matched status', () async {
      container.listen(
        bankReconciliationDetailControllerProvider(statementId),
        (_, _) {},
      );
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      await controller.future;
      await controller.matchTransaction(
        transactionId: 'BST-003',
        erpEntryId: 'ERP-TEST',
        erpEntryLabel: 'Test ERP entry',
      );
      final state = container
          .read(bankReconciliationDetailControllerProvider(statementId))
          .value!;
      final txn = state.statement.transactions.firstWhere(
        (t) => t.id == 'BST-003',
      );
      expect(txn.isMatched, isTrue);
    });

    test('unmatchTransaction clears match', () async {
      container.listen(
        bankReconciliationDetailControllerProvider(statementId),
        (_, _) {},
      );
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      await controller.future;
      await controller.unmatchTransaction('BST-001');
      final state = container
          .read(bankReconciliationDetailControllerProvider(statementId))
          .value!;
      final txn = state.statement.transactions.firstWhere(
        (t) => t.id == 'BST-001',
      );
      expect(txn.isMatched, isFalse);
      expect(txn.matchedErpEntryId, isNull);
    });

    test('autoMatch matches all non-UNKNOWN transactions', () async {
      container.listen(
        bankReconciliationDetailControllerProvider(statementId),
        (_, _) {},
      );
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      await controller.future;
      await controller.autoMatch();
      final state = container
          .read(bankReconciliationDetailControllerProvider(statementId))
          .value!;
      final nonUnknown = state.statement.transactions.where(
        (t) => !t.reference.startsWith('UNKNOWN'),
      );
      for (final txn in nonUnknown) {
        expect(txn.isMatched, isTrue);
      }
    });

    test('finalizeStatement sets status to reconciled', () async {
      container.listen(
        bankReconciliationDetailControllerProvider(statementId),
        (_, _) {},
      );
      final controller = container.read(
        bankReconciliationDetailControllerProvider(statementId).notifier,
      );
      await controller.future;
      await controller.finalizeStatement();
      final state = container
          .read(bankReconciliationDetailControllerProvider(statementId))
          .value!;
      expect(state.statement.status, equals(BankStatementStatus.reconciled));
    });

    test('canFinalize is false for reconciled statement', () async {
      final controller = container.read(
        bankReconciliationDetailControllerProvider(
          'BS-2024-02-001', // already reconciled
        ).notifier,
      );
      final detail = await controller.future;
      expect(detail.canFinalize, isFalse);
    });

    test('error state returned for unknown statement id', () async {
      container.listen(
        bankReconciliationDetailControllerProvider('UNKNOWN'),
        (_, _) {},
      );
      final controller = container.read(
        bankReconciliationDetailControllerProvider('UNKNOWN').notifier,
      );
      await expectLater(controller.future, throwsA(isA<Object>()));
    });
  });
}
