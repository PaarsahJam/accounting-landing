class User {
  final String id;
  final String name;
  final String? email;
  final List<String> companyIds;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.companyIds = const [],
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? companyIds,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        companyIds: companyIds ?? this.companyIds,
      );

  bool hasAccessToCompany(String companyId) =>
      companyIds.isEmpty || companyIds.contains(companyId);
}
