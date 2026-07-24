import 'package:dio/dio.dart';

import '../errors/app_failure.dart';

AppFailure mapDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure(message: 'Request timed out');
    case DioExceptionType.connectionError:
      return const NetworkFailure(message: 'No internet connection');
    case DioExceptionType.badResponse:
      return _mapStatusCode(error.response?.statusCode, error.response?.data);
    case DioExceptionType.cancel:
      return const UnknownFailure(message: 'Request was cancelled');
    case DioExceptionType.badCertificate:
      return const NetworkFailure(message: 'Invalid server certificate');
    case DioExceptionType.transformTimeout:
      return const NetworkFailure(message: 'Response transformation timed out');
    case DioExceptionType.unknown:
      final underlying = error.error;
      if (underlying is AppFailure) return underlying;
      return UnknownFailure(
          message: underlying?.toString() ?? 'An unexpected error occurred');
  }
}

AppFailure _mapStatusCode(int? statusCode, dynamic data) {
  final code = statusCode ?? 0;
  final message = _extractMessage(data) ?? _defaultMessage(statusCode);
  switch (code) {
    case 400:
      return ValidationFailure(message: message);
    case 401:
      return const NetworkFailure(message: 'Unauthorized');
    case 403:
      return const NetworkFailure(message: 'Forbidden');
    case 404:
      return const NetworkFailure(message: 'Resource not found');
    case 409:
      return ValidationFailure(message: message);
    case 422:
      return ValidationFailure(message: message);
    case >= 500:
      return const NetworkFailure(message: 'Server error');
    default:
      return NetworkFailure(message: message);
  }
}

String? _extractMessage(dynamic data) {
  if (data is Map) {
    final message = data['message'] ?? data['error'] ?? data['detail'];
    if (message is String && message.isNotEmpty) return message;
    if (data['errors'] is Map) {
      final errors = data['errors'] as Map;
      return errors.values.expand((e) => e is List ? e : [e]).join('\n');
    }
  }
  if (data is String && data.isNotEmpty) return data;
  return null;
}

String _defaultMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return 'Not found';
    case 409:
      return 'Conflict';
    case 422:
      return 'Validation failed';
    default:
      return 'Request failed with status $statusCode';
  }
}
