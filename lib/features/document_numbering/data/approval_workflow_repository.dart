// lib/features/document_numbering/data/approval_workflow_repository.dart

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../document_number_generator.dart';
import '../document_record.dart';
import '../document_status.dart';
import '../document_workflow.dart';

abstract class ApprovalWorkflowRepository {
  Future<AppResult<List<DocumentRecord>>> fetchDocuments();
  Future<AppResult<DocumentRecord>> fetchDocument(String id);
  Future<AppResult<DocumentRecord>> transition(
    String id,
    DocumentStatus target,
  );
}

class MockApprovalWorkflowRepository implements ApprovalWorkflowRepository {
  MockApprovalWorkflowRepository() {
    _seed();
  }

  final _workflow = const DocumentWorkflow();

  final List<DocumentRecord> _records = [];

  void _seed() {
    final now = DateTime(2026, 1, 15);
    _records.addAll([
      DocumentRecord(
        id: 'PO-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.purchaseOrder,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Purchase Order',
        status: DocumentStatus.approved,
        createdAt: now.subtract(const Duration(days: 10)),
        approvedAt: now.subtract(const Duration(days: 8)),
      ),
      DocumentRecord(
        id: 'GR-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.goodsReceipt,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Goods Receipt',
        status: DocumentStatus.posted,
        createdAt: now.subtract(const Duration(days: 7)),
        approvedAt: now.subtract(const Duration(days: 6)),
        postedAt: now.subtract(const Duration(days: 5)),
      ),
      DocumentRecord(
        id: 'VB-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.vendorBill,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Vendor Bill',
        status: DocumentStatus.pendingApproval,
        createdAt: now.subtract(const Duration(days: 4)),
      ),
      DocumentRecord(
        id: 'VP-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.vendorPayment,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Vendor Payment',
        status: DocumentStatus.draft,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      DocumentRecord(
        id: 'SI-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.salesInvoice,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Sales Invoice',
        status: DocumentStatus.approved,
        createdAt: now.subtract(const Duration(days: 6)),
        approvedAt: now.subtract(const Duration(days: 5)),
      ),
      DocumentRecord(
        id: 'CP-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.customerPayment,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Customer Payment',
        status: DocumentStatus.draft,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      DocumentRecord(
        id: 'JV-2026-000001',
        documentNumber: DocumentNumberGenerator(
          prefix: DocumentPrefix.journalVoucher,
          fiscalYear: 2026,
          runningSequence: 1,
        ).generateDocumentNumber(),
        documentType: 'Journal Voucher',
        status: DocumentStatus.posted,
        createdAt: now.subtract(const Duration(days: 9)),
        approvedAt: now.subtract(const Duration(days: 8)),
        postedAt: now.subtract(const Duration(days: 7)),
      ),
    ]);
  }

  @override
  Future<AppResult<List<DocumentRecord>>> fetchDocuments() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_records));
  }

  @override
  Future<AppResult<DocumentRecord>> fetchDocument(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final index = _records.indexWhere((r) => r.id == id);
    if (index < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Document not found'),
      );
    }
    return AppResult.success(_records[index]);
  }

  @override
  Future<AppResult<DocumentRecord>> transition(
    String id,
    DocumentStatus target,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _records.indexWhere((r) => r.id == id);
    if (index < 0) {
      return AppResult.failure(
        const UnknownFailure(message: 'Document not found'),
      );
    }

    final current = _records[index];
    final result = _workflow.transition(current.status, target);
    if (!result.isSuccess) {
      return AppResult.failure(result.error!);
    }

    final now = DateTime.now();
    final updated = current.copyWith(
      status: target,
      approvedAt: target == DocumentStatus.approved ? now : current.approvedAt,
      postedAt: target == DocumentStatus.posted ? now : current.postedAt,
    );
    _records[index] = updated;
    return AppResult.success(updated);
  }
}
