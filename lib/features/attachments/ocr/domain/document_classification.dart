enum DocumentType {
  invoice,
  vendorBill,
  expenseReceipt,
  creditNote,
  purchaseOrder,
  paymentReceipt,
  bankStatement,
  contract,
  taxDocument,
  other;

  String get label {
    switch (this) {
      case DocumentType.invoice:
        return 'Invoice';
      case DocumentType.vendorBill:
        return 'Vendor Bill';
      case DocumentType.expenseReceipt:
        return 'Expense Receipt';
      case DocumentType.creditNote:
        return 'Credit Note';
      case DocumentType.purchaseOrder:
        return 'Purchase Order';
      case DocumentType.paymentReceipt:
        return 'Payment Receipt';
      case DocumentType.bankStatement:
        return 'Bank Statement';
      case DocumentType.contract:
        return 'Contract';
      case DocumentType.taxDocument:
        return 'Tax Document';
      case DocumentType.other:
        return 'Other';
    }
  }

  String? get targetEntityType {
    switch (this) {
      case DocumentType.invoice:
        return 'salesInvoice';
      case DocumentType.vendorBill:
        return 'vendorBill';
      case DocumentType.expenseReceipt:
        return 'expense';
      case DocumentType.creditNote:
        return 'creditNote';
      case DocumentType.purchaseOrder:
        return 'purchaseOrder';
      case DocumentType.paymentReceipt:
        return 'paymentReceipt';
      case DocumentType.bankStatement:
        return 'bankStatement';
      case DocumentType.contract:
      case DocumentType.taxDocument:
      case DocumentType.other:
        return null;
    }
  }

  static DocumentType fromString(String value) {
    return DocumentType.values.firstWhere(
      (t) => t.name == value,
      orElse: () => DocumentType.other,
    );
  }
}

class DocumentClassification {
  const DocumentClassification({
    required this.documentType,
    required this.confidence,
    this.alternatives = const [],
  });

  final DocumentType documentType;
  final double confidence;
  final List<DocumentClassification> alternatives;

  bool get isReliable => confidence >= 0.8;
  bool get isAmbiguous => alternatives.length > 1 && confidence < 0.6;
}
