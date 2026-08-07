import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static String formatCurrency(double amount, {String currency = '\$'}) {
    return '${amount.toStringAsFixed(0)} $currency';
  }

  static String formatDate(DateTime value, {String? locale}) {
    return DateFormat.yMMMd(locale).format(value);
  }
}
