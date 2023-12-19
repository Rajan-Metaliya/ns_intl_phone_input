import '../models/country.dart';
import 'construct_lookup_map.dart';

class ConstructLookupMapImpl implements ConstructLookupMap {
  @override
  CountriesLookupMap call(Iterable<CountryModel> countries) {
    final Map<String, CountryModel> countriesMap = {};

    for (final country in countries) {
      final intlDialCode = country.intlDialCode;
      final areaCodes = country.areaCodes;

      if (areaCodes == null || areaCodes.isEmpty) {
        countriesMap[intlDialCode] = country;
      } else {
        for (final region in areaCodes) {
          countriesMap['$intlDialCode ($region)'] = country.copyWith(
            currentAreaCode: region,
          );
        }
      }
    }

    return countriesMap;
  }
}
