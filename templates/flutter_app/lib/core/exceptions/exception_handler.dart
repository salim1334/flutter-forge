import 'package:<%= packageName %>/core/exceptions/app_exception.dart';
import 'package:<%= packageName %>/core/popups/app_popups.dart';

abstract final class ExceptionHandler {
  static void show(Object error) {
    final message = switch (error) {
      AppException e => e.message,
      _ => 'Something went wrong. Please try again.',
    };
    AppPopups.showErrorSnack(message);
  }
}
