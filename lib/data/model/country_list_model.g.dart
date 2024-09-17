// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListModel _$CountryListModelFromJson(Map<String, dynamic> json) =>
    CountryListModel(
      json['flags'] == null
          ? null
          : FlagVo.fromJson(json['flags'] as Map<String, dynamic>),
      json['name'] == null
          ? null
          : CountryNameVo.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryListModelToJson(CountryListModel instance) =>
    <String, dynamic>{
      'flags': instance.flag,
      'name': instance.countryName,
    };
