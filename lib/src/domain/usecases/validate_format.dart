abstract interface class ValidateFormat {
  String call({
    required String format,
    required String numberWithoutCountryCode,
  });
}
