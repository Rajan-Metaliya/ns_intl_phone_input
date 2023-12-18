// ignore_for_file: public_member_api_docs, sort_constructors_first
class CountryEntity {
  ///for ex. India/
  final String countryName;

  ///for ex. [Asia]/
  final Set<String> regions;

  ///for ex. in/
  final String iso2Code;

  final String flag;

  ///for ex. 91/
  final String intlDialCode;

  ///for ex. '.....-.....'/
  final String? format;

  ///if >1 country with same dial code
  final int? orderPriority;

  ///if >1 country with same dial code
  final Set<String>? areaCodes;

  final String currentAreaCode;

  String get dialCode =>
      '$intlDialCode${currentAreaCode.isNotEmpty ? ' ($currentAreaCode)' : ''}';

  bool isContain(String value) {
    return countryName.toLowerCase().contains(value.toLowerCase()) ||
        intlDialCode.contains(value) ||
        (areaCodes != null &&
            areaCodes!.any((element) => element.contains(value))) ||
        regions.any(
            (element) => element.toLowerCase().contains(value.toLowerCase())) ||
        iso2Code.toLowerCase().contains(value.toLowerCase());
  }

  CountryEntity({
    required this.countryName,
    required this.regions,
    required this.iso2Code,
    required this.intlDialCode,
    this.flag = '🏳️',
    this.format,
    this.orderPriority,
    this.areaCodes,
    this.currentAreaCode = '',
  });

  CountryEntity copyWith({
    String? countryName,
    Set<String>? regions,
    String? iso2Code,
    String? flag,
    String? intlDialCode,
    String? format,
    int? orderPriority,
    Set<String>? areaCodes,
    String? currentAreaCode,
  }) {
    return CountryEntity(
      countryName: countryName ?? this.countryName,
      regions: regions ?? this.regions,
      iso2Code: iso2Code ?? this.iso2Code,
      flag: flag ?? this.flag,
      intlDialCode: intlDialCode ?? this.intlDialCode,
      format: format ?? this.format,
      orderPriority: orderPriority ?? this.orderPriority,
      areaCodes: areaCodes ?? this.areaCodes,
      currentAreaCode: currentAreaCode ?? this.currentAreaCode,
    );
  }
}
