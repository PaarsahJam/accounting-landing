import '../domain/document_classification.dart';
import '../domain/ocr_field.dart';
import '../domain/ocr_line_item.dart';
import '../domain/ocr_result.dart';

class OcrMapper {
  const OcrMapper();

  DocumentClassificationResult mapClassification(OcrResult result) {
    final cls = result.classification;
    final dateField = result.fieldByType(OcrFieldType.documentDate);
    final totalField = result.fieldByType(OcrFieldType.totalAmount);
    final vendorField = result.fieldByType(OcrFieldType.vendorName);
    final customerField = result.fieldByType(OcrFieldType.customerName);
    final invoiceField = result.fieldByType(OcrFieldType.invoiceNumber);

    return DocumentClassificationResult(
      documentType: cls.documentType,
      confidence: cls.confidence,
      isReliable: cls.isReliable,
      detectedFields: _countReliable(result.fields),
      totalFields: result.fields.length,
      hasLineItems: result.hasLineItems,
      detectedDate: dateField?.value,
      detectedTotal: totalField?.asDouble,
      detectedVendor: vendorField?.value,
      detectedCustomer: customerField?.value,
      detectedReference: invoiceField?.value,
    );
  }

  Map<String, dynamic> mapToDraftInvoice(OcrResult result) {
    return {
      'customerName': result.fieldByType(OcrFieldType.customerName)?.value ?? '',
      'reference': result.fieldByType(OcrFieldType.invoiceNumber)?.value ?? '',
      'invoiceDate': result.fieldByType(OcrFieldType.documentDate)?.asDate,
      'dueDate': result.fieldByType(OcrFieldType.dueDate)?.asDate,
      'subtotal': result.fieldByType(OcrFieldType.subtotal)?.asDouble,
      'tax': result.fieldByType(OcrFieldType.taxAmount)?.asDouble,
      'total': result.fieldByType(OcrFieldType.totalAmount)?.asDouble,
      'lines': result.lineItems.map(_mapLineToInvoiceLine).toList(),
    };
  }

  Map<String, dynamic> mapToDraftVendorBill(OcrResult result) {
    return {
      'vendorName': result.fieldByType(OcrFieldType.vendorName)?.value ?? '',
      'reference': result.fieldByType(OcrFieldType.invoiceNumber)?.value ?? '',
      'billDate': result.fieldByType(OcrFieldType.documentDate)?.asDate,
      'dueDate': result.fieldByType(OcrFieldType.dueDate)?.asDate,
      'total': result.fieldByType(OcrFieldType.totalAmount)?.asDouble,
      'lines': result.lineItems.map(_mapLineToBillLine).toList(),
    };
  }

  Map<String, dynamic> mapToDraftExpense(OcrResult result) {
    return {
      'merchant': result.fieldByType(OcrFieldType.merchantName)?.value ??
          result.fieldByType(OcrFieldType.vendorName)?.value ?? '',
      'amount': result.fieldByType(OcrFieldType.totalAmount)?.asDouble,
      'occurredAt': result.fieldByType(OcrFieldType.documentDate)?.asDate,
      'description': result.fieldByType(OcrFieldType.description)?.value ?? '',
    };
  }

  Map<String, dynamic>? mapToDraft(DocumentType type, OcrResult result) {
    switch (type) {
      case DocumentType.invoice:
        return mapToDraftInvoice(result);
      case DocumentType.vendorBill:
        return mapToDraftVendorBill(result);
      case DocumentType.expenseReceipt:
        return mapToDraftExpense(result);
      case DocumentType.purchaseOrder:
      case DocumentType.creditNote:
      case DocumentType.paymentReceipt:
      case DocumentType.bankStatement:
      case DocumentType.contract:
      case DocumentType.taxDocument:
      case DocumentType.other:
        return null;
    }
  }

  int _countReliable(List<OcrField> fields) {
    return fields.where((f) => f.isReliable).length;
  }

  Map<String, dynamic> _mapLineToInvoiceLine(OcrLineItem line) {
    return {
      'description': line.description,
      'quantity': line.quantity,
      'unitPrice': line.unitPrice,
      'amount': line.amount ?? (line.quantity ?? 0) * (line.unitPrice ?? 0),
    };
  }

  Map<String, dynamic> _mapLineToBillLine(OcrLineItem line) {
    return {
      'description': line.description,
      'quantity': line.quantity,
      'unitPrice': line.unitPrice,
    };
  }
}

class DocumentClassificationResult {
  const DocumentClassificationResult({
    required this.documentType,
    required this.confidence,
    required this.isReliable,
    required this.detectedFields,
    required this.totalFields,
    required this.hasLineItems,
    this.detectedDate,
    this.detectedTotal,
    this.detectedVendor,
    this.detectedCustomer,
    this.detectedReference,
  });

  final DocumentType documentType;
  final double confidence;
  final bool isReliable;
  final int detectedFields;
  final int totalFields;
  final bool hasLineItems;
  final String? detectedDate;
  final double? detectedTotal;
  final String? detectedVendor;
  final String? detectedCustomer;
  final String? detectedReference;
}
