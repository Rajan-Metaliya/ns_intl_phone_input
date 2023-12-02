extension FetchDigit on String {
  String get fetchDigits {
    return split('').where((e) => int.tryParse(e) != null).join('');
  }
}
