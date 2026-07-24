import 'dart:convert';

class CloudSyncConfig {
  const CloudSyncConfig({
    required this.accountId,
    required this.companyId,
    this.lastSyncCursor,
    this.lastPullCursor,
    this.deviceId,
  });

  final String accountId;
  final String companyId;
  final DateTime? lastSyncCursor;
  final DateTime? lastPullCursor;
  final String? deviceId;

  bool get hasPendingSync =>
      lastSyncCursor != null && lastPullCursor != lastSyncCursor;

  CloudSyncConfig copyWith({
    String? accountId,
    String? companyId,
    DateTime? lastSyncCursor,
    DateTime? lastPullCursor,
    String? deviceId,
  }) =>
      CloudSyncConfig(
        accountId: accountId ?? this.accountId,
        companyId: companyId ?? this.companyId,
        lastSyncCursor: lastSyncCursor ?? this.lastSyncCursor,
        lastPullCursor: lastPullCursor ?? this.lastPullCursor,
        deviceId: deviceId ?? this.deviceId,
      );

  CloudSyncConfig advancePushCursor(DateTime timestamp) => copyWith(
        lastSyncCursor: timestamp,
      );

  CloudSyncConfig advancePullCursor(DateTime timestamp) => copyWith(
        lastPullCursor: timestamp,
      );

  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'companyId': companyId,
        if (lastSyncCursor != null)
          'lastSyncCursor': lastSyncCursor!.toIso8601String(),
        if (lastPullCursor != null)
          'lastPullCursor': lastPullCursor!.toIso8601String(),
        if (deviceId != null) 'deviceId': deviceId,
      };

  factory CloudSyncConfig.fromJson(Map<String, dynamic> json) =>
      CloudSyncConfig(
        accountId: json['accountId'] as String,
        companyId: json['companyId'] as String,
        lastSyncCursor: json['lastSyncCursor'] != null
            ? DateTime.parse(json['lastSyncCursor'] as String)
            : null,
        lastPullCursor: json['lastPullCursor'] != null
            ? DateTime.parse(json['lastPullCursor'] as String)
            : null,
        deviceId: json['deviceId'] as String?,
      );

  String toJsonString() => jsonEncode(toJson());

  factory CloudSyncConfig.fromJsonString(String source) =>
      CloudSyncConfig.fromJson(
          jsonDecode(source) as Map<String, dynamic>);
}
