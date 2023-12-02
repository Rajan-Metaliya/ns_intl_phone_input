class CountryNotFoundException implements Exception {
  final String? message;

  CountryNotFoundException([this.message]);

  @override
  String toString() {
    return '$message';
  }
}
