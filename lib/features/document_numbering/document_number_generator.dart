// lib/features/document_numbering/document_number_generator.dart

/// Configurable document number generator.
///
/// Produces numbers like `PO-2026-000001`, `VB-2026-000001`, etc.
class DocumentNumberGenerator {
  const DocumentNumberGenerator({
    required this.prefix,
    required this.fiscalYear,
    required this.runningSequence,
    this.paddingLength = 6,
  });

  final String prefix;
  final int fiscalYear;
  final int runningSequence;
  final int paddingLength;

  /// Returns the formatted document number.
  String generateDocumentNumber() {
    final seq = runningSequence.toString().padLeft(paddingLength, '0');
    return '$prefix-$fiscalYear-$seq';
  }

  /// Creates a new generator with an incremented [runningSequence].
  DocumentNumberGenerator next() {
    return DocumentNumberGenerator(
      prefix: prefix,
      fiscalYear: fiscalYear,
      runningSequence: runningSequence + 1,
      paddingLength: paddingLength,
    );
  }

  @override
  String toString() => generateDocumentNumber();
}

/// Registry of well-known document prefixes used across the application.
abstract final class DocumentPrefix {
  static const purchaseOrder = 'PO';
  static const goodsReceipt = 'GR';
  static const vendorBill = 'VB';
  static const vendorPayment = 'VP';
  static const salesInvoice = 'SI';
  static const customerPayment = 'CP';
  static const journalVoucher = 'JV';
}
