import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

import 'app/bootstrap.dart';
import 'core/company/company_provider.dart';
import 'core/company/company_repository.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/data/auth_repository_provider.dart';
import 'features/user_roles/data/user_repository.dart';
import 'features/user_roles/data/user_repository_provider.dart';

void main() {
  // Must be called before any Flutter framework access. Placed here in main()
  // rather than inside Bootstrap.initState() which runs too late.
  WidgetsFlutterBinding.ensureInitialized();

  // In debug/profile builds, provide the in-memory mock implementations so
  // the app works without a live backend.  In release builds no overrides are
  // registered; attempting to use an unoverridden provider would throw
  // UnimplementedError immediately, forcing the real backend to be wired.
  final List<Override> overrides = kReleaseMode
      ? const <Override>[]
      : <Override>[
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          companyRepositoryProvider.overrideWithValue(MockCompanyRepository()),
          userRepositoryProvider.overrideWithValue(MockUserRepository()),
        ];

  runApp(ProviderScope(overrides: overrides, child: const Bootstrap()));
}
