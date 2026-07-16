/// Broad category of an attachment — used for icon selection and display.
enum AttachmentFileType {
  pdf,
  image,
  spreadsheet,
  document,
  archive,
  other;

  String get label {
    switch (this) {
      case AttachmentFileType.pdf:
        return 'PDF';
      case AttachmentFileType.image:
        return 'Image';
      case AttachmentFileType.spreadsheet:
        return 'Spreadsheet';
      case AttachmentFileType.document:
        return 'Document';
      case AttachmentFileType.archive:
        return 'Archive';
      case AttachmentFileType.other:
        return 'File';
    }
  }

  /// Infer type from a filename extension.
  static AttachmentFileType fromFilename(String filename) {
    final ext = filename.contains('.')
        ? filename.split('.').last.toLowerCase()
        : '';
    switch (ext) {
      case 'pdf':
        return AttachmentFileType.pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
      case 'svg':
        return AttachmentFileType.image;
      case 'xls':
      case 'xlsx':
      case 'csv':
      case 'ods':
        return AttachmentFileType.spreadsheet;
      case 'doc':
      case 'docx':
      case 'txt':
      case 'rtf':
      case 'odt':
        return AttachmentFileType.document;
      case 'zip':
      case 'tar':
      case 'gz':
      case 'rar':
      case '7z':
        return AttachmentFileType.archive;
      default:
        return AttachmentFileType.other;
    }
  }
}
