import 'construct_lookup_map.dart';

abstract interface class ChangeCountry {
  String call({
    required CountriesLookupMap countriesLookupMap,
    required String number,
    required String? newCountry,
  });
}
