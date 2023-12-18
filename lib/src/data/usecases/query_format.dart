import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/usecases/construct_lookup_map.dart';
import '../../domain/usecases/query_format.dart' as domain;

class QueryFormatImpl implements domain.QueryFormat {
  static const defaultFormat = '... ... ... ... ..';

  QueryFormatImpl();

  @override
  String call({
    required CountriesLookupMap countriesLookupMap,
    required String number,
  }) {
    final mNumber = number.fetchDigits;
    /* todo: optimize this, we need not start from max length of the number we
        just need to consider country + area code length
    */

    var curr = mNumber;
    while (curr.isNotEmpty) {
      if (countriesLookupMap.containsKey(curr)) {
        final country = countriesLookupMap[curr]!;
        if (country.format != null) {
          return '+${'.' * country.intlDialCode.length} ${country.format!}';
        }
      }
      curr = curr.substring(0, curr.length - 1);
    }
    return defaultFormat;
  }
}
