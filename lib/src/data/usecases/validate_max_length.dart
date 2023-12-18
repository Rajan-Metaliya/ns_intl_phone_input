import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/usecases/validate_max_length.dart';

class ValidateMaxLengthImpl implements ValidateMaxLength {
  @override
  String call({required String number}) {
    return number.fetchDigits.length > 15
        ? 'should not exceed 15 digits length'
        : '';
  }
}
