import 'package:flutter_test/flutter_test.dart';
import 'package:ns_intl_phone_input/src/data/models/country.dart';
import 'package:ns_intl_phone_input/src/data/usecases/query_format.dart';
import 'package:ns_intl_phone_input/src/domain/usecases/query_format.dart';
import 'package:ns_intl_phone_input/src/raw/raw_countries_js.dart';

void main() {
  late final QueryFormat queryFormat;

  setUp(() {
    queryFormat = QueryFormatImpl(
      countries: rawCountries.map(
            (e) => CountryModel.fromRawData(e),
      ),
    );
  });
  group(
      'query format test: check if right query format is fetched based on '
          'initial digits', () {
    test('positive', () {
      expect(queryFormat('+120488888888'), '(...) ...-....');
      expect(queryFormat('+10488888888'), '... ... ... ... ..');
    });
  });
}
