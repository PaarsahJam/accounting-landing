class OcrLineItem {
  const OcrLineItem({
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

  bool get isReliable => confidence >= 0.8;

  OcrLineItem copyWith({
    int? lineNumber,
    String? description,
    double? quantity,
    double? unitPrice,
    double? amount,
    double? confidence,
  }) {
    return OcrLineItem(
      lineNumber: lineNumber ?? this.lineNumber,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      amount: amount ?? this.amount,
      confidence: confidence ?? this.confidence,
    );
  }
}
