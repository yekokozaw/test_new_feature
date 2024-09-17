
import 'package:json_annotation/json_annotation.dart';
import 'package:test_new_feature/data/model/flag_vo.dart';

import 'country_name_vo.dart';
part 'country_list_model.g.dart';

@JsonSerializable()
class CountryListModel{

  @JsonKey(name: 'flags')
  FlagVo? flag;

  @JsonKey(name: 'name')
  CountryNameVo? countryName;

  CountryListModel(this.flag, this.countryName);

  factory CountryListModel.fromJson(Map<String,dynamic> json) => _$CountryListModelFromJson(json);

  Map<String,dynamic> toJson() => _$CountryListModelToJson(this);
}