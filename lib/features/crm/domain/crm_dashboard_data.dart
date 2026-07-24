import 'package:freezed_annotation/freezed_annotation.dart';

part 'crm_dashboard_data.freezed.dart';

@freezed
abstract class CrmDashboardData with _$CrmDashboardData {
  const factory CrmDashboardData({
    required int totalContacts,
    required int totalTasks,
    required int openTasks,
    required int overdueTasks,
    required int totalLeads,
    required int activeOpportunities,
    required double pipelineValue,
    required double wonValueThisMonth,
  }) = _CrmDashboardData;
}
