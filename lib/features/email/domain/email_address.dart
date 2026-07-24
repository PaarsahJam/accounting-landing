class EmailAddress {
  const EmailAddress({
    required this.address,
    this.displayName,
  });

  final String address;
  final String? displayName;

  String get formatted =>
      displayName != null ? '$displayName <$address>' : address;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAddress &&
          runtimeType == other.runtimeType &&
          address == other.address &&
          displayName == other.displayName;

  @override
  int get hashCode => Object.hash(address, displayName);

  @override
  String toString() => formatted;
}
