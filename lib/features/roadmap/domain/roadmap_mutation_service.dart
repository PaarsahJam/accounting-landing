import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/finance/ledger_service.dart';
import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/transaction_line.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../data/roadmap_repository.dart';
import 'models/roadmap_item.dart';
import 'models/roadmap_mutation.dart';
import 'roadmap_mutation_request.dart';
import 'roadmap_preview.dart';

class RoadmapMutationService {
  const RoadmapMutationService({
    required LedgerService ledgerService,
    required AuditTrailRepository auditRepository,
    required RoadmapRepository roadmapRepository,
    required String performedBy,
  })  : _ledger = ledgerService,
        _audit = auditRepository,
        _roadmap = roadmapRepository,
        _performedBy = performedBy;

  final LedgerService _ledger;
  final AuditTrailRepository _audit;
  final RoadmapRepository _roadmap;
  final String _performedBy;

  static const String _confirmationTokenPrefix = 'CONFIRM-';

  AppResult<RoadmapPreview> preview(RoadmapItem item) {
    try {
      final impacts = item.financialImpacts;
      final warnings = <String>[];
      final risks = <String>[];

      if (impacts.isEmpty) {
        warnings.add('This roadmap item has no financial impact.');
      }

      final totalDebit = impacts.fold<double>(0, (s, i) => s + i.debitAmount);
      final totalCredit = impacts.fold<double>(0, (s, i) => s + i.creditAmount);
      final imbalance = (totalDebit - totalCredit).abs();

      if (imbalance >= 0.005) {
        warnings.add(
          'Double-entry imbalance detected (difference: ${imbalance.toStringAsFixed(4)}).',
        );
      }

      for (final impact in impacts) {
        if (impact.isZero) {
          warnings.add(
            'Impact on ${impact.accountCode} (${impact.accountName}) has zero net amount.',
          );
        }
      }

      for (final action in item.actions) {
        if (action.isDestructive) {
          risks.add('Action "${action.label}" is destructive and requires confirmation.');
        }
      }

      if (item.isDestructive) {
        risks.add('This roadmap item contains destructive actions.');
      }

      final requiresConfirmation = item.requiresConfirmation || item.isDestructive;

      return AppResult.success(RoadmapPreview(
        item: item,
        impacts: impacts,
        isBalanced: imbalance < 0.005,
        warnings: warnings,
        risks: risks,
        requiresConfirmation: requiresConfirmation,
        canCommit: imbalance < 0.005 && !requiresConfirmation,
      ));
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }

  Future<AppResult<RoadmapMutation>> previewMutation(
    String roadmapItemId,
  ) async {
    final fetchResult = await _roadmap.getItemById(roadmapItemId);
    if (!fetchResult.isSuccess) {
      return AppResult.failure(fetchResult.error!);
    }
    final item = fetchResult.data;
    if (item == null) {
      return AppResult.failure(
        ValidationFailure(message: 'Roadmap item not found: $roadmapItemId'),
      );
    }
    return AppResult.success(RoadmapMutation(
      id: 'MUT-Preview-${item.id}',
      roadmapItemId: item.id,
      roadmapItemTitle: item.title,
      impacts: item.financialImpacts,
      actions: item.actions,
      kind: MutationKind.adjustment,
      plannedDate: DateTime.now(),
      performedBy: _performedBy,
    ));
  }

  Future<AppResult<RoadmapMutation>> commit(
    RoadmapMutationRequest request,
  ) async {
    final item = request.item;
    final mutation = request.mutation;

    // ── Guard: confirmation token required for destructive or posting actions.
    if (request.isDestructive && !request.confirmationToken.startsWith(_confirmationTokenPrefix)) {
      return AppResult.failure(
        ValidationFailure(
          message: 'Destructive action requires a valid confirmation token '
              '(must start with "$_confirmationTokenPrefix").',
        ),
      );
    }

    if (request.isPosting && !request.confirmationToken.startsWith(_confirmationTokenPrefix)) {
      return AppResult.failure(
        ValidationFailure(
          message: 'Posting action requires a valid confirmation token '
              '(must start with "$_confirmationTokenPrefix").',
        ),
      );
    }

    // ── Guard: double-entry balance must be satisfied before any I/O.
    if (!mutation.isBalanced) {
      return AppResult.failure(
        ValidationFailure(
          message: 'Cannot commit an unbalanced mutation. '
              'Total debit: ${mutation.totalDebit}, '
              'Total credit: ${mutation.totalCredit}.',
        ),
      );
    }

    // ── Post through LedgerService — validate() is called inside as a second
    //    guard.  Catch both the ArgumentError it throws for unbalanced entries
    //    and any unexpected error, converting both to AppResult failures so
    //    callers never see a raw exception across this boundary.
    try {
      await _ledger.postEntry(_buildJournalEntry(mutation));
    } on ArgumentError catch (e) {
      await _recordAudit(
        id: 'AUD-ROADMAP-REJECT-${mutation.id}',
        mutation: mutation,
        item: item,
        action: AuditAction.roadmapMutationRejected,
        note: 'Ledger rejected mutation ${mutation.id}: ${e.message}',
      );
      return AppResult.failure(
        ValidationFailure(message: e.message?.toString() ?? e.toString()),
      );
    } catch (e) {
      await _recordAudit(
        id: 'AUD-ROADMAP-REJECT-${mutation.id}',
        mutation: mutation,
        item: item,
        action: AuditAction.roadmapMutationRejected,
        note: 'Unexpected error posting mutation ${mutation.id}: $e',
      );
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }

    // ── Ledger post succeeded — record the committed audit entry.
    final auditResult = await _recordAudit(
      id: 'AUD-ROADMAP-COMMIT-${mutation.id}',
      mutation: mutation,
      item: item,
      action: AuditAction.roadmapMutationCommitted,
      note: 'Committed mutation ${mutation.id} for roadmap item ${item.id}',
    );
    if (!auditResult.isSuccess) {
      return AppResult.failure(
        UnknownFailure(message: 'Mutation committed but audit entry failed.'),
      );
    }

    return AppResult.success(mutation);
  }

  /// Writes a single audit entry and returns its [AppResult].
  Future<AppResult<AuditEntry>> _recordAudit({
    required String id,
    required RoadmapMutation mutation,
    required RoadmapItem item,
    required AuditAction action,
    required String note,
  }) {
    return _audit.addEntry(AuditEntry(
      id: id,
      entityType: AuditEntityType.roadmap,
      entityId: mutation.roadmapItemId,
      entityLabel: 'Roadmap Item ${item.title}',
      action: action,
      performedAt: DateTime.now(),
      performedBy: _performedBy,
      note: note,
      newValue: mutation.id,
    ));
  }

  AppResult<void> confirmDestructiveAction(
    RoadmapItem item,
    String confirmationToken,
  ) {
    if (!confirmationToken.startsWith(_confirmationTokenPrefix)) {
      return AppResult.failure(
        ValidationFailure(
          message: 'Invalid confirmation token. '
              'Must start with "$_confirmationTokenPrefix".',
        ),
      );
    }

    return AppResult.success(null);
  }

  JournalEntry _buildJournalEntry(RoadmapMutation mutation) {
    return JournalEntry(
      id: 'JV-${mutation.id}',
      date: mutation.plannedDate,
      reference: 'Roadmap-${mutation.roadmapItemId}',
      memo: 'Roadmap mutation: ${mutation.roadmapItemTitle}',
      lines: mutation.impacts.map((impact) {
        return TransactionLine(
          accountId: impact.accountId,
          amount: impact.netAmount,
          currency: impact.currency,
          description: impact.description,
        );
      }).toList(),
    );
  }
}