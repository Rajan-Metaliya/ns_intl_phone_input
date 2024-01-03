import '../models/country.dart';

typedef CountriesLookupMap = Map<String, CountryModel>;

abstract  class ConstructLookupMap {
  CountriesLookupMap call(Iterable<CountryModel> countries);
}
