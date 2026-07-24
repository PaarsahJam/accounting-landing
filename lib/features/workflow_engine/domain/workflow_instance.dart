import '../../audit_trail/domain/audit_entity_type.dart';
import 'workflow_approval.dart';
import 'workflow_transition_record.dart';

class WorkflowInstance {
  final String id;
  final String definitionId;
  final AuditEntityType entityType;
  final String entityId;
  final String currentStateId;
  final Map<String, dynamic> context;
  final List<WorkflowTransitionRecord> history;
  final WorkflowApproval approval;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkflowInstance({
    required this.id,
    required this.definitionId,
    required this.entityType,
    required this.entityId,
    required this.currentStateId,
    this.context = const {},
    this.history = const [],
    this.approval = const WorkflowApproval(),
    required this.createdAt,
    required this.updatedAt,
  });

  WorkflowInstance copyWith({
    String? id,
    String? definitionId,
    AuditEntityType? entityType,
    String? entityId,
    String? currentStateId,
    Map<String, dynamic>? context,
    List<WorkflowTransitionRecord>? history,
    WorkflowApproval? approval,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkflowInstance(
      id: id ?? this.id,
      definitionId: definitionId ?? this.definitionId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      currentStateId: currentStateId ?? this.currentStateId,
      context: context ?? this.context,
      history: history ?? this.history,
      approval: approval ?? this.approval,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkflowInstance &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'WorkflowInstance(id: $id, entity: $entityType/$entityId, state: $currentStateId)';
}
