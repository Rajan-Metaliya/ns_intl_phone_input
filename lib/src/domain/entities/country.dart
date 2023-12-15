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

  CountryEntity({
    required this.countryName,
    required this.regions,
    required this.iso2Code,
    required this.intlDialCode,
    this.flag = '🏳️',
    this.format,
    this.orderPriority,
    this.areaCodes,
  });
}
