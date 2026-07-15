import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'vendor_statements_repository.dart';

part 'vendor_statements_repository_provider.g.dart';

@riverpod
VendorStatementsRepository vendorStatementsRepository(Ref ref) {
  return MockVendorStatementsRepository();
}
