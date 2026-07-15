abstract class AppFailure {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class ValidationFailure extends AppFailure {
  const ValidationFailure({required String message}) : super(message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure({required String message}) : super(message);
}

class StorageFailure extends AppFailure {
  const StorageFailure({required String message}) : super(message);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure({required String message}) : super(message);
}
