import 'package:ns_intl_phone_input/src/utils/raw_contries_js.dart';

void main() {
  for (int i = 0; i < rawCountriesJs.length; i++) {
    var country = rawCountriesJs[i][0];

    print('''
     CountyModel(
      countryName: $country,
      iso2Code: 'AF',
      intlDialCode: '93',
      format: 'xxx xxx xxxx',
      areaCodes: [],
      regions: [],
  ),
''');
  }
}
