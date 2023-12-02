import 'dart:convert';

import 'package:ns_intl_phone_input/src/data/models/country.dart';

import 'src/raw/raw_countries_js.dart';

void main() {
  final countries = rawCountries
      .map(
        (e) => CountryModel.fromRawData(e),
      )
      .toList()
    ..sort((a, b) => a.countryName.compareTo(b.countryName));
  // final countriesMap = countries.processedMap();

  // final QueryFormat queryFormat = QueryFormatImpl(countries: countriesMap);
  // final ValidateFormat validateFormat = ValidateFormatImpl(countries: countriesMap);

  // print(validateFormat('+1', '88888888888'));
  for (int i = 100; i < countries.length; i++) {
    final value = countries[i];
    print("CountryEntity(");
    print("countryName: '${value.countryName}', ");
    print(
        "regions: ${json.encode(value.regions.toList()).replaceAll('[', '{').replaceAll(']', '}')}, ");
    print("iso2Code: '${value.iso2Code}',");
    print(" intlDialCode: '${value.intlDialCode}', ");

    if (value.format != null) {
      print("format: '${value.format}', ");
    }
    if (value.orderPriority != null) {
      print("orderPriority: ${value.orderPriority}, ");
    }
    if (value.areaCodes != null) {
      print(
          "areaCodes: ${json.encode(value.areaCodes!.toList()).replaceAll('[', '{').replaceAll(']', '}')}, ");
    }
    print("),");
  }
  // print(countriesMap);
}
