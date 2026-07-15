import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'invoice_repository.dart';

part 'invoice_repository_provider.g.dart';

@riverpod
InvoiceRepository invoiceRepository(Ref ref) {
  return MockInvoiceRepository();
}
