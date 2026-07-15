import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'sales_invoices_repository.dart';

part 'sales_invoices_repository_provider.g.dart';

@riverpod
SalesInvoicesRepository salesInvoicesRepository(Ref ref) {
  return MockSalesInvoicesRepository();
}
