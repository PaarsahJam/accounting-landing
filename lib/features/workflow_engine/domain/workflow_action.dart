import '../../../core/errors/app_result.dart';

abstract class WorkflowAction {
  String get description;

  Future<AppResult<void>> execute(Map<String, dynamic> context);
}

class AuditLogAction extends WorkflowAction {
  final String messageTemplate;

  AuditLogAction({required this.messageTemplate});

  @override
  String get description => 'Log audit entry: $messageTemplate';

  @override
  Future<AppResult<void>> execute(Map<String, dynamic> context) async {
    return AppResult.success(null);
  }
}

class WebhookAction extends WorkflowAction {
  final String url;

  WebhookAction({required this.url});

  @override
  String get description => 'Call webhook: $url';

  @override
  Future<AppResult<void>> execute(Map<String, dynamic> context) async {
    return AppResult.success(null);
  }
}

class CompositeAction extends WorkflowAction {
  final List<WorkflowAction> actions;

  CompositeAction({required this.actions});

  @override
  String get description =>
      'Execute ${actions.length} actions: ${actions.map((a) => a.description).join(", ")}';

  @override
  Future<AppResult<void>> execute(Map<String, dynamic> context) async {
    for (final action in actions) {
      final result = await action.execute(context);
      if (!result.isSuccess) return result;
    }
    return AppResult.success(null);
  }
}
