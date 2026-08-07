import 'package:intl/intl.dart';

import 'app_calendar.dart';

class AppFormatters {
  AppFormatters._();

  static String formatCurrency(double amount, {String currency = '\$'}) {
    return '${amount.toStringAsFixed(0)} $currency';
  }

  /// Formats a date in the calendar active for [locale]
  /// (e.g. "Jan 2, 2024" for Gregorian or "۲ مهر ۲۵۸۳" for Persian).
  static String formatDate(DateTime value, {String? locale}) {
    final calendar = AppCalendarUtils.calendarForLocale(locale);
    if (calendar == AppCalendar.persianShahanshahi) {
      final p = AppCalendarUtils.toPersian(value);
      return '${AppCalendarUtils.toPersianDigits(p.day)} '
          '${AppCalendarUtils.persianMonthName(p.month)} '
          '${AppCalendarUtils.toPersianDigits(AppCalendarUtils.toShahanshahiYear(p.year))}';
    }
    return _formatWithLocale('yMMMd', value, locale);
  }

  /// Formats a date with time (e.g. "2 Jan 2024, 14:30" for Gregorian or
  /// "۲ مهر ۲۵۸۳، ۱۴:۳۰" for Persian).
  static String formatDateTime(DateTime value, {String? locale}) {
    final calendar = AppCalendarUtils.calendarForLocale(locale);
    if (calendar == AppCalendar.persianShahanshahi) {
      final p = AppCalendarUtils.toPersian(value);
      return '${AppCalendarUtils.toPersianDigits(p.day)} '
          '${AppCalendarUtils.persianMonthName(p.month)} '
          '${AppCalendarUtils.toPersianDigits(AppCalendarUtils.toShahanshahiYear(p.year))}، '
          '${AppCalendarUtils.toPersianDigits(value.hour)}:'
          '${AppCalendarUtils.toPersianDigits(value.minute)}';
    }
    return _formatWithLocale('d MMM yyyy, HH:mm', value, locale);
  }

  static String _formatWithLocale(
    String pattern,
    DateTime value,
    String? locale,
  ) {
    if (locale == null) {
      return DateFormat(pattern).format(value);
    }
    try {
      return DateFormat(pattern, locale).format(value);
    } catch (_) {
      return DateFormat(pattern).format(value);
    }
  }

  /// Formats a date as ISO (yyyy-MM-dd) in the active calendar
  /// (e.g. "2024-01-02" or "۲۵۸۳-۰۷-۰۲").
  static String formatIsoDate(DateTime value, {String? locale}) {
    final calendar = AppCalendarUtils.calendarForLocale(locale);
    if (calendar == AppCalendar.persianShahanshahi) {
      final p = AppCalendarUtils.toPersian(value);
      final y = AppCalendarUtils.toShahanshahiYear(p.year);
      return AppCalendarUtils.toPersianDigitsIn(
        '${_pad(y, 4)}-${_pad(p.month, 2)}-${_pad(p.day, 2)}',
      );
    }
    return '${_pad(value.year, 4)}-${_pad(value.month, 2)}-${_pad(value.day, 2)}';
  }

  /// Formats a date and time as ISO (yyyy-MM-dd HH:mm) in the active calendar.
  static String formatIsoDateTime(DateTime value, {String? locale}) {
    final calendar = AppCalendarUtils.calendarForLocale(locale);
    if (calendar == AppCalendar.persianShahanshahi) {
      final p = AppCalendarUtils.toPersian(value);
      final y = AppCalendarUtils.toShahanshahiYear(p.year);
      return AppCalendarUtils.toPersianDigitsIn(
        '${_pad(y, 4)}-${_pad(p.month, 2)}-${_pad(p.day, 2)} '
        '${_pad(value.hour, 2)}:${_pad(value.minute, 2)}',
      );
    }
    return '${_pad(value.year, 4)}-${_pad(value.month, 2)}-${_pad(value.day, 2)} '
        '${_pad(value.hour, 2)}:${_pad(value.minute, 2)}';
  }

  static String _pad(int value, int width) =>
      value.toString().padLeft(width, '0');
}
