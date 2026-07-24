import '../../attachments/ocr/domain/document_classification.dart';
import '../../attachments/ocr/domain/ocr_field.dart';
import '../../attachments/ocr/domain/ocr_line_item.dart';
import '../../attachments/ocr/domain/ocr_result.dart';
import '../../attachments/ocr/services/ocr_mapper.dart';

/// Confidence tier for an extracted field value.
enum FieldConfidence {
  high, // >= 0.8
  medium, // 0.5–0.79
  low; // < 0.5

  static FieldConfidence fromScore(double score) {
    if (score >= 0.8) return FieldConfidence.high;
    if (score >= 0.5) return FieldConfidence.medium;
    return FieldConfidence.low;
  }
}

/// A single extracted field with its confidence score.
class ExtractedField<T> {
  const ExtractedField({
    required this.value,
    required this.confidence,
    this.overriddenByUser = false,
  });

  final T? value;
  final double confidence;
  final bool overriddenByUser;

  FieldConfidence get tier => FieldConfidence.fromScore(confidence);
  bool get isReliable => confidence >= 0.8;

  ExtractedField<T> withUserOverride(T? newValue) =>
      ExtractedField(value: newValue, confidence: 1.0, overriddenByUser: true);
}

/// Extracted line item from a document.
class ExtractedLineItem {
  const ExtractedLineItem({
    required this.lineNumber,
    required this.description,
    this.quantity,
    this.unitPrice,
    this.amount,
    this.confidence = 1.0,
  });

  final int lineNumber;
  final String description;
  final double? quantity;
  final double? unitPrice;
  final double? amount;
  final double confidence;

  double get computedAmount =>
      amount ?? (quantity ?? 0) * (unitPrice ?? 0);

  static ExtractedLineItem fromOcr(OcrLineItem item) => ExtractedLineItem(
        lineNumber: item.lineNumber,
        description: item.description,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        amount: item.amount,
        confidence: item.confidence,
      );
}

/// Base class for all typed document drafts.
sealed class ExtractedDocumentDraft {
  const ExtractedDocumentDraft({
    required this.documentType,
    required this.classificationConfidence,
    required this.extractedAt,
    required this.lineItems,
  });

  final DocumentType documentType;
  final double classificationConfidence;
  final DateTime extractedAt;
  final List<ExtractedLineItem> lineItems;

  /// Overall readiness: true when all required fields are high-confidence.
  bool get isReadyForAutoCreate;

  /// Builds a draft from an [OcrResult] using the [OcrMapper].
  static ExtractedDocumentDraft fromOcrResult(OcrResult result) {
    final type = result.classification.documentType;
    final confidence = result.classification.confidence;
    final now = DateTime.now();
    final lines = result.lineItems.map(ExtractedLineItem.fromOcr).toList();
    final mapper = const OcrMapper();

    switch (type) {
      case DocumentType.invoice:
        final data = mapper.mapToDraftInvoice(result);
        return InvoiceDraft(
          classificationConfidence: confidence,
          extractedAt: now,
          lineItems: lines,
          customerName: ExtractedField(
            value: data['customerName'] as String?,
            confidence: _fieldConf(result, 'customerName'),
          ),
          reference: ExtractedField(
            value: data['reference'] as String?,
            confidence: _fieldConf(result, 'reference'),
          ),
          invoiceDate: ExtractedField(
            value: data['invoiceDate'] as DateTime?,
            confidence: _fieldConf(result, 'invoiceDate'),
          ),
          dueDate: ExtractedField(
            value: data['dueDate'] as DateTime?,
            confidence: _fieldConf(result, 'dueDate'),
          ),
          subtotal: ExtractedField(
            value: data['subtotal'] as double?,
            confidence: _fieldConf(result, 'subtotal'),
          ),
          tax: ExtractedField(
            value: data['tax'] as double?,
            confidence: _fieldConf(result, 'tax'),
          ),
          total: ExtractedField(
            value: data['total'] as double?,
            confidence: _fieldConf(result, 'total'),
          ),
        );

      case DocumentType.vendorBill:
        final data = mapper.mapToDraftVendorBill(result);
        return VendorBillDraft(
          classificationConfidence: confidence,
          extractedAt: now,
          lineItems: lines,
          vendorName: ExtractedField(
            value: data['vendorName'] as String?,
            confidence: _fieldConf(result, 'vendorName'),
          ),
          reference: ExtractedField(
            value: data['reference'] as String?,
            confidence: _fieldConf(result, 'reference'),
          ),
          billDate: ExtractedField(
            value: data['billDate'] as DateTime?,
            confidence: _fieldConf(result, 'billDate'),
          ),
          dueDate: ExtractedField(
            value: data['dueDate'] as DateTime?,
            confidence: _fieldConf(result, 'dueDate'),
          ),
          total: ExtractedField(
            value: data['total'] as double?,
            confidence: _fieldConf(result, 'total'),
          ),
        );

      case DocumentType.expenseReceipt:
        final data = mapper.mapToDraftExpense(result);
        return ExpenseReceiptDraft(
          classificationConfidence: confidence,
          extractedAt: now,
          lineItems: lines,
          merchant: ExtractedField(
            value: data['merchant'] as String?,
            confidence: _fieldConf(result, 'merchant'),
          ),
          amount: ExtractedField(
            value: data['amount'] as double?,
            confidence: _fieldConf(result, 'amount'),
          ),
          occurredAt: ExtractedField(
            value: data['occurredAt'] as DateTime?,
            confidence: _fieldConf(result, 'occurredAt'),
          ),
          description: ExtractedField(
            value: data['description'] as String?,
            confidence: _fieldConf(result, 'description'),
          ),
        );

      case DocumentType.bankStatement:
        return BankStatementDraft(
          classificationConfidence: confidence,
          extractedAt: now,
          lineItems: lines,
          accountNumber: ExtractedField(
            value: result.fieldByType(
              // ignore: deprecated_member_use_from_same_package
              OcrFieldType.accountNumber,
            )?.value,
            confidence: _fieldConf(result, 'accountNumber'),
          ),
          statementDate: ExtractedField(
            value: result.fieldByType(OcrFieldType.documentDate)?.asDate,
            confidence: _fieldConf(result, 'statementDate'),
          ),
          closingBalance: ExtractedField(
            value: result.fieldByType(OcrFieldType.totalAmount)?.asDouble,
            confidence: _fieldConf(result, 'closingBalance'),
          ),
        );

      default:
        return UnsupportedDocumentDraft(
          documentType: type,
          classificationConfidence: confidence,
          extractedAt: now,
          rawText: result.rawText,
        );
    }
  }

  /// Looks up the confidence for a logical field name from the OcrResult.
  static double _fieldConf(OcrResult result, String fieldName) {
    // Map logical names to OcrFieldType
    final typeMap = <String, OcrFieldType>{
      'customerName': OcrFieldType.customerName,
      'vendorName': OcrFieldType.vendorName,
      'merchant': OcrFieldType.merchantName,
      'reference': OcrFieldType.invoiceNumber,
      'invoiceDate': OcrFieldType.documentDate,
      'billDate': OcrFieldType.documentDate,
      'occurredAt': OcrFieldType.documentDate,
      'statementDate': OcrFieldType.documentDate,
      'dueDate': OcrFieldType.dueDate,
      'subtotal': OcrFieldType.subtotal,
      'tax': OcrFieldType.taxAmount,
      'total': OcrFieldType.totalAmount,
      'amount': OcrFieldType.totalAmount,
      'accountNumber': OcrFieldType.accountNumber,
      'closingBalance': OcrFieldType.totalAmount,
      'description': OcrFieldType.description,
    };
    final ocrType = typeMap[fieldName];
    if (ocrType == null) return 0.5;
    return result.fieldByType(ocrType)?.confidence ?? 0.5;
  }
}

// ─── Concrete draft types ─────────────────────────────────────────────────────

class InvoiceDraft extends ExtractedDocumentDraft {
  const InvoiceDraft({
    required super.classificationConfidence,
    required super.extractedAt,
    required super.lineItems,
    required this.customerName,
    required this.reference,
    required this.invoiceDate,
    required this.dueDate,
    required this.subtotal,
    required this.tax,
    required this.total,
  }) : super(documentType: DocumentType.invoice);

  final ExtractedField<String> customerName;
  final ExtractedField<String> reference;
  final ExtractedField<DateTime> invoiceDate;
  final ExtractedField<DateTime> dueDate;
  final ExtractedField<double> subtotal;
  final ExtractedField<double> tax;
  final ExtractedField<double> total;

  @override
  bool get isReadyForAutoCreate =>
      customerName.isReliable &&
      total.isReliable &&
      classificationConfidence >= 0.8;
}

class VendorBillDraft extends ExtractedDocumentDraft {
  const VendorBillDraft({
    required super.classificationConfidence,
    required super.extractedAt,
    required super.lineItems,
    required this.vendorName,
    required this.reference,
    required this.billDate,
    required this.dueDate,
    required this.total,
  }) : super(documentType: DocumentType.vendorBill);

  final ExtractedField<String> vendorName;
  final ExtractedField<String> reference;
  final ExtractedField<DateTime> billDate;
  final ExtractedField<DateTime> dueDate;
  final ExtractedField<double> total;

  @override
  bool get isReadyForAutoCreate =>
      vendorName.isReliable &&
      total.isReliable &&
      classificationConfidence >= 0.8;
}

class ExpenseReceiptDraft extends ExtractedDocumentDraft {
  const ExpenseReceiptDraft({
    required super.classificationConfidence,
    required super.extractedAt,
    required super.lineItems,
    required this.merchant,
    required this.amount,
    required this.occurredAt,
    required this.description,
  }) : super(documentType: DocumentType.expenseReceipt);

  final ExtractedField<String> merchant;
  final ExtractedField<double> amount;
  final ExtractedField<DateTime> occurredAt;
  final ExtractedField<String> description;

  @override
  bool get isReadyForAutoCreate =>
      amount.isReliable && classificationConfidence >= 0.8;
}

class BankStatementDraft extends ExtractedDocumentDraft {
  const BankStatementDraft({
    required super.classificationConfidence,
    required super.extractedAt,
    required super.lineItems,
    required this.accountNumber,
    required this.statementDate,
    required this.closingBalance,
  }) : super(documentType: DocumentType.bankStatement);

  final ExtractedField<String> accountNumber;
  final ExtractedField<DateTime> statementDate;
  final ExtractedField<double> closingBalance;

  @override
  bool get isReadyForAutoCreate => false; // bank statements always need review
}

class UnsupportedDocumentDraft extends ExtractedDocumentDraft {
  const UnsupportedDocumentDraft({
    required super.documentType,
    required super.classificationConfidence,
    required super.extractedAt,
    required this.rawText,
  }) : super(lineItems: const []);

  final String rawText;

  @override
  bool get isReadyForAutoCreate => false;
}
