// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryReport _$CountryReportFromJson(Map<String, dynamic> json) {
  return CountryReport(
    json['Country'] as String,
    json['CountryCode'] as String,
    json['TotalConfirmed'] as int,
    json['TotalDeaths'] as int,
    json['TotalRecovered'] as int,
    json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
  );
}

Map<String, dynamic> _$CountryReportToJson(CountryReport instance) =>
    <String, dynamic>{
      'Country': instance.country,
      'CountryCode': instance.countryCode,
      'TotalConfirmed': instance.totalConfirmed,
      'TotalDeaths': instance.totalDeaths,
      'TotalRecovered': instance.totalRecovered,
      'Date': instance.ts?.toIso8601String(),
    };
