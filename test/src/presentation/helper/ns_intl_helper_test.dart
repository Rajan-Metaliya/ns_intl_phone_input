import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  group(
    'NsIntlPhoneHelper',
    () {
      test(
        'getUnMaskedPhoneNumber getUnMaskedPhoneNumber',
        () {
          final result = NSIntlPhoneHelper.getUnMaskedPhoneNumber(
            phoneNumber: '98765-43210',
          );
          expect(result, '9876543210');
        },
      );
    },
  );
}
