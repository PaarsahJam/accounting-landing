import 'dart:developer' as developer;

class AppLogger {
  const AppLogger._();

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: 'accounting_app',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message) {
    developer.log(message, name: 'accounting_app');
  }

  static void warning(String message, {Object? error}) {
    developer.log(message, name: 'accounting_app', error: error);
  }
}
