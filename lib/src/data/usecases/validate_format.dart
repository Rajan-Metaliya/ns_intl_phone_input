import 'dart:math';

import 'package:ns_intl_phone_input/src/data/exceptions/format_not_found_exception.dart';
import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/entities/country.dart';
import '../../domain/usecases/validate_format.dart' as domain;
import '../exceptions/country_not_found_exception.dart';

class ValidateFormatImpl implements domain.ValidateFormat {
  @override
  final Map<String, CountryEntity> countries;

  ValidateFormatImpl({required this.countries});

  @override
  String call(String number) {
    final dialCodeGroup = countries[countryCode];
    if (dialCodeGroup == null) {
      throw CountryNotFoundException();
    } else {
      final format = dialCodeGroup;
      if (format == null) {
        // todo: handle this in presentation layer
        throw FormatNotFoundException();
      } else {
        final regex = RegExp(format);
        if (regex.hasMatch(number)) return 'valid';
      }
    }

    return 'error';
  }
}

enum CountryCodeValidationResult {
  formatNotFound,
}

class NumberMatcher {
  // This is a temporary solution. Ideally we should use regex for this.
  // continuing with this approach for now, since converting dot format to regex
  // will take time
  static bool match(String number, String format) {
    if (number.length > format.length) {
      return false;
    }

    int mMax = max(number.length, format.length);
    int pointer = 0;

    while (pointer < mMax) {
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

void main() {
  print(NumberMatcher.match('(88) 88888888', '(..) ........'));
}
