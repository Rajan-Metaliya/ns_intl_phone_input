class CountyModel {
  final String countryName;
  final String iso2Code;
  final String intlDialCode;
  final String? format;
  final List<String> areaCodes;
  final List<String> regions;

  CountyModel({
    required this.countryName,
    required this.iso2Code,
    required this.intlDialCode,
    this.format,
    this.areaCodes = const [],
    this.regions = const [],
  });
}
