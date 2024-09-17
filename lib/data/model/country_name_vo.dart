
import 'package:json_annotation/json_annotation.dart';
part 'country_name_vo.g.dart';

@JsonSerializable()
class CountryNameVo{
  @JsonKey(name: 'common')
  String? commonName;

  @JsonKey(name: 'official')
  String? officialName;

  CountryNameVo(this.commonName, this.officialName);

  factory CountryNameVo.fromJson(Map<String,dynamic> json) => _$CountryNameVoFromJson(json);

  Map<String,dynamic> toJson() => _$CountryNameVoToJson(this);
}