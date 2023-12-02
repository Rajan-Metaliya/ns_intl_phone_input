import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/usecases/validate_country.dart';
import 'package:ns_intl_phone_input/src/data/usecases/validate_format.dart';
import 'package:ns_intl_phone_input/src/data/utils/extensions.dart';

import 'src/raw/raw_countries.dart';

void main() {
  final countries = rawCountries
      .map(
        (e) => CountryModel.fromRawData(e),
      )
      .toSet()
      .nestedMap();

  final validateCountry = ValidateCountryImpl(countries: countries);
  final validateFormat = ValidateFormatImpl(countries: countries);

  // print(validateFormat('+1', '88888888888'));
  print(countries);
}
