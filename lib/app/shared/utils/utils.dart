import 'package:html/parser.dart';
import 'package:intl/intl.dart';

 class  Utils {


  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  String formatNumber(double number) {
    return NumberFormat.decimalPattern('en').format(number);
  }


}
