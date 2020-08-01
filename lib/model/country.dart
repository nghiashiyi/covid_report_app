import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

@JsonSerializable()

class CountryReport {
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'CountryCode')
  final String countryCode;
  @JsonKey(name: 'TotalConfirmed')
  final int totalConfirmed;
  @JsonKey(name: 'TotalDeaths')
  final int totalDeaths;
  @JsonKey(name: 'TotalRecovered')
  final int totalRecovered;
  @JsonKey(name: 'Date')
  final DateTime ts;

  CountryReport(this.country, this.countryCode, this.totalConfirmed, this.totalDeaths, this.totalRecovered, this.ts);

  factory CountryReport.fromJson(Map<String, dynamic> json) => _$CountryReportFromJson(json);
  Map<String, dynamic> toJson() => _$CountryReportToJson(this);
}