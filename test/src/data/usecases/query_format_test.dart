import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/usecases/construct_lookup_map.dart';
import 'package:ns_intl_phone_input/src/data/usecases/query_format.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/construct_lookup_map.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/query_format.dart';
import 'package:ns_intl_phone_input/src/raw/raw_countries.dart';

void main() {
  late final QueryFormat queryFormat;
  late final CountriesLookupMap countriesLookupMap;

  setUp(() {
    queryFormat = QueryFormatImpl();
    countriesLookupMap = ConstructLookupMapImpl()(
      rawCountries.map(
        (e) => CountryModel.fromRawData(e),
      ),
    );
  });
  group(
      'query format test: check if right query format is fetched based on '
      'initial digits', () {
    test('positive', () {
      expect(
        queryFormat(
            countriesLookupMap: countriesLookupMap, number: '+120488888888'),
        '+. (...) ...-....',
      );

      expect(
          queryFormat(
            countriesLookupMap: countriesLookupMap,
            number: '+10488888888',
          ),
          '... ... ... ... ..');
    });
  });
}
