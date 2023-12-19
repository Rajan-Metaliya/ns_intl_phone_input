import 'package:ns_intl_phone_input/src/data/models/country.dart';

class CountrySelection {
  final CountryModel selectedCountry;

  final String formattedPhoneNumber;

  final String unformattedPhoneNumber;

  CountrySelection({
    required this.selectedCountry,
    required this.formattedPhoneNumber,
    required this.unformattedPhoneNumber,
  });

  @override
  String toString() {
    return '''CountrySelection(
      selectedCountry: $selectedCountry, 
      formattedPhoneNumber: $formattedPhoneNumber, 
      unformattedPhoneNumber: $unformattedPhoneNumber
      )''';
  }
}
