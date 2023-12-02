import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/usecases/validate_format.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/validate_format.dart';

void main() {
  late final ValidateFormat validateFormat;

  setUp(() {
    validateFormat = ValidateFormatImpl();
  });
  group('validate format test', () {
    test('positive', () {
      expect(
          validateFormat(
              numberWithoutCountryCode: '(204) 888-8888',
              format: '(...) ...-....'),
          '');
      expect(
          validateFormat(
              numberWithoutCountryCode: '888 888 888 888',
              format: '... ... ... ... ..'),
          '');
    });
  });
}
