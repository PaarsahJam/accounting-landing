import 'package:accounting_app/features/workflows/domain/workflow_definitions.dart';
import 'package:accounting_app/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn('en');

  group('buildWorkflowTasks', () {
    test('returns the three built-in tasks in stable order', () {
      final tasks = buildWorkflowTasks(l10n);

      expect(tasks.map((t) => t.id).toList(), WorkflowTaskIds.all);
      expect(tasks, hasLength(3));
    });

    test('every task has a title, description and non-empty steps', () {
      for (final task in buildWorkflowTasks(l10n)) {
        expect(task.title, isNotEmpty);
        expect(task.description, isNotEmpty);
        expect(task.steps, isNotEmpty);
        for (final step in task.steps) {
          expect(step.title, isNotEmpty);
          expect(step.body, isNotEmpty);
          expect(step.route, isNotEmpty);
        }
      }
    });

    test('step ids are unique and routes are known modules', () {
      const knownRoutes = ['/dashboard', '/sales-invoices', '/customer-payments', '/reports'];
      final seen = <String>{};

      for (final task in buildWorkflowTasks(l10n)) {
        for (final step in task.steps) {
          expect(seen.add(step.id), isTrue, reason: 'duplicate id ${step.id}');
          expect(knownRoutes, contains(step.route));
        }
      }
    });
  });

  group('workflowTaskById', () {
    test('returns the matching task', () {
      final task = workflowTaskById(l10n, WorkflowTaskIds.createFirstInvoice);

      expect(task?.id, WorkflowTaskIds.createFirstInvoice);
      expect(task?.steps, hasLength(3));
    });

    test('returns null for an unknown id', () {
      expect(workflowTaskById(l10n, 'nope'), isNull);
    });
  });

  group('firstIncompleteIndex', () {
    final task = buildWorkflowTasks(l10n).first;
    final first = task.steps.first.id;

    test('starts at 0 with nothing completed', () {
      expect(firstIncompleteIndex(task, const {}), 0);
    });

    test('skips completed steps', () {
      expect(firstIncompleteIndex(task, {first}), 1);
    });

    test('returns the length when everything is complete', () {
      final all = task.steps.map((s) => s.id).toSet();
      expect(firstIncompleteIndex(task, all), task.steps.length);
    });
  });

  group('workflowStepToPresent', () {
    final task = buildWorkflowTasks(l10n).first;

    test('returns null for a null task', () {
      expect(workflowStepToPresent(null, const {}, '/sales-invoices'), isNull);
    });

    test('returns null when every step is complete', () {
      final all = task.steps.map((s) => s.id).toSet();
      expect(workflowStepToPresent(task, all, '/sales-invoices'), isNull);
    });

    test('returns null when the next step lives on another route', () {
      expect(workflowStepToPresent(task, const {}, '/dashboard'), isNull);
    });

    test('returns the next incomplete step on the matching route', () {
      final step = workflowStepToPresent(task, const {}, '/sales-invoices');
      expect(step?.id, 'create-invoice-visit');
    });

    test('advances past completed steps', () {
      final step = workflowStepToPresent(
        task,
        const {'create-invoice-visit'},
        '/sales-invoices',
      );
      expect(step?.id, 'create-invoice-add');
    });

    test('the second module of a task is found on its own route', () {
      final review = workflowTaskById(l10n, WorkflowTaskIds.reviewWhoOwesMe)!;
      final step = workflowStepToPresent(review, const {}, '/reports');
      expect(step?.id, 'review-receivables-reports');
    });
  });
}
