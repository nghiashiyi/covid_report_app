import 'package:covid_app/model/country.dart';
import 'package:json_annotation/json_annotation.dart';
part 'global_report.g.dart';

@JsonSerializable()

class GlobalReport {
  final int totalConfirmed;
  @JsonKey(name: 'TotalDeaths')
  final int totalDeaths;
  @JsonKey(name: 'TotalRecovered')
  final int totalRecovered;
  @JsonKey(name: 'Countries')
  final List<CountryReport> countries;


  GlobalReport(this.totalConfirmed, this.totalDeaths, this.totalRecovered,
      this.countries);

  factory GlobalReport.fromJson(Map<String, dynamic> json) => _$GlobalReportFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalReportToJson(this);
}