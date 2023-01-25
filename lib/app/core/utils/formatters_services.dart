class FormattersServices {
  static String formatIDs(List<String> value) {
    String result = '';
    for (final item in value) {
      result += item + ',';
    }
    return result;
  }
}
