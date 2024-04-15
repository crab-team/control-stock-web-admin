import 'package:intl/intl.dart';

class CurrencyUtils {
  static String formatCurrency(String value, {int fractionDigits = 2}) {
    ArgumentError.checkNotNull(value, 'value');
    return NumberFormat.currency(customPattern: '###.###,##', locale: 'es_AR').format(value);
  }
}
