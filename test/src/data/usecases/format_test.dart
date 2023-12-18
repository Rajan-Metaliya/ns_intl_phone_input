import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/usecases/format.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/format.dart';

void main() {
  late final Format format;

  setUp(() {
    format = FormatImpl();
  });

  group('format the number', () {
    test('positive', () {
      // expect(
      //   format(number: '8888888888', format: '(...) ...-....'),
      //   '(888) 888-8888',
      // );

      expect(
        format(number: '88 88 888 8', format: '(...) ...-....'),
        '(888) 888-88',
      );
    });
  });
}
