import '../models/country.dart';

typedef CountriesLookupMap = Map<String, CountryModel>;

abstract interface class ConstructLookupMap {
  CountriesLookupMap call(Iterable<CountryModel> countries);
}
