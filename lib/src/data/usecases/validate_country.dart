import '../../domain/entities/country.dart';
import '../../domain/usecases/validate_country.dart' as domain;

class ValidateCountryImpl implements domain.ValidateCountry {
  @override
  final Map<String, CountryEntity> countries;

  ValidateCountryImpl({required this.countries});

  @override
  String call(String value) {
    return '';
  }
}
