import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_sales_invoices_repository.dart';
import 'sales_invoices_repository.dart';

part 'sales_invoices_repository_provider.g.dart';

@Riverpod(keepAlive: true)
SalesInvoicesRepository salesInvoicesRepository(Ref ref) {
  final repo = DriftSalesInvoicesRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
