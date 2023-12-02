import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

void main() {
  test('fetchDigits', () {
    expect('+1(204) 888-8888'.fetchDigits, '12048888888');
  });
}
