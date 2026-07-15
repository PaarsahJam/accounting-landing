import 'app_failure.dart';

class AppResult<T> {
  const AppResult._({this.data, this.error, this.isSuccess = false});

  final T? data;
  final AppFailure? error;
  final bool isSuccess;

  factory AppResult.success(T data) => AppResult._(data: data, isSuccess: true);

  factory AppResult.failure(AppFailure error) =>
      AppResult._(error: error, isSuccess: false);

  factory AppResult.loading() => const AppResult._(isSuccess: false);
}
