import '../../domain/entities/country.dart';
import '../../domain/usecases/construct_lookup_map.dart';

class ConstructLookupMapImpl implements ConstructLookupMap {
  @override
  CountriesLookupMap call(Iterable<CountryEntity> countries) {
    final Map<String, CountryEntity> countriesMap = {};

    for (final country in countries) {
      final intlDialCode = country.intlDialCode;
      final areaCodes = country.areaCodes;

      if (areaCodes == null || areaCodes.isEmpty) {
        countriesMap[intlDialCode] = country;
      } else {
        for (final region in areaCodes) {
          countriesMap['$intlDialCode$region'] = country;
        }
      }
    }

    return countriesMap;
  }
}
