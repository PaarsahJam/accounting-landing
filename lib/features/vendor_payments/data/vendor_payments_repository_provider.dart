import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'vendor_payments_repository.dart';

part 'vendor_payments_repository_provider.g.dart';

@riverpod
VendorPaymentsRepository vendorPaymentsRepository(Ref ref) {
  return MockVendorPaymentsRepository();
}
