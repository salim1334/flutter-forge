import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  late final Logger _logger;

  AppLogger() {
    _logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true),
      level: kDebugMode ? Level.debug : Level.warning,
    );
  }

  void debug(dynamic message) => _logger.d(message);
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message, [Object? error, StackTrace? stack]) {
    _logger.e(message, error: error, stackTrace: stack);
  }
}
