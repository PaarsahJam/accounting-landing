class PluginPermission {
  const PluginPermission({
    required this.name,
    required this.label,
    required this.group,
    this.description,
  });

  final String name;
  final String label;
  final String group;
  final String? description;
}
