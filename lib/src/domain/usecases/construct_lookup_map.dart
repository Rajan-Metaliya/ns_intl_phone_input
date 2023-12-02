import '../entities/country.dart';

typedef CountriesLookupMap = Map<String, CountryEntity>;

abstract interface class ConstructLookupMap {
  CountriesLookupMap call(Iterable<CountryEntity> countries);
}
