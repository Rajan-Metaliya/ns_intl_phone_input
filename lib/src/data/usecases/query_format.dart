import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import '../../domain/entities/country.dart';
import '../../domain/usecases/query_format.dart' as domain;

typedef CountriesLookupMap = Map<String, CountryEntity>;

class QueryFormatImpl implements domain.QueryFormat {
  final Iterable<CountryEntity> countries;
  late final CountriesLookupMap lookupMap;
  static const defaultFormat = '... ... ... ... ..';

  QueryFormatImpl({required this.countries}) {
    lookupMap = _constructLookUpMap(countries);
  }

  @override
  String call(String number) {
    final mNumber = number.fetchDigits;
    /* todo: optimize this, we need not start from max length of the number we
        just need to consider country + area code length
    */

    var curr = mNumber;
    while (curr.isNotEmpty) {
      curr = curr.substring(0, curr.length - 1);
      if (lookupMap.containsKey(curr)) {
        final country = lookupMap[curr]!;
        if (country.format != null) {
          return country.format!;
        }
      }
    }
    return defaultFormat;
  }

  CountriesLookupMap _constructLookUpMap(Iterable<CountryEntity> countries) {
    final Map<String, CountryEntity> countriesMap = {};

    for (final country in countries) {
      final intlDialCode = country.intlDialCode;
      final areaCodes = country.areaCodes;

      if (areaCodes != null) {
        if (areaCodes.isEmpty) {
          countriesMap[intlDialCode] = country;
        } else {
          for (final region in areaCodes) {
            countriesMap['$intlDialCode$region'] = country;
          }
        }
      }
    }

    return countriesMap;
  }
}
