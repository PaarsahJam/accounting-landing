import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_repository.dart';

part 'auth_repository_provider.g.dart';

/// Provides the active [AuthRepository] implementation.
///
/// Uses [MockAuthRepository] by default until a real backend is wired.
/// Override at app startup for production use.
@riverpod
AuthRepository authRepository(Ref ref) => MockAuthRepository();
