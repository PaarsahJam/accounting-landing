/// Language-driven calendar selection.
///
/// Persian (fa) uses the Shahanshahi (Imperial) calendar: the same months and
/// days as the standard Jalali calendar, but with years counted from 559 BCE
/// (the start of Cyrus's reign). All other locales use the Gregorian calendar.
library;

enum AppCalendar { gregorian, persianShahanshahi }

class PersianDate {
  const PersianDate(this.year, this.month, this.day);

  final int year;
  final int month;
  final int day;
}

class AppCalendarUtils {
  AppCalendarUtils._();

  static const int shahanshahiYearOffset = 1180;

  static const List<String> _persianMonths = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static const List<String> _persianDigits = [
    '۰',
    '۱',
    '۲',
    '۳',
    '۴',
    '۵',
    '۶',
    '۷',
    '۸',
    '۹',
  ];

  static AppCalendar calendarForLocale(String? locale) {
    if (locale == null) return AppCalendar.gregorian;
    return locale.split('_').first.toLowerCase() == 'fa'
        ? AppCalendar.persianShahanshahi
        : AppCalendar.gregorian;
  }

  static PersianDate toPersian(DateTime date) =>
      _d2j(_g2d(date.year, date.month, date.day));

  static int toShahanshahiYear(int jalaliYear) =>
      jalaliYear + shahanshahiYearOffset;

  static String persianMonthName(int month) => _persianMonths[month - 1];

  static String toPersianDigits(int value) =>
      toPersianDigitsIn(value.toString());

  /// Converts the digits in [input] (e.g. an ISO date) to Persian digits.
  static String toPersianDigitsIn(String input) {
    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final code = input.codeUnitAt(i);
      if (code >= 0x30 && code <= 0x39) {
        buffer.write(_persianDigits[code - 0x30]);
      } else {
        buffer.write(input[i]);
      }
    }
    return buffer.toString();
  }

  // --- Conversion (Borkowski algorithm, as used by jalaali-js) ---

  // Integer division truncating toward zero, matching JavaScript Math.trunc.
  static int _truncDiv(int a, int b) => a ~/ b;

  // Remainder with the sign of the dividend, matching JavaScript %.
  static int _truncMod(int a, int b) => a - (a ~/ b) * b;

  static int _g2d(int gy, int gm, int gd) {
    var d = _truncDiv((gy + _truncDiv(gm - 8, 6) + 100100) * 1461, 4) +
        _truncDiv(153 * _truncMod(gm + 9, 12) + 2, 5) +
        gd -
        34840408;
    d = d - _truncDiv(_truncDiv(gy + 100100 + _truncDiv(gm - 8, 6), 100) * 3, 4) + 752;
    return d;
  }

  static ({int gy, int gm, int gd}) _d2g(int jdn) {
    final j = (4 * jdn + 139361631) +
        _truncDiv(_truncDiv(4 * jdn + 183187720, 146097) * 3, 4) * 4 -
        3908;
    final i = _truncDiv(_truncMod(j, 1461), 4) * 5 + 308;
    final gd = _truncDiv(_truncMod(i, 153), 5) + 1;
    final gm = _truncMod(_truncDiv(i, 153), 12) + 1;
    final gy = _truncDiv(j, 1461) - 100100 + _truncDiv(8 - gm, 6);
    return (gy: gy, gm: gm, gd: gd);
  }

  static ({int leap, int gy, int march}) _jalCal(int jy) {
    const breaks = <int>[
      -61, 9, 38, 199, 426, 686, 756, 818, 1111, 1181, 1210, 1635, 2060,
      2097, 2192, 2262, 2324, 2394, 2456, 3178,
    ];
    final bl = breaks.length;
    final gy = jy + 621;
    var jp = breaks[0];
    var jump = 0;
    var leapJ = -14;
    for (var i = 1; i < bl; i++) {
      final jm = breaks[i];
      jump = jm - jp;
      if (jy < jm) break;
      leapJ = leapJ + _truncDiv(jump, 33) * 8 + _truncDiv(_truncMod(jump, 33), 4);
      jp = jm;
    }
    var n = jy - jp;
    leapJ = leapJ + _truncDiv(n, 33) * 8 + _truncDiv(_truncMod(n, 33) + 3, 4);
    if (_truncMod(jump, 33) == 4 && jump - n == 4) leapJ += 1;
    final leapG = _truncDiv(gy, 4) - _truncDiv((_truncDiv(gy, 100) + 1) * 3, 4) - 150;
    final march = 20 + leapJ - leapG;
    if (jump - n < 6) {
      n = n - jump + _truncDiv(jump + 4, 33) * 33;
    }
    var leap = _truncMod(_truncMod(n + 1, 33) - 1, 4);
    if (leap == -1) leap = 4;
    return (leap: leap, gy: gy, march: march);
  }

  static PersianDate _d2j(int jdn) {
    final gy = _d2g(jdn).gy;
    var jy = gy - 621;
    final r = _jalCal(jy);
    final jdn1f = _g2d(gy, 3, r.march);
    var k = jdn - jdn1f;
    int jm;
    int jd;
    if (k >= 0) {
      if (k <= 185) {
        jm = 1 + _truncDiv(k, 31);
        jd = _truncMod(k, 31) + 1;
        return PersianDate(jy, jm, jd);
      }
      k -= 186;
    } else {
      jy -= 1;
      k += 179;
      if (r.leap == 1) k += 1;
    }
    jm = 7 + _truncDiv(k, 30);
    jd = _truncMod(k, 30) + 1;
    return PersianDate(jy, jm, jd);
  }
}
