import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/ns_intl_phone_input.dart';

void main() {
  group(
    CountrySelection,
    () {
      test('CountrySelection instances with different properties are not equal',
          () {
        const country1 = CountryModel(
          countryName: 'India',
          regions: {'Asia'},
          iso2Code: 'in',
          intlDialCode: '91',
          format: '.....-.....',
        );

        const country2 = CountryModel(
          countryName: 'USA',
          regions: {'North America'},
          iso2Code: 'us',
          intlDialCode: '1',
        );

        final selection1 = CountrySelection(
          selectedCountry: country1,
          formattedPhoneNumber: '12345-67890',
          unformattedPhoneNumber: '1234567890',
        );

        final selection2 = CountrySelection(
          selectedCountry: country2,
          formattedPhoneNumber: '9876543210',
          unformattedPhoneNumber: '9876543210',
        );

        expect(selection1, isNot(equals(selection2)));
      });

      test('Test the complete Formatted & UnFormatted Numbers', () {
        const country = CountryModel(
          countryName: 'India',
          regions: {"asia"},
          iso2Code: 'in',
          intlDialCode: '91',
          flag: '🇮🇳',
          format: '.....-.....',
        );

        final selection = CountrySelection(
            selectedCountry: country,
            formattedPhoneNumber: '98778-78998',
            unformattedPhoneNumber: '9877878998');

        expect(selection.completePhoneNumber, '91 9877878998');
        expect(selection.completeFormattedPhoneNumber, '91 98778-78998');
      });
    },
  );
}
