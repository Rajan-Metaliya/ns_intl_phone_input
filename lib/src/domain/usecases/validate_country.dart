import 'package:ns_intl_phone_input/src/domain/usecases/mixin/countries_map.dart';

abstract interface class ValidateCountry with CountriesMap {
  String call(String value);
}
