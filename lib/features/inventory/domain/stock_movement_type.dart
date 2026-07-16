/// Typed movement kinds — replaces the bare `String type` in [StockMovement].
enum StockMovementType {
  receipt,
  issue,
  adjustment,
  transfer,
  returnToVendor,
  returnFromCustomer,
  opening,
  writeOff;

  String get label {
    switch (this) {
      case StockMovementType.receipt:
        return 'Receipt';
      case StockMovementType.issue:
        return 'Issue';
      case StockMovementType.adjustment:
        return 'Adjustment';
      case StockMovementType.transfer:
        return 'Transfer';
      case StockMovementType.returnToVendor:
        return 'Return to Vendor';
      case StockMovementType.returnFromCustomer:
        return 'Return from Customer';
      case StockMovementType.opening:
        return 'Opening Balance';
      case StockMovementType.writeOff:
        return 'Write-Off';
    }
  }

  bool get isInbound {
    switch (this) {
      case StockMovementType.receipt:
      case StockMovementType.returnFromCustomer:
      case StockMovementType.opening:
        return true;
      default:
        return false;
    }
  }
}
