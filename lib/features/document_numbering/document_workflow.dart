// lib/features/document_numbering/document_workflow.dart

import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';

import 'document_status.dart';

/// Enforces the approval workflow transition rules.
class DocumentWorkflow {
  const DocumentWorkflow();

  /// Attempts to transition [current] to [target].
  ///
  /// Returns [AppResult.success] with [target] when the transition is allowed,
  /// or [AppResult.failure] with a [ValidationFailure] otherwise.
  AppResult<DocumentStatus> transition(
    DocumentStatus current,
    DocumentStatus target,
  ) {
    if (current.canTransitionTo(target)) {
      return AppResult.success(target);
    }
    return AppResult.failure(
      ValidationFailure(
        message:
            'Invalid transition: cannot move from ${current.label} to ${target.label}.',
      ),
    );
  }
}
