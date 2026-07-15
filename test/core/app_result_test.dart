import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppResult', () {
    test('creates a success result', () {
      final result = AppResult.success('ok');

      expect(result.isSuccess, isTrue);
      expect(result.data, 'ok');
      expect(result.error, isNull);
    });

    test('creates a failure result', () {
      const failure = ValidationFailure(message: 'invalid');
      final result = AppResult<String>.failure(failure);

      expect(result.isSuccess, isFalse);
      expect(result.data, isNull);
      expect(result.error, failure);
    });
  });
}
