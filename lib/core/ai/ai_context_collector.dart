/// Collects structured context from domain entities for AI prompts.
///
/// Each method extracts key fields into a plain-text representation
/// that the AI model can understand regardless of provider.
class AiContextCollector {
  /// Builds a structured context string from a customer entity.
  String customerContext({
    required String id,
    required String name,
    required String company,
    required String email,
    required String phone,
    required double outstandingBalance,
    required String status,
    String? notes,
  }) {
    return '''
--- Customer ---
ID: $id
Name: $name
Company: $company
Email: $email
Phone: $phone
Outstanding Balance: $outstandingBalance
Status: $status
Notes: ${notes ?? '(none)'}
''';
  }

  /// Builds a structured context string from a sales invoice.
  String invoiceContext({
    required String id,
    required String customerName,
    required String reference,
    required String title,
    String? notes,
    required double subtotal,
    required double tax,
    required double total,
    required String statusLabel,
    required String invoiceDate,
    required String dueDate,
    List<Map<String, dynamic>>? lines,
  }) {
    final linesText = (lines != null && lines.isNotEmpty)
        ? lines.map((l) {
            final desc = l['description'] ?? '(no description)';
            final qty = l['quantity'] ?? 0;
            final price = l['unitPrice'] ?? 0;
            return '  - $desc | qty: $qty | unit price: $price';
          }).join('\n')
        : '  (no line items)';

    return '''
--- Sales Invoice ---
ID: $id
Customer: $customerName
Reference: $reference
Title: $title
Notes: ${notes ?? '(none)'}
Subtotal: $subtotal
Tax: $tax
Total: $total
Status: $statusLabel
Invoice Date: $invoiceDate
Due Date: $dueDate

Line Items:
$linesText
''';
  }

  /// Builds a structured context string from a journal entry.
  String journalContext({
    required String journalNumber,
    required String postingDate,
    String? sourceDocumentType,
    String? sourceDocumentId,
    String? narration,
    required double totalDebit,
    required double totalCredit,
    String? postingStatus,
    List<Map<String, dynamic>>? lines,
  }) {
    final linesText = (lines != null && lines.isNotEmpty)
        ? lines.map((l) {
            final account = l['accountName'] ?? l['accountCode'] ?? '(unknown)';
            final debit = l['debit'] ?? 0;
            final credit = l['credit'] ?? 0;
            return '  - $account | debit: $debit | credit: $credit';
          }).join('\n')
        : '  (no journal lines)';

    return '''
--- Journal Entry ---
Journal Number: $journalNumber
Posting Date: $postingDate
Source: ${sourceDocumentType ?? '(none)'} ${sourceDocumentId ?? ''}
Narration: ${narration ?? '(none)'}
Total Debit: $totalDebit
Total Credit: $totalCredit
Status: ${postingStatus ?? '(unknown)'}

Lines:
$linesText
''';
  }
}
