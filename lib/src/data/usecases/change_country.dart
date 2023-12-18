import 'package:ns_intl_phone_input/src/domain/usecases/change_country.dart';

import '../../domain/usecases/construct_lookup_map.dart';

class ChangeCountryImpl implements ChangeCountry {
  @override
  String call({
    required CountriesLookupMap countriesLookupMap,
    required String number,
    required String? newCountry,
  }) {
    if (newCountry == null || newCountry.isEmpty) return number;

    var curr = number;
    while (curr.isNotEmpty) {
      curr = curr.substring(0, curr.length - 1);
      if (countriesLookupMap.containsKey(curr)) {
        return number.replaceFirst(curr, newCountry);
      }
    }
    return '$newCountry$number';
  }
}
