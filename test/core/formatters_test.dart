import 'package:accounting_app/core/utils/app_formatters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  test('formats currency and dates', () {
    expect(AppFormatters.formatCurrency(1234.56, currency: 'IRR'), '1235 IRR');
    expect(
      AppFormatters.formatDate(DateTime(2024, 1, 2), locale: 'en'),
      'Jan 2, 2024',
    );
  });
}
