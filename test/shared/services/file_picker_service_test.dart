import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/services/file_picker_service.dart';

void main() {
  group('FilePickerService', () {
    test('stub can be instantiated', () {
      expect(const StubFilePickerService(), isNotNull);
    });
  });
}
