import 'workflow_definition.dart';

class WorkflowRegistry {
  WorkflowRegistry._();

  static final WorkflowRegistry _instance = WorkflowRegistry._();

  factory WorkflowRegistry() => _instance;

  final Map<String, WorkflowDefinition> _definitions = {};

  void register(WorkflowDefinition definition) {
    _definitions[definition.id] = definition;
  }

  WorkflowDefinition? get(String id) => _definitions[id];

  List<WorkflowDefinition> getAll() => _definitions.values.toList();

  bool isRegistered(String id) => _definitions.containsKey(id);

  void registerAll(List<WorkflowDefinition> definitions) {
    for (final d in definitions) {
      register(d);
    }
  }

  void clear() => _definitions.clear();
}
