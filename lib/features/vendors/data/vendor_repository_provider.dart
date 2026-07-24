import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'drift_vendor_repository.dart';
import 'vendor_repository.dart';

part 'vendor_repository_provider.g.dart';

@Riverpod(keepAlive: true)
VendorRepository vendorRepository(Ref ref) {
  final repo = DriftVendorRepository();
  ref.onDispose(() => repo.close());
  return repo;
}
