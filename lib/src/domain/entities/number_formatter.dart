abstract interface class NumberFormatter {
  String? queryFormat(String number);

  String validateFormat(String number, String format);

  String format(String number, String format);
}
