import 'package:accounting_app/features/workflows/domain/workflow_progress.dart';
import 'package:accounting_app/features/workflows/workflow_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('encodeWorkflowProgress / decodeWorkflowProgress', () {
    test('empty progress round-trips', () {
      expect(
        decodeWorkflowProgress(encodeWorkflowProgress(WorkflowProgress.empty)),
        WorkflowProgress.empty,
      );
    });

    test('active progress round-trips with sorted step ids', () {
      const progress = WorkflowProgress(
        activeTaskId: 'create-first-invoice',
        completedStepIds: {'create-invoice-add', 'create-invoice-visit'},
        finishedTaskIds: {'review-who-owes-me'},
      );

      final raw = encodeWorkflowProgress(progress);
      expect(raw, contains('create-invoice-add'));
      expect(raw, contains('create-invoice-visit'));
      // Step ids are stored sorted for deterministic persistence
      // ('create-invoice-add' < 'create-invoice-visit').
      expect(
        raw.indexOf('create-invoice-add'),
        lessThan(raw.indexOf('create-invoice-visit')),
      );

      final decoded = decodeWorkflowProgress(raw);
      expect(decoded.activeTaskId, 'create-first-invoice');
      expect(decoded.completedStepIds, {
        'create-invoice-add',
        'create-invoice-visit',
      });
      expect(decoded.finishedTaskIds, {'review-who-owes-me'});
    });

    test('decoding garbage returns empty progress', () {
      expect(decodeWorkflowProgress('not json'), WorkflowProgress.empty);
    });

    test('decoding null or empty returns empty progress', () {
      expect(decodeWorkflowProgress(null), WorkflowProgress.empty);
      expect(decodeWorkflowProgress(''), WorkflowProgress.empty);
    });
  });

  group('WorkflowProgressNotifier', () {
    test('starts a task as active with fresh progress', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.start('create-first-invoice');

      final state = container.read(workflowProgressProvider);
      expect(state.activeTaskId, 'create-first-invoice');
      expect(state.completedStepIds, isEmpty);
      expect(state.isActive, isTrue);
    });

    test('markStepComplete records completed steps and is idempotent', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.start('create-first-invoice');
      await notifier.markStepComplete('create-invoice-visit');
      await notifier.markStepComplete('create-invoice-visit');
      await notifier.markStepComplete('create-invoice-add');

      final state = container.read(workflowProgressProvider);
      expect(state.completedStepIds, {
        'create-invoice-visit',
        'create-invoice-add',
      });
    });

    test('markStepComplete is ignored without an active task', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.markStepComplete('create-invoice-visit');

      expect(container.read(workflowProgressProvider).completedStepIds, isEmpty);
    });

    test('finishTask clears the active slot and records the task', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.start('create-first-invoice');
      await notifier.markStepComplete('create-invoice-visit');
      await notifier.finishTask();

      final state = container.read(workflowProgressProvider);
      expect(state.activeTaskId, isNull);
      expect(state.isActive, isFalse);
      expect(state.finishedTaskIds, {'create-first-invoice'});
      expect(state.completedStepIds, isEmpty);
    });

    test('finishTask without an active task is a no-op', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.finishTask();

      expect(container.read(workflowProgressProvider), WorkflowProgress.empty);
    });

    test('cancel discards step progress but keeps finished tasks', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.start('record-customer-payment');
      await notifier.markStepComplete('record-payment-visit');
      await notifier.finishTask();
      await notifier.start('create-first-invoice');
      await notifier.cancel();

      final state = container.read(workflowProgressProvider);
      expect(state.activeTaskId, isNull);
      expect(state.completedStepIds, isEmpty);
      expect(state.finishedTaskIds, {'record-customer-payment'});
    });

    test('reset clears everything', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(workflowProgressProvider.notifier);
      await notifier.start('create-first-invoice');
      await notifier.finishTask();
      await notifier.reset();

      expect(container.read(workflowProgressProvider), WorkflowProgress.empty);
    });
  });
}
