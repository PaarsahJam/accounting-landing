import 'package:accounting_app/core/utils/app_calendar.dart';
import 'package:accounting_app/core/utils/app_formatters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
    await initializeDateFormatting('hy');
  });

  test('formats currency and gregorian dates', () {
    expect(AppFormatters.formatCurrency(1234.56, currency: 'IRR'), '1235 IRR');
    expect(
      AppFormatters.formatDate(DateTime(2024, 1, 2), locale: 'en'),
      'Jan 2, 2024',
    );
  });

  test('hy uses Gregorian calendar', () {
    expect(
      AppFormatters.formatDate(DateTime(2024, 1, 2), locale: 'hy'),
      '2 հնվ, 2024 թ.',
    );
    expect(
      AppFormatters.formatIsoDate(DateTime(2024, 1, 2), locale: 'hy'),
      '2024-01-02',
    );
  });

  test('converts gregorian to jalali (shahanshahi year)', () {
    final p = AppCalendarUtils.toPersian(DateTime(2024, 1, 2));
    expect(p.year, 1402);
    expect(p.month, 10);
    expect(p.day, 12);
    expect(AppCalendarUtils.toShahanshahiYear(p.year), 2582);
  });

  test('fa formats dates in Persian Shahanshahi calendar', () {
    expect(
      AppFormatters.formatDate(DateTime(2024, 1, 2), locale: 'fa'),
      '۱۲ دی ۲۵۸۲',
    );
    expect(
      AppFormatters.formatDate(DateTime(1976, 3, 21), locale: 'fa'),
      '۱ فروردین ۲۵۳۵',
    );
    expect(
      AppFormatters.formatDateTime(DateTime(2024, 1, 2, 14, 30), locale: 'fa'),
      '۱۲ دی ۲۵۸۲، ۱۴:۳۰',
    );
    expect(
      AppFormatters.formatIsoDate(DateTime(2024, 1, 2), locale: 'fa'),
      '۲۵۸۲-۱۰-۱۲',
    );
    expect(
      AppFormatters.formatIsoDateTime(
        DateTime(2024, 1, 2, 9, 5),
        locale: 'fa',
      ),
      '۲۵۸۲-۱۰-۱۲ ۰۹:۰۵',
    );
  });
}
