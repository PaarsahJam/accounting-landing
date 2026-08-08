import '../../../l10n/app_localizations.dart';
import '../../guidance/presentation/guidance_tour_keys.dart';
import '../presentation/workflow_keys.dart';
import 'workflow_task.dart';

/// Stable identifiers for the built-in guided workflows.
abstract final class WorkflowTaskIds {
  WorkflowTaskIds._();

  static const createFirstInvoice = 'create-first-invoice';
  static const recordCustomerPayment = 'record-customer-payment';
  static const reviewWhoOwesMe = 'review-who-owes-me';

  static const all = [
    createFirstInvoice,
    recordCustomerPayment,
    reviewWhoOwesMe,
  ];
}

/// Builds the static workflow catalog from localized strings.
///
/// Content is written once per locale and never computed at runtime; the
/// copilot is fully rule-based with no AI dependency.
List<WorkflowTask> buildWorkflowTasks(AppLocalizations l10n) => [
      WorkflowTask(
        id: WorkflowTaskIds.createFirstInvoice,
        title: l10n.workflowCreateInvoiceTaskTitle,
        description: l10n.workflowCreateInvoiceTaskDescription,
        steps: [
          WorkflowStep(
            id: 'create-invoice-visit',
            title: l10n.workflowCreateInvoiceStep1Title,
            body: l10n.workflowCreateInvoiceStep1Body,
            route: '/sales-invoices',
            targetKey: GuidanceTourKeys.salesInvoicesHeader,
          ),
          WorkflowStep(
            id: 'create-invoice-add',
            title: l10n.workflowCreateInvoiceStep2Title,
            body: l10n.workflowCreateInvoiceStep2Body,
            route: '/sales-invoices',
            targetKey: WorkflowKeys.salesInvoicesAddButton,
          ),
          WorkflowStep(
            id: 'create-invoice-confirm',
            title: l10n.workflowCreateInvoiceStep3Title,
            body: l10n.workflowCreateInvoiceStep3Body,
            route: '/dashboard',
            targetKey: GuidanceTourKeys.metricAccountsReceivable,
          ),
        ],
      ),
      WorkflowTask(
        id: WorkflowTaskIds.recordCustomerPayment,
        title: l10n.workflowRecordPaymentTaskTitle,
        description: l10n.workflowRecordPaymentTaskDescription,
        steps: [
          WorkflowStep(
            id: 'record-payment-visit',
            title: l10n.workflowRecordPaymentStep1Title,
            body: l10n.workflowRecordPaymentStep1Body,
            route: '/customer-payments',
            targetKey: GuidanceTourKeys.customerPaymentsHeader,
          ),
          WorkflowStep(
            id: 'record-payment-add',
            title: l10n.workflowRecordPaymentStep2Title,
            body: l10n.workflowRecordPaymentStep2Body,
            route: '/customer-payments',
            targetKey: WorkflowKeys.customerPaymentsAddButton,
          ),
          WorkflowStep(
            id: 'record-payment-confirm',
            title: l10n.workflowRecordPaymentStep3Title,
            body: l10n.workflowRecordPaymentStep3Body,
            route: '/dashboard',
            targetKey: GuidanceTourKeys.metricAccountsReceivable,
          ),
        ],
      ),
      WorkflowTask(
        id: WorkflowTaskIds.reviewWhoOwesMe,
        title: l10n.workflowReviewReceivablesTaskTitle,
        description: l10n.workflowReviewReceivablesTaskDescription,
        steps: [
          WorkflowStep(
            id: 'review-receivables-reports',
            title: l10n.workflowReviewReceivablesStep1Title,
            body: l10n.workflowReviewReceivablesStep1Body,
            route: '/reports',
            targetKey: WorkflowKeys.financialReportsHeader,
          ),
          WorkflowStep(
            id: 'review-receivables-summary',
            title: l10n.workflowReviewReceivablesStep2Title,
            body: l10n.workflowReviewReceivablesStep2Body,
            route: '/dashboard',
            targetKey: GuidanceTourKeys.metricAccountsReceivable,
          ),
        ],
      ),
    ];

/// Returns the task with [id], or null when it is not in the catalog.
WorkflowTask? workflowTaskById(AppLocalizations l10n, String id) {
  for (final task in buildWorkflowTasks(l10n)) {
    if (task.id == id) return task;
  }
  return null;
}

/// Returns the index of the first step in [task] that has not been completed,
/// or [task.steps.length] when every step is complete.
int firstIncompleteIndex(WorkflowTask task, Set<String> completedStepIds) {
  for (var i = 0; i < task.steps.length; i++) {
    if (!completedStepIds.contains(task.steps[i].id)) return i;
  }
  return task.steps.length;
}

/// Returns the step the copilot should present right now: the first
/// incomplete step of [task], but only when it lives on [location].
///
/// Returns null when there is nothing to present — the task is finished, the
/// active step belongs to a different route, or [task] is null.
WorkflowStep? workflowStepToPresent(
  WorkflowTask? task,
  Set<String> completedStepIds,
  String location,
) {
  if (task == null) return null;
  final step = task.stepAt(firstIncompleteIndex(task, completedStepIds));
  if (step == null || step.route != location) return null;
  return step;
}
