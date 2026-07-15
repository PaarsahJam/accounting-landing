import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'vendor_repository.dart';

part 'vendor_repository_provider.g.dart';

@riverpod
VendorRepository vendorRepository(Ref ref) {
  return MockVendorRepository();
}
