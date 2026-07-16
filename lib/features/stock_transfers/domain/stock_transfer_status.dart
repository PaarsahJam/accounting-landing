/// Lifecycle status for a stock transfer document.
enum StockTransferStatus {
  pending,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case StockTransferStatus.pending:
        return 'Pending';
      case StockTransferStatus.completed:
        return 'Completed';
      case StockTransferStatus.cancelled:
        return 'Cancelled';
    }
  }
}
