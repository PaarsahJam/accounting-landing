import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'vendor_bills_repository.dart';

part 'vendor_bills_repository_provider.g.dart';

@riverpod
VendorBillsRepository vendorBillsRepository(Ref ref) {
  return MockVendorBillsRepository();
}
