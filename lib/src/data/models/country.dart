import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/country.dart' as domain;

part 'country.g.dart';

@JsonSerializable()
class CountryModel extends domain.CountryEntity {
  CountryModel({
    required super.countryName,
    required super.regions,
    required super.iso2Code,
    required super.intlDialCode,
    super.format,
    super.orderPriority,
    super.areaCodes,
  });

  factory CountryModel.fromRawData(List<Object> list) => CountryModel(
        countryName: RetrieveValue(list)[0],
        regions: RetrieveValue<List<String>>(list)[1].toSet(),
        iso2Code: RetrieveValue(list)[2],
        intlDialCode: RetrieveValue<String>(list)[3],
        format: RetrieveValue<String?>(list)[4],
        orderPriority: RetrieveValue<int?>(list)[5],
        areaCodes: RetrieveValue<List<String>?>(list)[6]?.toSet(),
      );

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

extension RetrieveValue<T> on List {
  T operator [](int index) => index < length ? this[index] : null;
}
