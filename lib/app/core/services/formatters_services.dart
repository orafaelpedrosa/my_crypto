import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';

class FormattersServices {
  static String formatIDs(List<String> value) {
    String result = '';
    for (final item in value) {
      result += item + ',';
    }
    return result;
  }

  static String formatDateTime(DateTime value) {
    final now = DateTime.now();
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm');

    if (value.day == now.day &&
        value.month == now.month &&
        value.year == now.year) {
      return 'Hoje, ${timeFormatter.format(value)}';
    } else {
      return '${dateFormatter.format(value)}, ${timeFormatter.format(value)}';
    }
  }

  static String priceInCurrencyFormat(String price) {
    final UserStore userStore = Modular.get();

    final vsCurrency = userStore.state.userPreference.vsCurrency;

    switch (vsCurrency) {
      case "USD":
        return "\$ $price";
      case "BRL":
        return "R\$ $price";
      default:
        return "\$ $price";
    }
  }

  static String formatDateinISO(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static formatDateBR(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
