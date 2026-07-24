class SyncStatus {
  const SyncStatus({
    this.pendingCount = 0,
    this.inFlightCount = 0,
    this.failedCount = 0,
    this.lastSyncedAt,
    this.lastSyncErrorMessage,
  });

  final int pendingCount;
  final int inFlightCount;
  final int failedCount;
  final DateTime? lastSyncedAt;
  final String? lastSyncErrorMessage;

  bool get isIdle => pendingCount == 0 && inFlightCount == 0;
  bool get hasFailures => failedCount > 0;

  SyncStatus copyWith({
    int? pendingCount,
    int? inFlightCount,
    int? failedCount,
    DateTime? lastSyncedAt,
    String? lastSyncErrorMessage,
    bool clearLastError = false,
  }) =>
      SyncStatus(
        pendingCount: pendingCount ?? this.pendingCount,
        inFlightCount: inFlightCount ?? this.inFlightCount,
        failedCount: failedCount ?? this.failedCount,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
        lastSyncErrorMessage: clearLastError
            ? null
            : lastSyncErrorMessage ?? this.lastSyncErrorMessage,
      );

  @override
  String toString() =>
      'SyncStatus(pending: $pendingCount, inFlight: $inFlightCount, failed: $failedCount)';
}
