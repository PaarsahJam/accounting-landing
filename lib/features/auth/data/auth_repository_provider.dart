import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_repository.dart';
import 'drift_auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => DriftAuthRepository();
