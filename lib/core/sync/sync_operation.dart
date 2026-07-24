enum OperationType { create, update, delete }

enum OperationStatus { pending, inFlight, failed }

class SyncOperation {
  const SyncOperation({
    required this.id,
    required this.operationType,
    required this.entityType,
    required this.entityId,
    required this.data,
    this.localVersion = 1,
    this.createdAt,
    this.retryCount = 0,
    this.status = OperationStatus.pending,
    this.failureReason,
    this.companyId,
  });

  final String id;
  final OperationType operationType;
  final String entityType;
  final String entityId;
  final Map<String, dynamic> data;
  final int localVersion;
  final DateTime? createdAt;
  final int retryCount;
  final OperationStatus status;
  final String? failureReason;
  final String? companyId;

  SyncOperation copyWith({
    String? id,
    OperationType? operationType,
    String? entityType,
    String? entityId,
    Map<String, dynamic>? data,
    int? localVersion,
    DateTime? createdAt,
    int? retryCount,
    OperationStatus? status,
    String? failureReason,
    String? companyId,
  }) =>
      SyncOperation(
        id: id ?? this.id,
        operationType: operationType ?? this.operationType,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        data: data ?? this.data,
        localVersion: localVersion ?? this.localVersion,
        createdAt: createdAt ?? this.createdAt,
        retryCount: retryCount ?? this.retryCount,
        status: status ?? this.status,
        failureReason: failureReason ?? this.failureReason,
        companyId: companyId ?? this.companyId,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'operationType': operationType.name,
        'entityType': entityType,
        'entityId': entityId,
        'data': data,
        'localVersion': localVersion,
        'createdAt': createdAt?.toIso8601String(),
        'retryCount': retryCount,
        'status': status.name,
        if (failureReason != null) 'failureReason': failureReason,
        if (companyId != null) 'companyId': companyId,
      };

  factory SyncOperation.fromJson(Map<String, dynamic> json) => SyncOperation(
        id: json['id'] as String,
        operationType:
            OperationType.values.byName(json['operationType'] as String),
        entityType: json['entityType'] as String,
        entityId: json['entityId'] as String,
        data: Map<String, dynamic>.from(json['data'] as Map),
        localVersion: json['localVersion'] as int? ?? 1,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        retryCount: json['retryCount'] as int? ?? 0,
        status: OperationStatus.values.byName(json['status'] as String),
        failureReason: json['failureReason'] as String?,
        companyId: json['companyId'] as String?,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncOperation && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'SyncOperation(id: $id, type: $operationType, entity: $entityType/$entityId, status: $status)';
}
