import 'package:ns_intl_phone_input/src/domain/entities/country.dart';

extension CountriesMap on Iterable<CountryEntity> {
  Map<String, CountryEntity> nestedMap() {
    return fold(
      <String, Map<String, CountryEntity>>{},
      (value, element) {
        if (value[element.intlDialCode] != null) {
          value[element.intlDialCode]![element.iso2Code] = element;
        } else {
          value[element.intlDialCode] = {
            element.iso2Code: element,
          };
        }
        return value;
      },
    );
  }
}