// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_name_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryNameVo _$CountryNameVoFromJson(Map<String, dynamic> json) =>
    CountryNameVo(
      json['common'] as String?,
      json['official'] as String?,
    );

Map<String, dynamic> _$CountryNameVoToJson(CountryNameVo instance) =>
    <String, dynamic>{
      'common': instance.commonName,
      'official': instance.officialName,
    };
