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

  // Features that do not yet have a remote REST API are routed to local Drift
  // database repositories (the default in their respective providers).  The
  // providers below still rely on in-memory mocks because no Drift-backed
  // equivalent exists for them yet; they are overridden in every build mode
  // so the app never crashes with UnimplementedError in release builds.
  final overrides = <Override>[
    authRepositoryProvider.overrideWithValue(MockAuthRepository()),
    companyRepositoryProvider.overrideWithValue(MockCompanyRepository()),
    userRepositoryProvider.overrideWithValue(MockUserRepository()),
  ];

  runApp(ProviderScope(overrides: overrides, child: const Bootstrap()));
}
