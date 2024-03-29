import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class Utils {
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  static String formatNumber(double number) {
    final String locale = Intl.getCurrentLocale();
    return NumberFormat.decimalPattern(locale).format(number);
  }
}
