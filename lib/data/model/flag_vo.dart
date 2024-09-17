
import 'package:json_annotation/json_annotation.dart';
part 'flag_vo.g.dart';

@JsonSerializable()
class FlagVo{
  @JsonKey(name: 'png')
  String? png;

  @JsonKey(name: 'svg')
  String? svg;

  FlagVo(this.png, this.svg);

  factory FlagVo.fromJson(Map<String,dynamic> json) => _$FlagVoFromJson(json);

  Map<String,dynamic> toJson() => _$FlagVoToJson(this);
}