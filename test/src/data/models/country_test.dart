import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';

void main() {
  group(CountryModel, () {
    test('isContain returns true for matching countryName', () {
      final country = CountryModel(
          countryName: 'India',
          regions: {'Asia'},
          iso2Code: 'in',
          intlDialCode: '91',
          format: '.....-.....');

      expect(country.isContain('India'), isTrue);
      expect(country.format, '.....-.....');
    });

    test('isContain returns true for matching intlDialCode', () {
      final country = CountryModel(
        countryName: 'USA',
        regions: {'North America'},
        iso2Code: 'us',
        intlDialCode: '1',
      );

      expect(country.isContain('1'), isTrue);
    });

    test('isContain returns true for matching areaCodes', () {
      final country = CountryModel(
        countryName: 'Dominican Republic',
        regions: {"america", "carribean"},
        iso2Code: 'do',
        intlDialCode: '1',
        flag: '🇩🇴',
        orderPriority: 2,
        areaCodes: {"809", "829", "849"},
      );

      expect(country.isContain('829'), isTrue);
    });

    test('isContain returns true for matching regions', () {
      final country = CountryModel(
        countryName: 'India',
        regions: {'Asia'},
        iso2Code: 'in',
        intlDialCode: '91',
      );

      expect(country.isContain('Asia'), isTrue);
    });

    test('isContain returns true for matching iso2Code', () {
      final country = CountryModel(
        countryName: 'India',
        regions: {'Asia'},
        iso2Code: 'in',
        intlDialCode: '91',
      );

      expect(country.isContain('in'), isTrue);
    });

    test('dialCode returns correct value with areaCode', () {
      final country = CountryModel(
        countryName: 'India',
        regions: {'Asia'},
        iso2Code: 'in',
        intlDialCode: '91',
        areaCodes: {'123'},
        currentAreaCode: '123',
      );

      expect(country.dialCode, equals('91 (123)'));
    });

    test('copyWith creates a new instance with updated values', () {
      final original = CountryModel(
        countryName: 'India',
        regions: {'Asia'},
        iso2Code: 'in',
        intlDialCode: '91',
      );

      final updated = original.copyWith(countryName: 'Andorra', flag: '🇦🇩');

      expect(updated.countryName, equals('Andorra'));
      expect(updated.flag, equals('🇦🇩'));
    });
  });
}
