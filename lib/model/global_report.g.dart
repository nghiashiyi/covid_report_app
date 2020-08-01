// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalReport _$GlobalReportFromJson(Map<String, dynamic> json) {
  return GlobalReport(
    json['totalConfirmed'] as int,
    json['TotalDeaths'] as int,
    json['TotalRecovered'] as int,
    (json['Countries'] as List)
        ?.map((e) => e == null
            ? null
            : CountryReport.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GlobalReportToJson(GlobalReport instance) =>
    <String, dynamic>{
      'totalConfirmed': instance.totalConfirmed,
      'TotalDeaths': instance.totalDeaths,
      'TotalRecovered': instance.totalRecovered,
      'Countries': instance.countries,
    };
