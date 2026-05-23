import 'package:intl/intl.dart';

class AppFormatter {
  AppFormatter._();

  static final DateFormat _dateFormat = DateFormat.yMMMd();
  static final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '\$');

  static String formatDate(DateTime date) => _dateFormat.format(date);

  static String formatCurrency(num amount) => _currencyFormat.format(amount);

  static String formatPhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) return raw;
    return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6, 10)}';
  }
}
