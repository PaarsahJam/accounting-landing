import 'package:accounting_app/features/reports/domain/reports_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports controller loads registry-backed state', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final future = container.read(reportsControllerProvider.future);
    final value = await future;

    expect(value['reports'], isNotEmpty);
    expect(value['periods'], isNotEmpty);
    expect(value['metadata'], isA<Object>());
    expect(value['filters'], isNotEmpty);
    expect(value['exportFormats'], isNotEmpty);
    expect(value['summary'], isNotNull);
    expect(value['reportData'], isNotNull);
  });
}
