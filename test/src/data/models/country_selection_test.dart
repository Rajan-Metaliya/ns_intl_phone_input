import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  group(
    CountrySelection,
    () {
      test('CountrySelection instances with different properties are not equal',
          () {
        final country1 = CountryModel(
          countryName: 'India',
          regions: {'Asia'},
          iso2Code: 'in',
          intlDialCode: '91',
        );

        final country2 = CountryModel(
          countryName: 'USA',
          regions: {'North America'},
          iso2Code: 'us',
          intlDialCode: '1',
        );

        final selection1 = CountrySelection(
          selectedCountry: country1,
          formattedPhoneNumber: '+91 1234567890',
          unformattedPhoneNumber: '1234567890',
        );

        final selection2 = CountrySelection(
          selectedCountry: country2,
          formattedPhoneNumber: '+1 9876543210',
          unformattedPhoneNumber: '9876543210',
        );

        expect(selection1, isNot(equals(selection2)));
      });
    },
  );
}
