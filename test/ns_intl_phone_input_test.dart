import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/raw/raw_countries_js.dart';

void main() {
  test('adds one to input values', () {
    final countries = rawCountries
        .map(
          (e) => CountryModel.fromRawData(e),
        )
        .toList();

    // print(validateFormat('+1', '88888888888'));
    print(countries);
  });
}
