import 'dart:math';

import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/usecases/validate_format.dart' as domain;

class ValidateFormatImpl implements domain.ValidateFormat {
  @override
  String call({
    required String numberWithoutCountryCode,
    required String format,
  }) {
    return NumberMatcher.match(numberWithoutCountryCode, format)
        ? ''
        // todo: add proper error messages
        : 'invalid format';
  }
}

enum CountryCodeValidationResult {
  formatNotFound,
}

class NumberMatcher {
  // todo:  This is a temporary solution. Ideally we should use regex for this.
  // continuing with this approach for now, since converting dot format to regex
  // will take time
  static bool match(String number, String format) {
    if (number.fetchDigits.length > 15) {
      return false;
    }

    if (number.length > format.length) {
      return false;
    }

    int mMin = min(number.length, format.length);
    int pointer = 0;

    while (pointer < mMin) {
      final currNumberChar = number[pointer];
      final currFormatChar = format[pointer];
      if (currFormatChar == '.') {
        if (int.tryParse(currNumberChar) == null) {
          return false;
        }
      } else if (currFormatChar != currNumberChar) {
        return false;
      }
      pointer++;
    }

    return true;
  }
}
