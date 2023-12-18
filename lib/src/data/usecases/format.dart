import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/usecases/format.dart' as domain;

/*
  todo: need to combine these two use cases
   that is validate will return how much of the number needs to be formatted and
   trim the format as well, so that only remaining part of the number is
   formatted instead of starting from beginning
 */
class FormatImpl implements domain.Format {
  @override
  String call({required String number, required final String format}) {
    return NumberFormatter.format(number, format);
  }
}

const maxNumberLength = 15;

class NumberFormatter {
  /*
    todo:  This is a temporary solution. Ideally we should use regex for this.
     continuing with this approach for now, since converting dot format to regex
     will take time
  */
  static String format(String number, final String format) {
    StringBuffer formattedNumber = StringBuffer();
    number = number.fetchDigits;
    if (number.length > maxNumberLength) {
      number = number.substring(0, maxNumberLength);
    }

    int numberPointer = 0;
    int formatPointer = 0;

    while (formatPointer < format.length && numberPointer < number.length) {
      final currNumberChar = number[numberPointer];
      final currFormatChar = format[formatPointer];

      if (currFormatChar == '.') {
        formattedNumber.write(currNumberChar);
        numberPointer++;
        formatPointer++;
      } else {
        formattedNumber.write(currFormatChar);
        formatPointer++;
      }
    }

    return formattedNumber.toString();
  }
}
