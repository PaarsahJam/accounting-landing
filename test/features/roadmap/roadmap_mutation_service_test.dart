import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/core/finance/journal_entry.dart';
import 'package:accounting_app/core/finance/ledger_repository.dart';
import 'package:accounting_app/core/finance/ledger_service.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/roadmap/data/roadmap_repository.dart';
import 'package:accounting_app/features/roadmap/domain/models/financial_impact.dart';
import 'package:accounting_app/features/roadmap/domain/models/roadmap_action.dart';
import 'package:accounting_app/features/roadmap/domain/models/roadmap_item.dart';
import 'package:accounting_app/features/roadmap/domain/models/roadmap_mutation.dart';
import 'package:accounting_app/features/roadmap/domain/roadmap_mutation_request.dart';
import 'package:accounting_app/features/roadmap/domain/roadmap_mutation_service.dart';

class MockLedgerService extends LedgerService {
  MockLedgerService() : super(MockLedgerRepository());

  @override
  Future<void> postEntry(JournalEntry entry) async {
    await super.postEntry(entry);
  }
}

class MockAuditTrailRepository implements AuditTrailRepository {
  final List<AuditEntry> entries = [];

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntries({
    dynamic filter,
    String? companyId,
  }) async => AppResult.success([]);

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForEntity(
    dynamic entityType,
    String entityId, {
    String? companyId,
  }) async => AppResult.success([]);

  @override
  Future<AppResult<List<AuditEntry>>> fetchEntriesForCompany(
    String companyId, {
    dynamic filter,
  }) async => AppResult.success([]);

  @override
  Future<AppResult<AuditEntry>> addEntry(AuditEntry entry) async {
    entries.add(entry);
    return AppResult.success(entry);
  }
}

class MockRoadmapRepository implements RoadmapRepository {
  final List<RoadmapItem> items = [];

  @override
  Future<AppResult<List<RoadmapItem>>> fetchItems() async =>
      AppResult.success(List.unmodifiable(items));

  @override
  Future<AppResult<RoadmapItem?>> getItemById(String id) async {
    final matches = items.where((e) => e.id == id);
    final item = matches.isEmpty ? null : matches.first;
    return AppResult.success(item);
  }

  @override
  Future<AppResult<void>> saveItem(RoadmapItem item) async {
    final index = items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      items[index] = item;
    } else {
      items.add(item);
    }
    return AppResult.success(null);
  }

  @override
  Future<AppResult<void>> deleteItem(String id) async {
    items.removeWhere((e) => e.id == id);
    return AppResult.success(null);
  }
}

void main() {
  group('RoadmapMutationService - preview', () {
    test('returns preview with warnings for empty financial impacts', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-1',
        title: 'Test Item',
        description: 'A test roadmap item',
        status: RoadmapStatus.draft,
        actions: [],
        financialImpacts: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final result = service.preview(item);
      expect(result.isSuccess, isTrue);
      final preview = result.data!;
      expect(preview.warnings, anyElement(contains('no financial impact')));
      expect(preview.risks, isEmpty);
      expect(preview.isBalanced, isTrue);
      expect(preview.canCommit, isTrue);
    });

    test('returns warnings for imbalanced financial impacts', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-2',
        title: 'Imbalanced Item',
        description: 'An item with imbalance',
        status: RoadmapStatus.draft,
        actions: [],
        financialImpacts: [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 0.0,
            currency: 'USD',
            description: 'Debit only',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final result = service.preview(item);
      expect(result.isSuccess, isTrue);
      final preview = result.data!;
      expect(preview.isBalanced, isFalse);
      expect(preview.warnings, anyElement(contains('imbalance')));
      expect(preview.canCommit, isFalse);
    });

    test('marks destructive actions as requiring confirmation', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-3',
        title: 'Destructive Item',
        description: 'An item with destructive actions',
        status: RoadmapStatus.draft,
        actions: [
          RoadmapAction(
            id: 'RA-1',
            label: 'Delete Account',
            type: RoadmapActionType.delete,
            targetAccountIds: const ['1'],
            requiresConfirmation: true,
          ),
        ],
        financialImpacts: [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 1000.0,
            currency: 'USD',
            description: 'Balanced entry',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final result = service.preview(item);
      expect(result.isSuccess, isTrue);
      final preview = result.data!;
      expect(preview.risks, anyElement(contains('destructive')));
      expect(preview.requiresConfirmation, isTrue);
      expect(preview.canCommit, isFalse);
    });

    test('balanced item with no destructive actions can commit directly', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-4',
        title: 'Balanced Item',
        description: 'A balanced item',
        status: RoadmapStatus.draft,
        actions: [
          RoadmapAction(
            id: 'RA-2',
            label: 'Create Entry',
            type: RoadmapActionType.create,
            targetAccountIds: const ['1'],
            requiresConfirmation: false,
          ),
        ],
        financialImpacts: [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 500.0,
            creditAmount: 500.0,
            currency: 'USD',
            description: 'Balanced entry',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final result = service.preview(item);
      expect(result.isSuccess, isTrue);
      final preview = result.data!;
      expect(preview.isBalanced, isTrue);
      expect(preview.requiresConfirmation, isFalse);
      expect(preview.canCommit, isTrue);
    });
  });

  group('RoadmapMutationService - commit', () {
    test('commits a balanced mutation and records audit', () async {
      final auditRepo = MockAuditTrailRepository();
      final roadmapRepo = MockRoadmapRepository();
      final ledgerRepo = MockLedgerRepository();
      final ledgerService = LedgerService(ledgerRepo);

      final service = RoadmapMutationService(
        ledgerService: ledgerService,
        auditRepository: auditRepo,
        roadmapRepository: roadmapRepo,
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-5',
        title: 'Commit Item',
        description: 'An item to commit',
        status: RoadmapStatus.approved,
        actions: const [
          RoadmapAction(
            id: 'RA-3',
            label: 'Post Entry',
            type: RoadmapActionType.create,
            targetAccountIds: const ['1', '4'],
            requiresConfirmation: false,
          ),
        ],
        financialImpacts: [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 0.0,
            currency: 'USD',
            description: 'Cash received',
          ),
          FinancialImpact(
            accountId: '4',
            accountCode: '4000',
            accountName: 'Revenue',
            debitAmount: 0.0,
            creditAmount: 1000.0,
            currency: 'USD',
            description: 'Revenue earned',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      roadmapRepo.items.add(item);

      final request = RoadmapMutationRequest(
        item: item,
        mutation: RoadmapMutation(
          id: 'MUT-1',
          roadmapItemId: item.id,
          roadmapItemTitle: item.title,
          impacts: item.financialImpacts,
          actions: item.actions,
          kind: MutationKind.posting,
          plannedDate: DateTime.now(),
          performedBy: 'test_user',
        ),
        isDestructive: false,
        isPosting: true,
        confirmationToken: 'CONFIRM-valid-token',
        requestedBy: 'test_user',
      );

      final result = await service.commit(request);
      expect(result.isSuccess, isTrue);
      // Only the committed entry should be written — no spurious preview entry.
      expect(auditRepo.entries.length, 1);
      expect(auditRepo.entries.first.action, AuditAction.roadmapMutationCommitted);
    });

    test('rejects unbalanced mutation', () async {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-6',
        title: 'Unbalanced Item',
        description: 'An unbalanced item',
        status: RoadmapStatus.draft,
        actions: const [],
        financialImpacts: [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 0.0,
            currency: 'USD',
            description: 'Debit only',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final request = RoadmapMutationRequest(
        item: item,
        mutation: RoadmapMutation(
          id: 'MUT-2',
          roadmapItemId: item.id,
          roadmapItemTitle: item.title,
          impacts: item.financialImpacts,
          actions: item.actions,
          kind: MutationKind.adjustment,
          plannedDate: DateTime.now(),
          performedBy: 'test_user',
        ),
        isDestructive: false,
        isPosting: false,
        confirmationToken: 'CONFIRM-valid-token',
        requestedBy: 'test_user',
      );

      final result = await service.commit(request);
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
    });

    test('rejects destructive action without confirmation token', () async {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-7',
        title: 'Destructive Item',
        description: 'An item requiring confirmation',
        status: RoadmapStatus.draft,
        actions: const [
          RoadmapAction(
            id: 'RA-4',
            label: 'Delete',
            type: RoadmapActionType.delete,
            targetAccountIds: const ['1'],
            requiresConfirmation: true,
          ),
        ],
        financialImpacts: const [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 1000.0,
            currency: 'USD',
            description: 'Balanced',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: true,
      );

      final request = RoadmapMutationRequest(
        item: item,
        mutation: RoadmapMutation(
          id: 'MUT-3',
          roadmapItemId: item.id,
          roadmapItemTitle: item.title,
          impacts: item.financialImpacts,
          actions: item.actions,
          kind: MutationKind.adjustment,
          plannedDate: DateTime.now(),
          performedBy: 'test_user',
        ),
        isDestructive: true,
        isPosting: false,
        confirmationToken: 'INVALID-token',
        requestedBy: 'test_user',
      );

      final result = await service.commit(request);
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
    });

    test('rejects posting action without confirmation token', () async {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-8',
        title: 'Posting Item',
        description: 'An item requiring confirmation for posting',
        status: RoadmapStatus.draft,
        actions: const [],
        financialImpacts: const [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 1000.0,
            creditAmount: 1000.0,
            currency: 'USD',
            description: 'Balanced',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      final request = RoadmapMutationRequest(
        item: item,
        mutation: RoadmapMutation(
          id: 'MUT-4',
          roadmapItemId: item.id,
          roadmapItemTitle: item.title,
          impacts: item.financialImpacts,
          actions: item.actions,
          kind: MutationKind.posting,
          plannedDate: DateTime.now(),
          performedBy: 'test_user',
        ),
        isDestructive: false,
        isPosting: true,
        confirmationToken: 'no-prefix',
        requestedBy: 'test_user',
      );

      final result = await service.commit(request);
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
    });
  });

  group('RoadmapMutationService - confirmDestructiveAction', () {
    test('accepts a valid confirmation token', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-9',
        title: 'Destructive Item',
        description: 'Test',
        status: RoadmapStatus.draft,
        actions: const [],
        financialImpacts: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: true,
      );

      final result = service.confirmDestructiveAction(item, 'CONFIRM-abc123');
      expect(result.isSuccess, isTrue);
    });

    test('rejects an invalid confirmation token', () {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-10',
        title: 'Destructive Item',
        description: 'Test',
        status: RoadmapStatus.draft,
        actions: const [],
        financialImpacts: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: true,
      );

      final result = service.confirmDestructiveAction(item, 'invalid-token');
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
    });
  });

  group('RoadmapMutationService - previewMutation', () {
    test('returns preview mutation for existing roadmap item', () async {
      final roadmapRepo = MockRoadmapRepository();
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: roadmapRepo,
        performedBy: 'test_user',
      );

      final item = RoadmapItem(
        id: 'RI-11',
        title: 'Preview Item',
        description: 'For preview',
        status: RoadmapStatus.draft,
        actions: const [],
        financialImpacts: const [
          FinancialImpact(
            accountId: '1',
            accountCode: '1000',
            accountName: 'Cash',
            debitAmount: 500.0,
            creditAmount: 500.0,
            currency: 'USD',
            description: 'Balanced',
          ),
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        requiresConfirmation: false,
      );

      roadmapRepo.items.add(item);

      final result = await service.previewMutation('RI-11');
      expect(result.isSuccess, isTrue);
      expect(result.data!.roadmapItemId, 'RI-11');
      expect(result.data!.isBalanced, isTrue);
    });

    test('returns failure for non-existent roadmap item', () async {
      final service = RoadmapMutationService(
        ledgerService: MockLedgerService(),
        auditRepository: MockAuditTrailRepository(),
        roadmapRepository: MockRoadmapRepository(),
        performedBy: 'test_user',
      );

      final result = await service.previewMutation('nonexistent');
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
    });
  });
}