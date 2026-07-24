import 'sync_operation.dart';

enum ConflictStrategy {
  /// Local changes overwrite server state.
  clientWins,

  /// Server state replaces local changes (operation is discarded).
  serverWins,

  /// Neither side wins; operation stays queued for manual resolution.
  abort,
}

class ConflictResolution {
  const ConflictResolution({
    required this.resolved,
    this.resolvedOperation,
    this.resolutionNote,
  });

  /// Whether the conflict was resolved without aborting.
  final bool resolved;

  /// The operation to apply after resolution (null if operation is discarded).
  final SyncOperation? resolvedOperation;

  /// Human-readable explanation.
  final String? resolutionNote;
}

class ConflictDetector {
  const ConflictDetector();

  /// Detects a conflict if [localVersion] differs from [serverVersion].
  /// Returns `null` when no conflict exists.
  ConflictResolution? detect(
    SyncOperation operation,
    int serverVersion, {
    ConflictStrategy strategy = ConflictStrategy.clientWins,
  }) {
    if (operation.operationType == OperationType.create) {
      return null;
    }
    if (operation.localVersion >= serverVersion) {
      return null;
    }
    return resolve(operation, serverVersion, strategy: strategy);
  }

  ConflictResolution resolve(
    SyncOperation operation,
    int serverVersion, {
    ConflictStrategy strategy = ConflictStrategy.clientWins,
  }) {
    switch (strategy) {
      case ConflictStrategy.clientWins:
        final bumped = operation.copyWith(localVersion: serverVersion);
        return ConflictResolution(
          resolved: true,
          resolvedOperation: bumped,
          resolutionNote:
              'Client overwrote server version $serverVersion with local changes',
        );
      case ConflictStrategy.serverWins:
        return ConflictResolution(
          resolved: true,
          resolvedOperation: null,
          resolutionNote:
              'Operation discarded; server version $serverVersion kept',
        );
      case ConflictStrategy.abort:
        return ConflictResolution(
          resolved: false,
          resolvedOperation: null,
          resolutionNote:
              'Conflict detected (local v${operation.localVersion} vs server v$serverVersion); manual resolution required',
        );
    }
  }
}

class ConflictSummary {
  const ConflictSummary({
    required this.totalChecked,
    required this.conflictsDetected,
    required this.resolved,
    required this.aborted,
    this.details = const [],
  });

  final int totalChecked;
  final int conflictsDetected;
  final int resolved;
  final int aborted;
  final List<ConflictEntry> details;

  bool get hasConflicts => conflictsDetected > 0;
}

class ConflictEntry {
  const ConflictEntry({
    required this.operationId,
    required this.entityType,
    required this.entityId,
    required this.localVersion,
    required this.serverVersion,
    required this.strategy,
    required this.resolution,
  });

  final String operationId;
  final String entityType;
  final String entityId;
  final int localVersion;
  final int serverVersion;
  final ConflictStrategy strategy;
  final ConflictResolution resolution;
}
