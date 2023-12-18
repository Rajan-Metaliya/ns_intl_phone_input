import 'package:ns_intl_phone_input/src/domain/usecases/construct_lookup_map.dart';

abstract interface class QueryFormat {
  String call({
    required CountriesLookupMap countriesLookupMap,
    required String number,
  });
}
