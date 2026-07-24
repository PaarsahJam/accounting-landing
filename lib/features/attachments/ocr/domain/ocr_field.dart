enum OcrFieldType {
  documentDate,
  dueDate,
  vendorName,
  customerName,
  totalAmount,
  subtotal,
  taxAmount,
  invoiceNumber,
  referenceNumber,
  merchantName,
  description,
  currency,
  purchaseOrderNumber,
  accountNumber,
}

class OcrField {
  const OcrField({
    required this.type,
    required this.value,
    required this.confidence,
    this.boundingBox,
  });

  final OcrFieldType type;
  final String value;
  final double confidence;
  final OcrBoundingBox? boundingBox;

  bool get isReliable => confidence >= 0.8;
  bool get isMarginallyReliable => confidence >= 0.5 && confidence < 0.8;

  double? get asDouble => double.tryParse(value);
  int? get asInt => int.tryParse(value);
  DateTime? get asDate => DateTime.tryParse(value);
}

class OcrBoundingBox {
  const OcrBoundingBox({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;
}
