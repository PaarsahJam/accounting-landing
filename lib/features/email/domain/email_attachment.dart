class EmailAttachment {
  const EmailAttachment({
    required this.filename,
    required this.mimeType,
    required this.content,
  });

  final String filename;
  final String mimeType;

  /// Raw bytes of the attachment content.
  final List<int> content;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAttachment &&
          runtimeType == other.runtimeType &&
          filename == other.filename;

  @override
  int get hashCode => filename.hashCode;
}
