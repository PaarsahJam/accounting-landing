class Company {
  final String id;
  final String name;
  final String? legalName;
  final String? taxId;
  final String? currency;
  final String? fiscalYearStartMonth;
  final String? logoUrl;
  final bool isActive;

  const Company({
    required this.id,
    required this.name,
    this.legalName,
    this.taxId,
    this.currency,
    this.fiscalYearStartMonth,
    this.logoUrl,
    this.isActive = true,
  });

  Company copyWith({
    String? id,
    String? name,
    String? legalName,
    String? taxId,
    String? currency,
    String? fiscalYearStartMonth,
    String? logoUrl,
    bool? isActive,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      taxId: taxId ?? this.taxId,
      currency: currency ?? this.currency,
      fiscalYearStartMonth:
          fiscalYearStartMonth ?? this.fiscalYearStartMonth,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  String get initials {
    final parts = name.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Company &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Company(id: $id, name: $name)';
}
