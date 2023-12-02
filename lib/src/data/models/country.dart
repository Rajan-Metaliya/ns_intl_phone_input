import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/country.dart' as domain;

part 'country.g.dart';

@JsonSerializable()
class CountryModel extends domain.CountryEntity {
  CountryModel({
    required final String countryName,
    required final Set<String> regions,
    required final String iso2Code,
    required final String intlDialCode,
    final String? format,
    final int? orderPriority,
    final Set<String>? areaCodes,
  }) : super(
          countryName: countryName,
          regions: regions,
          iso2Code: iso2Code,
          intlDialCode: intlDialCode,
          format: format,
          orderPriority: orderPriority,
          areaCodes: areaCodes,
        );

  static domain.CountryEntity fromRawData(List<Object> list) =>
      domain.CountryEntity(
        countryName: RetrieveValue(list)[0],
        regions: RetrieveValue<List<String>>(list)[1].toSet(),
        iso2Code: RetrieveValue(list)[2],
        intlDialCode: RetrieveValue<String>(list)[3],
        format: RetrieveValue<String?>(list)[4],
        orderPriority: RetrieveValue<int?>(list)[5],
        areaCodes: RetrieveValue<List<String>?>(list)[6]?.toSet(),
      );

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}

extension RetrieveValue<T> on List {
  T operator [](int index) => index < length ? this[index] : null;
}
