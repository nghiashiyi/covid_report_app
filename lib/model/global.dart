import 'package:json_annotation/json_annotation.dart';
part 'global.g.dart';

@JsonSerializable()

class Global {
  @JsonKey(name: 'TotalConfirmed')
  final int totalConfirmed;
  @JsonKey(name: 'TotalDeaths')
  final int totalDeaths;
  @JsonKey(name: 'TotalRecovered')
  final int totalRecovered;

  Global(this.totalConfirmed, this.totalDeaths, this.totalRecovered);

  factory Global.fromJson(Map<String, dynamic> json) => _$GlobalFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalToJson(this);
}