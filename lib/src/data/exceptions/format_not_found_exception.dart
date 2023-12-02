class FormatNotFoundException implements Exception {
  final String? message;

  FormatNotFoundException([this.message]);

  @override
  String toString() {
    return '$message';
  }
}
