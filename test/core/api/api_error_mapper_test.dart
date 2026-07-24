import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/api/api_error_mapper.dart';
import 'package:accounting_app/core/errors/app_failure.dart';

void main() {
  group('mapDioError', () {
    DioException exception({
      required DioExceptionType type,
      int? statusCode,
      dynamic data,
      Object? error,
    }) {
      return DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: type,
        response: statusCode != null
            ? Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: statusCode,
                data: data,
              )
            : null,
        error: error,
      );
    }

    test('timeout returns NetworkFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.connectionTimeout,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Request timed out');
    });

    test('connection error returns NetworkFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.connectionError,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'No internet connection');
    });

    test('cancellation returns UnknownFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.cancel,
      ));
      expect(result, isA<UnknownFailure>());
    });

    test('bad certificate returns NetworkFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badCertificate,
      ));
      expect(result, isA<NetworkFailure>());
    });

    test('transform timeout returns NetworkFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.transformTimeout,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Response transformation timed out');
    });

    test('unknown with AppFailure error propagates it', () {
      final failure = const ValidationFailure(message: 'custom');
      final result =       mapDioError(exception(
        type: DioExceptionType.unknown,
        error: failure,
      ));
      expect(result, isA<ValidationFailure>());
      expect(result.message, 'custom');
    });

    test('unknown without error returns UnknownFailure', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.unknown,
      ));
      expect(result, isA<UnknownFailure>());
    });

    test('400 returns ValidationFailure with default message', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 400,
      ));
      expect(result, isA<ValidationFailure>());
      expect(result.message, 'Bad request');
    });

    test('401 returns NetworkFailure (Unauthorized)', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 401,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Unauthorized');
    });

    test('403 returns NetworkFailure (Forbidden)', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 403,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Forbidden');
    });

    test('404 returns NetworkFailure (Not found)', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 404,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Resource not found');
    });

    test('422 extracts message from response body', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 422,
        data: {'message': 'Name is required'},
      ));
      expect(result, isA<ValidationFailure>());
      expect(result.message, 'Name is required');
    });

    test('500+ returns NetworkFailure (Server error)', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 500,
      ));
      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Server error');
    });

    test('extracts message from "error" key', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 400,
        data: {'error': 'Invalid input'},
      ));
      expect(result.message, 'Invalid input');
    });

    test('extracts message from "detail" key', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 400,
        data: {'detail': 'Malformed request'},
      ));
      expect(result.message, 'Malformed request');
    });

    test('joins validation errors array', () {
      final result =       mapDioError(exception(
        type: DioExceptionType.badResponse,
        statusCode: 422,
        data: {
          'errors': {'field1': ['Err1'], 'field2': ['Err2']},
        },
      ));
      expect(result.message, 'Err1\nErr2');
    });
  });
}
