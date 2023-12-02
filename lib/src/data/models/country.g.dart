// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      countryName: json['countryName'] as String,
      regions:
          (json['regions'] as List<dynamic>).map((e) => e as String).toSet(),
      iso2Code: json['iso2Code'] as String,
      intlDialCode: json['intlDialCode'] as String,
      format: json['format'] as String?,
      orderPriority: json['orderPriority'] as int?,
      areaCodes: (json['areaCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'countryName': instance.countryName,
      'regions': instance.regions.toList(),
      'iso2Code': instance.iso2Code,
      'intlDialCode': instance.intlDialCode,
      'format': instance.format,
      'orderPriority': instance.orderPriority,
      'areaCodes': instance.areaCodes?.toList(),
    };
